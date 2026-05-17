import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/admin_advices/presentation/views/admin_advices_view.dart';
import 'package:holly_quran/features/admin_instructions/presentation/views/admin_instructions_view.dart';

/// صفحة التعليمات الإدارية والطبية (بلاطتان).
class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);
  static const Color _ink = Color(0xFF1A2421);
  static const Color _muted = Color(0xFF6B7570);

  @override
  Widget build(BuildContext context) {
    final tiles = <_SectionTile>[
      _SectionTile(
        title: 'تعليمات إدارية',
        subtitle: 'إرشادات وتوجيهات',
        icon: Icons.assignment_rounded,
        color: const Color(0xFF1E5A7A),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const AdminInstructionsView(),
          ),
        ),
      ),
      _SectionTile(
        title: 'نصائح إدارة الحج و العمرة ',
        subtitle: 'يمكنك الاستفادة منها لتحقيق حج و عمرة سليمة',
        icon: Icons.health_and_safety_rounded,
        color: const Color(0xFFB85A33),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const AdminAdvicesView(),
          ),
        ),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: _SectionHeader()),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  4,
                  AppPadding.p16,
                  AppPadding.p100,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSize.s14,
                    mainAxisSpacing: AppSize.s14,
                    childAspectRatio: 0.95,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => tiles[i],
                    childCount: tiles.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppPadding.p20,
        AppPadding.p20,
        AppPadding.p20,
        AppPadding.p14,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AdminViewBody._gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppSize.s14),
              border: Border.all(
                color: AdminViewBody._gold.withValues(alpha: 0.5),
              ),
            ),
            child: const Icon(
              Icons.medical_information_rounded,
              color: AdminViewBody._darkGreen,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSize.s12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تعليمات وإرشادات',
                  style: TextStyle(
                    color: AdminViewBody._darkGreen,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Cairo',
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'إدارية وطبية',
                  style: TextStyle(
                    color: AdminViewBody._muted,
                    fontSize: 12.5,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTile extends StatelessWidget {
  const _SectionTile({
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
      borderRadius: BorderRadius.circular(AppSize.s20),
      elevation: 3,
      shadowColor: const Color(0x22000000),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s20),
            border: Border.all(
              color: color.withValues(alpha: 0.30),
              width: 1.3,
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                color.withValues(alpha: 0.10),
                Colors.white,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -18,
                left: -18,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.06),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p14,
                  AppPadding.p16,
                  AppPadding.p14,
                  AppPadding.p14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.14),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: color.withValues(alpha: 0.55),
                              width: 1.4,
                            ),
                          ),
                          child: Icon(icon, color: color, size: 26),
                        ),
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: color,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AdminViewBody._darkGreen,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Cairo',
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AdminViewBody._ink.withValues(alpha: 0.6),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 3,
                          width: 36,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [color, color.withValues(alpha: 0)],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
