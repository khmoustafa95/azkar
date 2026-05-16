import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:holly_quran/features/home/data/duaa_content_data.dart';
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
  List<DuaaModel> fetchDuaa() => buildDuaaCatalog();
}
