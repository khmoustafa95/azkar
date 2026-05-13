import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';
import 'package:holly_quran/core/resources/app_assets.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit(this._homeRepo, this._prefs) : super(const QuranInitial());

  final HomeRepo _homeRepo;
  final AppPreferences _prefs;

  List<SurahModel> _surahs = const [];

  /// Surah whose [pageNumber] is ≤ [page] (last match = surah visible at top of page).
  SurahModel surahForPage(int page) {
    final p = page.clamp(1, 604);
    if (_surahs.isEmpty) {
      return const SurahModel(
        id: 1,
        name: '',
        type: '',
        ayatNumber: 7,
        pageNumber: 1,
      );
    }
    return _surahs.lastWhere(
      (e) => e.pageNumber <= p,
      orElse: () => _surahs.first,
    );
  }

  String getCurrentSurahName({required int page}) =>
      surahForPage(page).name;

  Future<void> fetchQuran() async {
    final stop = await _prefs.getStopReading();
    final stopSurah = int.tryParse(stop[0]) ?? 1;
    final stopPage = int.tryParse(stop[1]) ?? 1;
    final stopSurahName = stop[2];

    _surahs = await _homeRepo.loadSurahIndex();

    emit(QuranSuccess(
      _surahs,
      stopSurah,
      stopPage.clamp(1, 604),
      stopSurahName,
    ));
  }

  /// Persists last page (debounced by caller if needed).
  Future<void> saveReadingPosition({
    required int surahId,
    required int page,
    required String surahName,
  }) {
    return _prefs.saveStopReading(
      surahId: surahId,
      page: page,
      surahName: surahName,
    );
  }

  /// Pre-built list of mushaf page assets — do not rebuild each [fetchQuran].
  List<String> get mushafPagePaths => QuranMushafPageAssets.allPaths;
}
