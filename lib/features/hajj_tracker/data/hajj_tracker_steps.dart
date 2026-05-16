import 'package:flutter/material.dart';

/// Number of sequential checklist items (حاج متمتع).
const int kHajjTrackerStepCount = 29;

/// First [kHajjUmrahRepeatableStepCount] steps (عمرة التمتع) may be repeated.
const int kHajjUmrahRepeatableStepCount = 5;

class HajjStepDefinition {
  const HajjStepDefinition({
    required this.title,
    required this.body,
    required this.background,
    this.sideLabel,
  });

  final String title;
  final String body;
  final Color background;
  final String? sideLabel;
}

/// UI metadata for each index in [0, kHajjTrackerStepCount).
final List<HajjStepDefinition> kHajjTrackerSteps = [
  HajjStepDefinition(
    title: 'الإحرام من الميقات بنية العمرة',
    body:
        'لبيك اللهم عمرة. نية الاشتراط: «اللهم محلي حيث حبستني» — أحرم من الميقات بنية عمرة التمتع.',
    background: Color(0xFFF5E6D3),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'الطواف حول الكعبة',
    body: 'سبعة أشواط، يبدأ عند الحجر الأسود وينتهي عنده، من أعمال عمرة التمتع.',
    background: Color(0xFF0F5847),
    sideLabel: 'أعمال عمرة التمتع',
  ),
  HajjStepDefinition(
    title: 'ركعتان الطواف',
    body: 'يُستحبُّ أن يصليها خلف مقام إبراهيم عليه السلام.',
    background: Color(0xFF0F5847),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'السعي بين الصفا والمروة',
    body: 'سبعة أشواط بين الصفا والمروة.',
    background: Color(0xFF0F5847),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'الحلق أو التقصير لإنهاء العمرة',
    body:
        'للرجال: التحلُّق أفضل، وللنساء: قصُّ قدر أنملة من شعر الرأس. بهذا تنتهي العمرة.',
    background: Color(0xFF0F5847),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'المكوث في مكة',
    body:
        'البقاء في مكة مشغولاً بالعبادة والقرآن والذكر حتى يوم التروية (8 ذي الحجة).',
    background: Color(0xFFE8B4B4),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'أعمال يوم التروية (8 ذي الحجة)',
    body:
        'الإحرام للحج من مكانك بمكة، والخروج إلى منى، وأداء الصلوات الخمس في منى مقصورة غير مجمعة، والمبيت في منى.',
    background: Color(0xFFB8D4E8),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'الوقوف بعرفة',
    body:
        'من الزوال إلى غروب الشمس يوم 9 ذي الحجة — ركن عظيم من أركان الحج.',
    background: Color(0xFFD4AF37),
    sideLabel: 'أعمال اليوم التاسع',
  ),
  HajjStepDefinition(
    title: 'الإفاضة من عرفات إلى مزدلفة',
    body:
        'بعد غروب شمس يوم عرفة، الإفاضة إلى مزدلفة بسكينة وذكر، مع التلبية.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'أداء المغرب والعشاء في مزدلفة',
    body: 'يُجمع بينهما ويُقصر بعد الوصول إلى مزدلفة.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'المبيت في مزدلفة',
    body:
        'المبيت ليلة النحر إلى طلوع الفجر، مع الذكر والدعاء وجمع الحصى لرمي الجمرات.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'رمي جمرة العقبة الكبرى',
    body: 'سبع حصيات متتابعات مع التكبير مع كل حصاة يوم النحر.',
    background: Color(0xFFE67E22),
    sideLabel: 'أعمال اليوم العاشر',
  ),
  HajjStepDefinition(
    title: 'ذبح الهدي',
    body: 'واجب على المتمتع والقارن؛ شكر لله تعالى وتقرُّب.',
    background: Color(0xFFE67E22),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'الحلق أو التقصير بعد النحر',
    body: 'للرجال: الحلق أفضل. للنساء: قصُّ أنملة من الشعر.',
    background: Color(0xFFE67E22),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'طواف الإفاضة',
    body: 'سبعة أشواط حول الكعبة — ركن من أركان الحج.',
    background: Color(0xFFE67E22),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'السعي بين الصفا والمروة للحج',
    body: 'سبعة أشواط يبدأ من الصفا وينتهي بالمروة.',
    background: Color(0xFFE67E22),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي الجمرة الصغرى',
    body: 'سبع حصيات لكل جمرة على حدة، والتكبير مع كل حصاة.',
    background: Color(0xFF3498DB),
    sideLabel: 'أعمال أيام التشريق',
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF3498DB),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF3498DB),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — المبيت في منى',
    body: 'قضاء الليل في منى.',
    background: Color(0xFF3498DB),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي الجمرة الصغرى',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — المبيت في منى',
    body: 'قضاء الليل في منى (من لم يتعجل).',
    background: Color(0xFF5DADE2),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي الجمرة الصغرى',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — المبيت في منى',
    body: 'لمن بقي حتى آخر يوم من أيام التشريق.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
  ),
  HajjStepDefinition(
    title: 'طواف الوداع',
    body:
        'عند مغادرة مكة: سبعة أشواط حول الكعبة — آخر عهد بالبيت الحرام (يُستحبُّ لمن لم يكن متمتعاً).',
    background: Color(0xFF34495E),
    sideLabel: null,
  ),
];
