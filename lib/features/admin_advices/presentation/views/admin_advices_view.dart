import 'package:flutter/material.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_show.dart';
import 'package:holly_quran/features/admin_advices/data/admin_advices_data.dart';

/// Entry point for the «نصائح إدارة الحج و العمرة» section.
class AdminAdvicesView extends StatelessWidget {
  const AdminAdvicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideShow(
      slides: adminAdvicesSlides,
      title: 'نصائح إدارة الحج و العمرة',
      primaryColor: Color(0xFFB85A33),
    );
  }
}
