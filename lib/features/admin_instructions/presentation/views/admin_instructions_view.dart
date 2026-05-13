import 'package:flutter/material.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_show.dart';
import 'package:holly_quran/features/admin_instructions/data/admin_instructions_data.dart';

/// Entry point for the «تعليمات إدارية» section. Thin shell — all the heavy
/// lifting lives in the reusable [SlideShow] under
/// `lib/core/widgets/slideshow/`. Other instruction sets (e.g. medical,
/// rituals) can wire a similar one-liner using their own data files.
class AdminInstructionsView extends StatelessWidget {
  const AdminInstructionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideShow(
      slides: adminInstructionsSlides,
      title: 'تعليمات إدارية',
    );
  }
}
