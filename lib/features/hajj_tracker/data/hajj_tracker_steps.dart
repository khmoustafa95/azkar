import 'package:flutter/material.dart';

/// Number of sequential checklist items (حاج متمتع).
const int kHajjTrackerStepCount = 29;

class HajjStepDefinition {
  const HajjStepDefinition({
    required this.title,
    required this.body,
    required this.background,
    this.sideLabel,
    this.icon = Icons.mosque_rounded,
  });

  final String title;
  final String body;
  final Color background;
  final String? sideLabel;
  final IconData icon;
}

/// UI metadata for each index in [0, kHajjTrackerStepCount).
final List<HajjStepDefinition> kHajjTrackerSteps = [
  HajjStepDefinition(
    title: 'الإحرام من الميقات بنية العمرة',
    body:
        'لبيك اللهم عمرة. نية الاشتراط: «اللهم محلي حيث حبستني» — أحرم من الميقات بنية عمرة التمتع.',
    background: Color(0xFFF5E6D3),
    sideLabel: null,
    icon: Icons.airline_seat_individual_suite_rounded,
  ),
  HajjStepDefinition(
    title: 'الطواف حول الكعبة',
    body: 'سبعة أشواط، يبدأ عند الحجر الأسود وينتهي عنده، من أعمال عمرة التمتع.',
    background: Color(0xFF0F5847),
    sideLabel: 'أعمال عمرة التمتع',
    icon: Icons.explore_rounded,
  ),
  HajjStepDefinition(
    title: 'ركعتان الطواف',
    body: 'يُستحبُّ أن يصليها خلف مقام إبراهيم عليه السلام.',
    background: Color(0xFF0F5847),
    sideLabel: null,
    icon: Icons.self_improvement_rounded,
  ),
  HajjStepDefinition(
    title: 'السعي بين الصفا والمروة',
    body: 'سبعة أشواط بين الصفا والمروة.',
    background: Color(0xFF0F5847),
    sideLabel: null,
    icon: Icons.directions_walk_rounded,
  ),
  HajjStepDefinition(
    title: 'الحلق أو التقصير لإنهاء العمرة',
    body:
        'للرجال: التحلُّق أفضل، وللنساء: قصُّ قدر أنملة من شعر الرأس. بهذا تنتهي العمرة.',
    background: Color(0xFF0F5847),
    sideLabel: null,
    icon: Icons.content_cut_rounded,
  ),
  HajjStepDefinition(
    title: 'المكوث في مكة',
    body:
        'البقاء في مكة مشغولاً بالعبادة والقرآن والذكر حتى يوم التروية (8 ذي الحجة).',
    background: Color(0xFFE8B4B4),
    sideLabel: null,
    icon: Icons.place_rounded,
  ),
  HajjStepDefinition(
    title: 'أعمال يوم التروية (8 ذي الحجة)',
    body:
        'الإحرام للحج من مكانك بمكة، والخروج إلى منى، وأداء الصلوات الخمس في منى مقصورة غير مجمعة، والمبيت في منى.',
    background: Color(0xFFB8D4E8),
    sideLabel: null,
    icon: Icons.calendar_today_rounded,
  ),
  HajjStepDefinition(
    title: 'الوقوف بعرفة',
    body:
        'من الزوال إلى غروب الشمس يوم 9 ذي الحجة — ركن عظيم من أركان الحج.',
    background: Color(0xFFD4AF37),
    sideLabel: 'أعمال اليوم التاسع',
    icon: Icons.wb_sunny_rounded,
  ),
  HajjStepDefinition(
    title: 'الإفاضة من عرفات إلى مزدلفة',
    body:
        'بعد غروب شمس يوم عرفة، الإفاضة إلى مزدلفة بسكينة وذكر، مع التلبية.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
    icon: Icons.directions_bus_rounded,
  ),
  HajjStepDefinition(
    title: 'أداء المغرب والعشاء في مزدلفة',
    body: 'يُجمع بينهما ويُقصر بعد الوصول إلى مزدلفة.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
    icon: Icons.nightlight_round,
  ),
  HajjStepDefinition(
    title: 'المبيت في مزدلفة',
    body:
        'المبيت ليلة النحر إلى طلوع الفجر، مع الذكر والدعاء وجمع الحصى لرمي الجمرات.',
    background: Color(0xFFD4AF37),
    sideLabel: null,
    icon: Icons.bedtime_rounded,
  ),
  HajjStepDefinition(
    title: 'رمي جمرة العقبة الكبرى',
    body: 'سبع حصيات متتابعات مع التكبير مع كل حصاة يوم النحر.',
    background: Color(0xFFE67E22),
    sideLabel: 'أعمال اليوم العاشر',
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'ذبح الهدي',
    body: 'واجب على المتمتع والقارن؛ شكر لله تعالى وتقرُّب.',
    background: Color(0xFFE67E22),
    sideLabel: null,
    icon: Icons.volunteer_activism_rounded,
  ),
  HajjStepDefinition(
    title: 'الحلق أو التقصير بعد النحر',
    body: 'للرجال: الحلق أفضل. للنساء: قصُّ أنملة من الشعر.',
    background: Color(0xFFE67E22),
    sideLabel: null,
    icon: Icons.content_cut_rounded,
  ),
  HajjStepDefinition(
    title: 'طواف الإفاضة',
    body: 'سبعة أشواط حول الكعبة — ركن من أركان الحج.',
    background: Color(0xFFE67E22),
    sideLabel: null,
    icon: Icons.explore_rounded,
  ),
  HajjStepDefinition(
    title: 'السعي بين الصفا والمروة للحج',
    body: 'سبعة أشواط يبدأ من الصفا وينتهي بالمروة.',
    background: Color(0xFFE67E22),
    sideLabel: null,
    icon: Icons.directions_walk_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي الجمرة الصغرى',
    body: 'سبع حصيات لكل جمرة على حدة، والتكبير مع كل حصاة.',
    background: Color(0xFF3498DB),
    sideLabel: 'أعمال أيام التشريق',
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF3498DB),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF3498DB),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 11 — المبيت في منى',
    body: 'قضاء الليل في منى.',
    background: Color(0xFF3498DB),
    sideLabel: null,
    icon: Icons.night_shelter_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي الجمرة الصغرى',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF5DADE2),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 12 — المبيت في منى',
    body: 'قضاء الليل في منى (من لم يتعجل).',
    background: Color(0xFF5DADE2),
    sideLabel: null,
    icon: Icons.night_shelter_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي الجمرة الصغرى',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي الجمرة الوسطى',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — رمي جمرة العقبة',
    body: 'سبع حصيات.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
    icon: Icons.grain_rounded,
  ),
  HajjStepDefinition(
    title: 'يوم 13 — المبيت في منى',
    body: 'لمن بقي حتى آخر يوم من أيام التشريق.',
    background: Color(0xFF85C1E9),
    sideLabel: null,
    icon: Icons.night_shelter_rounded,
  ),
  HajjStepDefinition(
    title: 'طواف الوداع',
    body:
        'عند مغادرة مكة: سبعة أشواط حول الكعبة — آخر عهد بالبيت الحرام (يُستحبُّ لمن لم يكن متمتعاً).',
    background: Color(0xFF34495E),
    sideLabel: null,
    icon: Icons.flight_takeoff_rounded,
  ),
];
