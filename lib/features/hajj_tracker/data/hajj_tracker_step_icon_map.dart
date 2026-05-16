import 'package:holly_quran/core/resources/app_assets.dart';

import 'hajj_tracker_steps.dart';

/// ربط كل خطوة متابعة الحج بصورة من [IconAssets].
///
/// عدّل قيمة كل مفتاح يدوياً (مثلاً `IconAssets.icon5`) لتطابق
/// محتوى ملفات `assets/icon/iconN.png`.
const Map<int, String> kHajjTrackerStepIconMap = {
  // ─── عمرة التمتع (0–4) ───────────────────────────────────────────────
  // 0 — الإحرام من الميقات بنية العمرة
  0: IconAssets.icon1,
  // 1 — الطواف حول الكعبة
  1: IconAssets.icon2,
  // 2 — ركعتان الطواف
  2: IconAssets.icon3,
  // 3 — السعي بين الصفا والمروة
  3: IconAssets.icon4,
  // 4 — الحلق أو التقصير لإنهاء العمرة
  4: IconAssets.icon5,

  // ─── بعد العمرة ──────────────────────────────────────────────────────
  // 5 — المكوث في مكة
  5: IconAssets.icon6,
  // 6 — أعمال يوم التروية (8 ذي الحجة)
  6: IconAssets.icon7,

  // ─── يوم عرفة (7–10) ─────────────────────────────────────────────────
  // 7 — الوقوف بعرفة
  7: IconAssets.icon8,
  // 8 — الإفاضة من عرفات إلى مزدلفة
  8: IconAssets.icon9,
  // 9 — أداء المغرب والعشاء في مزدلفة
  9: IconAssets.icon10,
  // 10 — المبيت في مزدلفة
  10: IconAssets.icon11,

  // ─── يوم النحر (11–15) ───────────────────────────────────────────────
  // 11 — رمي جمرة العقبة الكبرى
  11: IconAssets.icon12,
  // 12 — ذبح الهدي
  12: IconAssets.icon13,
  // 13 — الحلق أو التقصير بعد النحر
  13: IconAssets.icon14,
  // 14 — طواف الإفاضة
  14: IconAssets.icon15,
  // 15 — السعي بين الصفا والمروة للحج
  15: IconAssets.icon16,

  // ─── أيام التشريق — يوم 11 (16–19) ───────────────────────────────────
  // 16 — يوم 11 — رمي الجمرة الصغرى
  16: IconAssets.icon1,
  // 17 — يوم 11 — رمي الجمرة الوسطى
  17: IconAssets.icon2,
  // 18 — يوم 11 — رمي جمرة العقبة
  18: IconAssets.icon3,
  // 19 — يوم 11 — المبيت في منى
  19: IconAssets.icon4,

  // ─── يوم 12 (20–23) ──────────────────────────────────────────────────
  // 20 — يوم 12 — رمي الجمرة الصغرى
  20: IconAssets.icon5,
  // 21 — يوم 12 — رمي الجمرة الوسطى
  21: IconAssets.icon6,
  // 22 — يوم 12 — رمي جمرة العقبة
  22: IconAssets.icon7,
  // 23 — يوم 12 — المبيت في منى
  23: IconAssets.icon8,

  // ─── يوم 13 (24–27) ──────────────────────────────────────────────────
  // 24 — يوم 13 — رمي الجمرة الصغرى
  24: IconAssets.icon9,
  // 25 — يوم 13 — رمي الجمرة الوسطى
  25: IconAssets.icon10,
  // 26 — يوم 13 — رمي جمرة العقبة
  26: IconAssets.icon11,
  // 27 — يوم 13 — المبيت في منى
  27: IconAssets.icon12,

  // ─── الختام ──────────────────────────────────────────────────────────
  // 28 — طواف الوداع
  28: IconAssets.icon13,
};

/// مسار صورة الخطوة [stepIndex]. يُرجع [IconAssets.icon1] إن لم يُعرَّف المفتاح.
String hajjTrackerStepIcon(int stepIndex) {
  if (stepIndex < 0 || stepIndex >= kHajjTrackerStepCount) {
    return IconAssets.icon1;
  }
  return kHajjTrackerStepIconMap[stepIndex] ?? IconAssets.icon1;
}
