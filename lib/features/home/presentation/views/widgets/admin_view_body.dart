import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/admin_instructions/presentation/views/admin_instructions_view.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:holly_quran/features/quran/presentation/views/quran_reading_view.dart';

/// Pilgrim services landing page.
///
/// Renders a 2×2 grid of section tiles. Tapping a tile is wired to a
/// placeholder; concrete destinations will be added in follow-up work.
class AdminViewBody extends StatelessWidget {
  const AdminViewBody({super.key});

  // Brand palette — matches the rest of the Hajj home screens.
  static const Color _primaryGreen = Color(0xFF0F5847);
  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);
  static const Color _ink = Color(0xFF1A2421);
  static const Color _muted = Color(0xFF6B7570);

  @override
  Widget build(BuildContext context) {
    final tiles = <_SectionTile>[
      _SectionTile(
        title: 'تعليمات إدارية',
        subtitle: 'إرشادات و توجيهات',
        icon: Icons.assignment_rounded,
        color: const Color(0xFF1E5A7A),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AdminInstructionsView(),
          ),
        ),
      ),
      _SectionTile(
        title: 'تعليمات طبية',
        subtitle: 'صحة و سلامة الحاج',
        icon: Icons.health_and_safety_rounded,
        color: const Color(0xFFB85A33),
        onTap: () => _showComingSoon(context, 'تعليمات طبية'),
      ),
      _SectionTile(
        title: 'القرآن الكريم',
        subtitle: 'تلاوة و قراءة',
        icon: Icons.menu_book_rounded,
        color: _gold,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => BlocProvider(
              create: (_) => QuranCubit(
                getIt.get<HomeRepoImpl>(),
                getIt.get<AppPreferences>(),
              )..fetchQuran(),
              child: const QuranReadingView(),
            ),
          ),
        ),
      ),
      _SectionTile(
        title: 'متابعة أعمال الحاج',
        subtitle: 'سجل المناسك',
        icon: Icons.checklist_rtl_rounded,
        color: _primaryGreen,
        onTap: () => _showComingSoon(context, 'متابعة أعمال الحاج'),
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
                    AppPadding.p16, 4, AppPadding.p16, AppPadding.p100),
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

  static void _showComingSoon(BuildContext context, String section) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _darkGreen,
        content: Text(
          'قسم «$section» سيتوفر قريباً',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header (small intro above the grid)
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPadding.p20, AppPadding.p20, AppPadding.p20, AppPadding.p14),
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
              Icons.dashboard_customize_rounded,
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
                  'خدمات الحاج',
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
                  'اختر القسم المطلوب',
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

// ─────────────────────────────────────────────────────────────────────────────
// Single grid tile
// ─────────────────────────────────────────────────────────────────────────────

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
              // Decorative corner accent
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
                    AppPadding.p14, AppPadding.p16, AppPadding.p14, AppPadding.p14),
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
