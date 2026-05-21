import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/communication_channel.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/contact_request_sheet.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/prayer_times_card.dart';
import 'package:url_launcher/url_launcher.dart';

/// Home landing screen for the "Hajj Syria – Al-Masi Coalition" app.
///
/// Layout (top → bottom):
///   1. Quick-access cards (four channels) → bottom sheet → WhatsApp.
///   2. Auto-flipping ID card …
///   3. Prayer times card.
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  // Brand palette derived from the printed Hajj materials.
  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);
  static const Color _goldText = Color(0xFF7A6635);

  // Coalition hotel — used for the tap-to-map action on the flipping card.
  static const String _hotelQuery = 'فندق نرجس الحديقة مكة المكرمة';

  @override
  Widget build(BuildContext context) {
    final bottomPad = Responsive.homeScrollBottomPadding(context);

    return ColoredBox(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottomPad),
        child: ResponsiveBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
            SizedBox(height: AppSize.s16),

            _QuickAccessSection(),
            SizedBox(height: AppSize.s20),
            _FlippingCard(),
            SizedBox(height: AppSize.s20),
            PrayerTimesCard(),
            SizedBox(height: AppSize.s20),
            // _DetailsButton(),
            // SizedBox(height: AppSize.s20),
            // _YearFooter(),
            SizedBox(height: AppSize.s12),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 1) Auto-flipping card
// ─────────────────────────────────────────────────────────────────────────────

class _FlippingCard extends StatefulWidget {
  const _FlippingCard();

  @override
  State<_FlippingCard> createState() => _FlippingCardState();
}

class _FlippingCardState extends State<_FlippingCard>
    with SingleTickerProviderStateMixin {
  static const Duration _flipDuration = Duration(milliseconds: 900);
  static const Duration _autoFlipInterval = Duration(seconds: 6);

  late final AnimationController _controller;
  Timer? _autoFlipTimer;
  bool _showingBack = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _flipDuration,
    );
    _autoFlipTimer = Timer.periodic(_autoFlipInterval, (_) => _flip());
  }

  @override
  void dispose() {
    _autoFlipTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (!mounted) return;
    if (_showingBack) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _showingBack = !_showingBack);
  }

  Future<void> _openMap() async {
    final encoded = Uri.encodeComponent(HomeViewBody._hotelQuery);
    final webUri =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
    final geoUri = Uri.parse('geo:0,0?q=$encoded');

    // Prefer a native map app via geo: on Android; fall back to web URL.
    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri);
      return;
    }
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر فتح تطبيق الخرائط على هذا الجهاز')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: GestureDetector(
        onTap: _openMap,
        // Tapping anywhere on the card also resets the auto-flip timer feel
        // by toggling immediately; users get instant feedback.
        onLongPress: _flip,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // 0 → 0 rad (front fully visible)
            // 1 → π rad (back fully visible)
            final angle = _controller.value * math.pi;
            final showingFrontFace = angle <= math.pi / 2;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015) // perspective
                ..rotateY(angle),
              child: showingFrontFace
                  ? const _CardFace(asset: ImageAssets.frontCard)
                  : Transform(
                      alignment: Alignment.center,
                      // Counter-rotate so the back face reads correctly.
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: const _CardFace(asset: ImageAssets.backCard),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(asset, fit: BoxFit.cover),
              // Subtle gold border for the ID-pass feel.
              const _CardBorderOverlay(),
              // Tap hint chip (mirrors visual intent: tap to view map).
              const Positioned(
                bottom: 8,
                right: 8,
                child: _TapHintChip(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardBorderOverlay extends StatelessWidget {
  const _CardBorderOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0x66C9A961),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _TapHintChip extends StatelessWidget {
  const _TapHintChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xCC0F5847),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: HomeViewBody._gold, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.touch_app_rounded, color: Colors.white, size: 14),
          SizedBox(width: 4),
          Text(
            'اضغط لفتح الموقع',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 2) Quick-access actions row
// ─────────────────────────────────────────────────────────────────────────────

class _QuickAccessSection extends StatelessWidget {
  const _QuickAccessSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            children: [
              Expanded(child: _GoldRule()),
              SizedBox(width: AppSize.s12),
              Text(
                'أرقام هامة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: HomeViewBody._darkGreen,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(width: AppSize.s12),
              Expanded(child: _GoldRule()),
            ],
          ),
        ),
        const SizedBox(height: AppSize.s12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _QuickAccessCard(
                icon: CommunicationChannel.fatwa.icon,
                title: CommunicationChannel.fatwa.title,
                subtitle: CommunicationChannel.fatwa.sheetSubtitle,
                color: CommunicationChannel.fatwa.accentColor,
                onTap: () => showContactRequestSheet(
                  context,
                  channel: CommunicationChannel.fatwa,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              _QuickAccessCard(
                icon: CommunicationChannel.emergency.icon,
                title: CommunicationChannel.emergency.title,
                subtitle: CommunicationChannel.emergency.sheetSubtitle,
                color: CommunicationChannel.emergency.accentColor,
                onTap: () => showContactRequestSheet(
                  context,
                  channel: CommunicationChannel.emergency,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              _QuickAccessCard(
                icon: CommunicationChannel.complaints.icon,
                title: CommunicationChannel.complaints.title,
                subtitle: CommunicationChannel.complaints.sheetSubtitle,
                color: CommunicationChannel.complaints.accentColor,
                onTap: () => showContactRequestSheet(
                  context,
                  channel: CommunicationChannel.complaints,
                ),
              ),
              const SizedBox(height: AppSize.s12),
              _QuickAccessCard(
                icon: CommunicationChannel.hotel.icon,
                title: CommunicationChannel.hotel.title,
                subtitle: CommunicationChannel.hotel.sheetSubtitle,
                color: CommunicationChannel.hotel.accentColor,
                onTap: () => showContactRequestSheet(
                  context,
                  channel: CommunicationChannel.hotel,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withAlpha(35), width: 1.4),
            gradient: LinearGradient(
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
              colors: [
                color.withAlpha(8),
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p14,
              vertical: AppPadding.p14,
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withAlpha(12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withAlpha(55),
                      width: 1.4,
                    ),
                  ),
                  child: Icon(icon, color: color, size: 26),
                ),
                const SizedBox(width: AppSize.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: HomeViewBody._darkGreen,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: HomeViewBody._goldText,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                // chevron_left visually points to the "next" direction in RTL.
                Icon(
                  Icons.chevron_left_rounded,
                  color: color,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3) Primary details button
// ─────────────────────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────────────────────
// 4) Footer
// ─────────────────────────────────────────────────────────────────────────────

class _GoldRule extends StatelessWidget {
  const _GoldRule();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: const Color(0x40C9A961));
  }
}
