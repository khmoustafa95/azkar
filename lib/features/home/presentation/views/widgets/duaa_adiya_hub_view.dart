import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_show.dart';
import 'package:holly_quran/features/home/data/duaa_content_data.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_audio_list_view.dart';

/// Entry for «أدعية»: choose audio list or written slideshow.
class DuaaAdiyaHubView extends StatelessWidget {
  const DuaaAdiyaHubView({super.key});

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _accent = Color(0xFF2D6A4F);
  static const Color _gold = Color(0xFFC9A961);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _darkGreen,
          foregroundColor: Colors.white,
          title: const Text(
            'أدعية',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              _HubCard(
                title: 'أدعية مسموعة',
                subtitle: 'استمع إلى أدعية الحج والعمرة',
                icon: Icons.mic_rounded,
                color: _accent,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const DuaaAudioListView(),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSize.s14),
              _HubCard(
                title: 'أدعية مكتوبة',
                subtitle: 'بطاقات دعاء للقراءة والتأمل',
                icon: Icons.photo_library_rounded,
                color: const Color(0xFF1E5A7A),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => SlideShow(
                        slides: textPrayerSlides,
                        title: 'أدعية مكتوبة',
                        primaryColor: _accent,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  const _HubCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 3,
      shadowColor: const Color(0x22000000),
      borderRadius: BorderRadius.circular(AppSize.s20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            border: Border.all(color: color.withValues(alpha: 0.35), width: 1.3),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [color.withValues(alpha: 0.12), Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Row(
              children: [
                Container(
                  width: AppSize.s60,
                  height: AppSize.s60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withValues(alpha: 0.5)),
                  ),
                  child: Icon(icon, color: color, size: 30),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: DuaaAdiyaHubView._darkGreen,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: DuaaAdiyaHubView._darkGreen.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_left_rounded, color: color, size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
