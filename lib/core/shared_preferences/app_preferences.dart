import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight persistence for Quran reading position and similar keys.
class AppPreferences {
  AppPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _kStopSurah = 'quran_stop_surah';
  static const _kStopPage = 'quran_stop_page';
  static const _kStopSurahName = 'quran_stop_surah_name';

  static const _kHajjPilgrimName = 'hajj_pilgrim_name';
  static const _kHajjStepBits = 'hajj_step_bits';
  static const _kHajjUmrahCount = 'hajj_umrah_count';

  /// Returns `[surahId, page, surahName]` as strings (defaults: 1, 1, الفاتحة).
  Future<List<String>> getStopReading() async {
    return [
      _prefs.getString(_kStopSurah) ?? '1',
      _prefs.getString(_kStopPage) ?? '1',
      _prefs.getString(_kStopSurahName) ?? 'سُورَةُ ٱلْفَاتِحَةِ',
    ];
  }

  Future<void> saveStopReading({
    required int surahId,
    required int page,
    required String surahName,
  }) async {
    await _prefs.setString(_kStopSurah, surahId.toString());
    await _prefs.setString(_kStopPage, page.clamp(1, 604).toString());
    await _prefs.setString(_kStopSurahName, surahName);
  }

  // ─── Hajj tracker (متابعة أعمال الحاج) ─────────────────────────────────

  String getHajjPilgrimNameSync() => _prefs.getString(_kHajjPilgrimName) ?? '';

  Future<void> setHajjPilgrimName(String name) async {
    await _prefs.setString(_kHajjPilgrimName, name.trim());
  }

  /// Fixed-length list; invalid stored length resets to all false.
  List<bool> getHajjStepsSync(int stepCount) {
    final raw = _prefs.getString(_kHajjStepBits);
    if (raw == null || raw.isEmpty) {
      return List<bool>.filled(stepCount, false);
    }
    final parts = raw.split(',');
    if (parts.length != stepCount) {
      return List<bool>.filled(stepCount, false);
    }
    return parts.map((e) => e == '1').toList();
  }

  Future<void> setHajjSteps(List<bool> steps) async {
    await _prefs.setString(
      _kHajjStepBits,
      steps.map((e) => e ? '1' : '0').join(','),
    );
  }

  int getHajjUmrahCountSync() => _prefs.getInt(_kHajjUmrahCount) ?? 0;

  Future<void> setHajjUmrahCount(int count) async {
    await _prefs.setInt(_kHajjUmrahCount, count < 0 ? 0 : count);
  }

  /// Clears pilgrim name and all ritual checkboxes (full «ابدأ من جديد»).
  Future<void> clearHajjTrackerFully() async {
    await _prefs.remove(_kHajjPilgrimName);
    await _prefs.remove(_kHajjStepBits);
    await _prefs.remove(_kHajjUmrahCount);
  }
}
