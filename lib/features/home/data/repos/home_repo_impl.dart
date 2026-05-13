import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl();

  List<SurahModel>? _cachedSurahs;

  @override
  Future<List<SurahModel>> loadSurahIndex() async {
    if (_cachedSurahs != null) return _cachedSurahs!;
    final raw = await rootBundle.loadString('assets/json/quran_surahs.json');
    final list = json.decode(raw) as List<dynamic>;
    _cachedSurahs = list
        .map((e) => SurahModel.fromJson(e as Map<String, dynamic>))
        .toList(growable: false);
    return _cachedSurahs!;
  }

  @override
  List<DuaaModel> fetchDuaa() {
    return <DuaaModel>[
      DuaaModel(
        id: 1,
        name: 'الدعاء عند دخول الحرم',
        type: 'audio',
        category: DuaaContentCategory.audioDuas,
        url: 'media/1.mp3',
        subDuaas: [
          DuaaModel(
            id: 1,
            name: 'الدعاء1',
            type: 'audio',
            category: DuaaContentCategory.audioDuas,
            url: 'media/1.mp3',
          ),
          DuaaModel(
            id: 2,
            name: 'الدعاء2',
            type: 'audio',
            category: DuaaContentCategory.audioDuas,
            url: 'media/2.mp3',
          ),
        ],
      ),
      DuaaModel(
        id: 2,
        name: 'الدعاء عند رؤية الكعبة',
        type: 'audio',
        category: DuaaContentCategory.audioDuas,
        url: 'media/2.mp3',
      ),
      DuaaModel(
        id: 3,
        name: 'كيفية رمي الجمرات',
        type: 'video',
        category: DuaaContentCategory.fiqhHajj,
        url: 'assets/videos/video1.mp4',
      ),
      DuaaModel(
        id: 4,
        name: 'مثال رسالة فقهية',
        type: 'video',
        category: DuaaContentCategory.fiqhMessages,
        url: 'assets/videos/video1.mp4',
      ),
      DuaaModel(
        id: 5,
        name: 'مثال وصية للحاج',
        type: 'audio',
        category: DuaaContentCategory.pilgrimAdvice,
        url: 'media/1.mp3',
      ),
    ];
  }
}
