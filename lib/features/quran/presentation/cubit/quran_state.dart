part of 'quran_cubit.dart';

@immutable
abstract class QuranState {
  const QuranState();
}

class QuranInitial extends QuranState {
  const QuranInitial();
}

class QuranSuccess extends QuranState {
  const QuranSuccess(
    this.surahs,
    this.stopSurah,
    this.stopPage,
    this.stopSurahName,
  );

  final List<SurahModel> surahs;
  final int stopSurah;
  final int stopPage;
  final String stopSurahName;
}
