import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight persistence for Quran reading position and similar keys.
class AppPreferences {
  AppPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _kStopSurah = 'quran_stop_surah';
  static const _kStopPage = 'quran_stop_page';
  static const _kStopSurahName = 'quran_stop_surah_name';

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
}
