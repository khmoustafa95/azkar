import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_item.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';

/// Catalog of all bundled duaa / hajj media for [HomeRepoImpl.fetchDuaa].
List<DuaaModel> buildDuaaCatalog() {
  return <DuaaModel>[
    ..._audioDuasSection(),
    ..._fiqhHajjSection(),
    ..._fiqhMessagesSection(),
    ..._pilgrimAdviceSection(),
  ];
}

/// Slides for the «أدعية مكتوبة» slideshow ([TextPrayerImageAssets]).
final List<SlideItem> textPrayerSlides = List<SlideItem>.unmodifiable(
  List.generate(
    10,
    (i) => SlideItem(
      asset: TextPrayerImageAssets.pathForPage(i + 1),
      title: 'دعاء ${i + 1}',
    ),
  ),
);

List<DuaaModel> _audioDuasSection() {
  const cat = DuaaContentCategory.audioDuas;
  return <DuaaModel>[
    _audio(1001, 'دعاء الخروج من المنزل', SoundPrayerAudioAssets.leavingHomeDua, cat),
    _audio(1002, 'دعاء الركوب والسفر', SoundPrayerAudioAssets.travel, cat),
    _audio(
      1003,
      'دعاء دخول المسجد الحرام وسائر المساجد',
      SoundPrayerAudioAssets.enterMasjed,
      cat,
    ),
    _audio(1004, 'الدعاء عند رؤية الكعبة', SoundPrayerAudioAssets.seeKaabeh, cat),
    _audio(1005, 'نية الإحرام والتلبية', SoundPrayerAudioAssets.ihramTalbia, cat),
    _audio(1006, 'الدعاء عند ابتداء الطواف', SoundPrayerAudioAssets.startTawaf, cat),
    _audio(
      1007,
      'الدعاء عند استلام الحجر في بداية الطواف',
      SoundPrayerAudioAssets.startHejjer,
      cat,
    ),
    _audio(
      1008,
      'الدعاء بين الركن اليماني والحجر الأسود',
      SoundPrayerAudioAssets.raknYamani,
      cat,
    ),
    _audio(1009, 'الدعاء بين الميلين الأخضرين', SoundPrayerAudioAssets.mailain, cat),
    _audio(1010, 'الدعاء عند شرب ماء زمزم', SoundPrayerAudioAssets.drinkZamzam, cat),
    _audio(1011, 'أدعية مختارة للطواف ١', SoundPrayerAudioAssets.tawaf1Dua, cat),
    _audio(1012, 'أدعية مختارة للطواف ٢', SoundPrayerAudioAssets.tawaf2Dua, cat),
    _audio(1013, 'أدعية مختارة للطواف ٣', SoundPrayerAudioAssets.tawaf3Dua, cat),
    _audio(1014, 'الدعاء عند الصفا والمروة', SoundPrayerAudioAssets.safaMarwa, cat),
    _audio(1015, 'أدعية مختارة للسعي ١', SoundPrayerAudioAssets.saai1Dua, cat),
    _audio(1016, 'أدعية مختارة للسعي ٢', SoundPrayerAudioAssets.saai2Dua, cat),
    _audio(1017, 'أدعية مختارة للسعي ٣', SoundPrayerAudioAssets.saai3Dua, cat),
    _audio(1018, 'دعاء طواف الإفاضة', SoundPrayerAudioAssets.tawafEfada, cat),
    _audio(
      1019,
      'الدعاء يوم التروية عند الارتحال إلى منى',
      SoundPrayerAudioAssets.tarwia,
      cat,
    ),
    _audio(1020, 'الدعاء عند المسير إلى عرفة', SoundPrayerAudioAssets.walkingArafa, cat),
    _audio(1021, 'دعاء يوم عرفة', SoundPrayerAudioAssets.yaumArafa, cat),
    _audio(1022, 'يوم عرفة ١', SoundPrayerAudioAssets.yaumArafa1, cat),
    _audio(1023, 'أدعية مختارة ليوم عرفة ١', SoundPrayerAudioAssets.arafa1Dua, cat),
    _audio(1024, 'أدعية مختارة ليوم عرفة ٢', SoundPrayerAudioAssets.arafa2Dua, cat),
    _audio(1025, 'أدعية مختارة ١', SoundPrayerAudioAssets.selected1Dua, cat),
    _audio(1026, 'أدعية مختارة ٢', SoundPrayerAudioAssets.selected2Dua, cat),
    DuaaModel(
      id: 1100,
      name: 'أدعية مكتوبة',
      type: 'slideshow',
      category: cat,
      url: TextPrayerImageAssets.pathForPage(1),
    ),
  ];
}

List<DuaaModel> _fiqhHajjSection() {
  const cat = DuaaContentCategory.fiqhHajj;
  final part1 = List<DuaaModel>.generate(
    12,
    (i) => _video(
      2001 + i,
      'فقه الحج — الدرس ${i + 1} (الجزء الأول)',
      FiqhHajj1VideoAssets.pathForIndex(i + 1),
      cat,
    ),
  );
  final part2 = FighHajj2VideoAssets.indices
      .map(
        (index) => _video(
          2100 + index,
          'فقه الحج — الدرس $index (الجزء الثاني)',
          FighHajj2VideoAssets.pathForIndex(index),
          cat,
        ),
      )
      .toList();

  return <DuaaModel>[...part1, ...part2];
}

List<DuaaModel> _fiqhMessagesSection() {
  const cat = DuaaContentCategory.fiqhMessages;
  return List<DuaaModel>.generate(
    11,
    (i) => _video(
      3001 + i,
      'هل تعلم — ${i + 1}',
      DoYouKnowVideoAssets.pathForIndex(i + 1),
      cat,
    ),
  );
}

List<DuaaModel> _pilgrimAdviceSection() {
  const cat = DuaaContentCategory.pilgrimAdvice;
  return List<DuaaModel>.generate(
    41,
    (i) => _video(
      4001 + i,
      'مع الحاج — الحلقة ${i + 1}',
      WithHajjVideoAssets.pathForIndex(i + 1),
      cat,
    ),
  );
}

DuaaModel _audio(int id, String name, String url, String category) {
  return DuaaModel(
    id: id,
    name: name,
    type: 'audio',
    category: category,
    url: url,
  );
}

DuaaModel _video(int id, String name, String url, String category) {
  return DuaaModel(
    id: id,
    name: name,
    type: 'video',
    category: category,
    url: url,
  );
}
