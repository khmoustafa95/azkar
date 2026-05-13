import '../models/duaa/duaa_model.dart';
import '../models/quran/surah_model.dart';

abstract class HomeRepo {
  List<DuaaModel> fetchDuaa();

  /// Loads the 114 surahs with Madinah mushaf start pages from bundled JSON.
  Future<List<SurahModel>> loadSurahIndex();
}
