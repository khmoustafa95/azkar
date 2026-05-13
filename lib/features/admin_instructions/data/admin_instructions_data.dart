import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_item.dart';

/// Administrative-instruction slides in presentation order.
///
/// Paths use [AdminInstructionImageAssets] so renames are caught at compile time.
const List<SlideItem> adminInstructionsSlides = <SlideItem>[
  SlideItem(
    asset: AdminInstructionImageAssets.beforeTravel,
    title: 'تعليمات قبل السفر',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.airport,
    title: 'تعليمات المطار',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.arrivingAirport,
    title: 'تعليمات الوصول للمطار',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.insidePlane,
    title: 'تعليمات داخل الطائرة',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.arrivingHotel,
    title: 'تعليمات الوصول إلى الفندق',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.mosque,
    title: 'تعليمات المسجد',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.restaurant,
    title: 'تعليمات المطعم',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.washing,
    title: 'تعليمات الغسيل',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.arafatCamp,
    title: 'تعليمات مخيمات عرفات',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.walking,
    title: 'تعليمات المسير',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.loss,
    title: 'تعليمات حالات الضياع',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.backMadinah,
    title: 'تعليمات العودة من المدينة',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.leavingMakkah,
    title: 'تعليمات المغادرة من مكة',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.elevator,
    title: 'تعليمات المصعد',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.drugs,
    title: 'تعليمات الأدوية',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.contentBug,
    title: 'تعليمات إضافية',
  ),
  SlideItem(
    asset: AdminInstructionImageAssets.generalAdvice,
    title: 'إرشادات عامة',
  ),
];
