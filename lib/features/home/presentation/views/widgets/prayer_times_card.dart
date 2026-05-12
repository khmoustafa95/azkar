import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart' as adhan;
import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

/// Offline prayer-times card for the two holy cities.
///
/// Renders an elegant header with the current Hijri date, a pill-style toggle
/// to switch between Mecca and Medina, a live next-prayer banner with a 1s
/// countdown, and a list of the six daily prayer events with their times.
///
/// All times are calculated locally via [adhan_dart] using the Umm al-Qura
/// method, so the widget works fully offline. Wall-clock times are always
/// shown in Mecca / Medina local time (Asia/Riyadh = UTC+3, no DST).
class PrayerTimesCard extends StatefulWidget {
  const PrayerTimesCard({super.key});

  @override
  State<PrayerTimesCard> createState() => _PrayerTimesCardState();
}

// ─────────────────────────────────────────────────────────────────────────────
// Brand palette (kept consistent with the rest of the Hajj home screen).
// ─────────────────────────────────────────────────────────────────────────────
const Color _primaryGreen = Color(0xFF0F5847);
const Color _darkGreen = Color(0xFF083A30);
const Color _gold = Color(0xFFC9A961);
const Color _goldSoft = Color(0xFFE8D9A8);
const Color _ink = Color(0xFF1A2421);
const Color _muted = Color(0xFF6B7570);

// Both Mecca and Medina are in Asia/Riyadh, fixed at UTC+3 year-round.
const Duration _meccaOffset = Duration(hours: 3);

class _City {
  const _City(this.name, this.subtitle, this.latitude, this.longitude);
  final String name;
  final String subtitle;
  final double latitude;
  final double longitude;
}

const List<_City> _cities = [
  _City('مكة المكرمة', 'المسجد الحرام', 21.4225, 39.8262),
  _City('المدينة المنورة', 'المسجد النبوي', 24.4682, 39.6112),
];

/// Internal data class for a single prayer row.
class _SalahRow {
  const _SalahRow(this.name, this.icon, this.color, this.utcTime, this.isMain);
  final String name;
  final IconData icon;
  final Color color;
  final DateTime utcTime;
  final bool isMain; // false for sunrise (non-obligatory)

  DateTime get meccaTime => utcTime.add(_meccaOffset);
}

class _PrayerTimesCardState extends State<PrayerTimesCard> {
  Timer? _ticker;
  int _cityIndex = 0;
  late DateTime _calcDay;
  late adhan.PrayerTimes _meccaTimes;
  late adhan.PrayerTimes _medinaTimes;

  @override
  void initState() {
    super.initState();
    _calcDay = _meccaCalendarDay();
    _computeTimes();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final today = _meccaCalendarDay();
      if (today != _calcDay) {
        _calcDay = today;
        _computeTimes();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  /// Returns midnight-UTC of the current calendar day **in Mecca time**.
  /// This stays correct regardless of the device's timezone.
  DateTime _meccaCalendarDay() {
    final mecca = DateTime.now().toUtc().add(_meccaOffset);
    return DateTime.utc(mecca.year, mecca.month, mecca.day);
  }

  void _computeTimes() {
    final params = adhan.CalculationMethodParameters.ummAlQura();
    params.madhab = adhan.Madhab.shafi;
    _meccaTimes = adhan.PrayerTimes(
      date: _calcDay,
      coordinates: const adhan.Coordinates(21.4225, 39.8262),
      calculationParameters: params,
    );
    _medinaTimes = adhan.PrayerTimes(
      date: _calcDay,
      coordinates: const adhan.Coordinates(24.4682, 39.6112),
      calculationParameters: params,
    );
  }

  adhan.PrayerTimes get _times => _cityIndex == 0 ? _meccaTimes : _medinaTimes;

  List<_SalahRow> _rowsFor(adhan.PrayerTimes t) => [
        _SalahRow('الفجر', Icons.nightlight_round, const Color(0xFF335B8A),
            t.fajr, true),
        _SalahRow('الشروق', Icons.wb_twilight_rounded, const Color(0xFFE0A24B),
            t.sunrise, false),
        _SalahRow('الظهر', Icons.wb_sunny_rounded, const Color(0xFFE0962D),
            t.dhuhr, true),
        _SalahRow(
            'العصر', Icons.sunny_snowing, const Color(0xFFC8771C), t.asr, true),
        _SalahRow('المغرب', Icons.wb_twilight, const Color(0xFFB85A33),
            t.maghrib, true),
        _SalahRow('العشاء', Icons.dark_mode_rounded, const Color(0xFF3D4E7E),
            t.isha, true),
      ];

  /// Returns the next obligatory prayer (sunrise excluded), wrapping to the
  /// next day's Fajr after Isha.
  _SalahRow _nextPrayer(List<_SalahRow> rows) {
    final now = DateTime.now().toUtc();
    for (final r in rows) {
      if (!r.isMain) continue;
      if (r.utcTime.isAfter(now)) return r;
    }
    // After Isha → next day's Fajr.
    return _SalahRow('الفجر', Icons.nightlight_round,
        const Color(0xFF335B8A), _times.fajrAfter, true);
  }

  @override
  Widget build(BuildContext context) {
    final rows = _rowsFor(_times);
    final next = _nextPrayer(rows);
    final city = _cities[_cityIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _goldSoft.withValues(alpha: 0.7), width: 1),
            boxShadow: [
              BoxShadow(
                color: _primaryGreen.withValues(alpha: 0.10),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(city: city),
              const SizedBox(height: AppSize.s14),
              _CitySwitcher(
                selected: _cityIndex,
                onChanged: (i) => setState(() => _cityIndex = i),
              ),
              const SizedBox(height: AppSize.s14),
              _NextPrayerBanner(next: next),
              const SizedBox(height: AppSize.s10),
              _PrayerList(rows: rows, nextUtc: next.utcTime),
              const _MethodFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.city});
  final _City city;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
          AppSize.s18, AppSize.s16, AppSize.s18, AppSize.s16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_darkGreen, _primaryGreen],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppSize.s14),
              border: Border.all(color: _gold.withValues(alpha: 0.45)),
            ),
            child: const Icon(Icons.mosque_rounded, color: _gold, size: 24),
          ),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'مواقيت الصلاة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Cairo',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  arNumber(getHijriDate()),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.5,
                    fontFamily: 'Cairo',
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSize.s10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_rounded,
                    size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  'بدون اتصال',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// City switcher (segmented pill)
// ─────────────────────────────────────────────────────────────────────────────

class _CitySwitcher extends StatelessWidget {
  const _CitySwitcher({required this.selected, required this.onChanged});
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F1),
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        child: Row(
          children: [
            for (var i = 0; i < _cities.length; i++)
              Expanded(
                child: _CityChip(
                  city: _cities[i],
                  selected: i == selected,
                  onTap: () => onChanged(i),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CityChip extends StatelessWidget {
  const _CityChip({
    required this.city,
    required this.selected,
    required this.onTap,
  });
  final _City city;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: AppSize.s10),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(
                  colors: [_primaryGreen, _darkGreen],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )
              : null,
          borderRadius: BorderRadius.circular(AppSize.s12),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _primaryGreen.withValues(alpha: 0.22),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              city.name,
              style: TextStyle(
                color: selected ? Colors.white : _ink,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                fontFamily: 'Cairo',
                height: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              city.subtitle,
              style: TextStyle(
                color: selected ? _goldSoft : _muted,
                fontSize: 10.5,
                fontFamily: 'Cairo',
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Next-prayer banner with live countdown
// ─────────────────────────────────────────────────────────────────────────────

class _NextPrayerBanner extends StatelessWidget {
  const _NextPrayerBanner({required this.next});
  final _SalahRow next;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    var remaining = next.utcTime.difference(now);
    if (remaining.isNegative) remaining = Duration.zero;

    final hh = remaining.inHours;
    final mm = remaining.inMinutes.remainder(60);
    final ss = remaining.inSeconds.remainder(60);
    final countdown = arNumber(
      '${hh.toString().padLeft(2, '0')}:${mm.toString().padLeft(2, '0')}:${ss.toString().padLeft(2, '0')}',
    );

    final timeStr = arTime(_formatTime(next.meccaTime));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            AppSize.s14, AppSize.s12, AppSize.s14, AppSize.s12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _gold.withValues(alpha: 0.18),
              _gold.withValues(alpha: 0.06),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(AppSize.s16),
          border: Border.all(color: _gold.withValues(alpha: 0.45)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(next.icon, color: next.color, size: 22),
            ),
            const SizedBox(width: AppSize.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text(
                        'الصلاة القادمة',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 11.5,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          next.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'متبقي $countdown',
                    style: const TextStyle(
                      color: _darkGreen,
                      fontSize: 18,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'وقت الأذان',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 10.5,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeStr,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 14.5,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Prayer list (the six rows)
// ─────────────────────────────────────────────────────────────────────────────

class _PrayerList extends StatelessWidget {
  const _PrayerList({required this.rows, required this.nextUtc});
  final List<_SalahRow> rows;
  final DateTime nextUtc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s14, vertical: 6),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            _PrayerRow(
              row: rows[i],
              isNext: rows[i].isMain && rows[i].utcTime == nextUtc,
            ),
            if (i != rows.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                color: const Color(0xFFEFEFEF).withValues(alpha: 0.9),
              ),
          ],
        ],
      ),
    );
  }
}

class _PrayerRow extends StatelessWidget {
  const _PrayerRow({required this.row, required this.isNext});
  final _SalahRow row;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    final time = arTime(_formatTime(row.meccaTime));

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s4, vertical: AppSize.s10),
      decoration: isNext
          ? BoxDecoration(
              color: _primaryGreen.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppSize.s12),
            )
          : null,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: row.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            child: Icon(row.icon, color: row.color, size: 18),
          ),
          const SizedBox(width: AppSize.s12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  row.name,
                  style: TextStyle(
                    color: _ink,
                    fontSize: 14.5,
                    fontWeight: row.isMain ? FontWeight.w800 : FontWeight.w600,
                    fontFamily: 'Cairo',
                  ),
                ),
                if (!row.isMain) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0962D).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'فلكي',
                      style: TextStyle(
                        color: Color(0xFFC8771C),
                        fontSize: 9.5,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
                if (isNext) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.circle, size: 6, color: _primaryGreen),
                  const SizedBox(width: 4),
                  const Text(
                    'القادمة',
                    style: TextStyle(
                      color: _primaryGreen,
                      fontSize: 10.5,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: isNext ? _primaryGreen : _ink,
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'Cairo',
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer (calculation method note)
// ─────────────────────────────────────────────────────────────────────────────

class _MethodFooter extends StatelessWidget {
  const _MethodFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s14, vertical: AppSize.s10),
      decoration: const BoxDecoration(
        color: Color(0xFFFBF8F0),
        border: Border(
          top: BorderSide(color: Color(0xFFF1E8CC), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_rounded, size: 14, color: _gold),
          const SizedBox(width: 6),
          Text(
            'حسابات أم القرى · تُحسب محلياً بدون إنترنت',
            style: TextStyle(
              color: _ink.withValues(alpha: 0.7),
              fontSize: 11,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Formats a (Mecca-local) DateTime as `h:mm AM/PM` (English digits, English
/// AM/PM). The caller is expected to localize via [arNumber] and [arTime].
String _formatTime(DateTime dt) {
  final hour24 = dt.hour;
  final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
  final period = hour24 < 12 ? 'AM' : 'PM';
  final mm = dt.minute.toString().padLeft(2, '0');
  return '$hour12:$mm $period';
}
