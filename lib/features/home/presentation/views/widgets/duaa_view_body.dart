import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/duaa/duaa/duaa_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_category_list_view.dart';

/// One tile on the duaa / Hajj content grid ([DuaaModel.category] key + labels).
class DuaaCategoryTileSpec {
  final String category;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const DuaaCategoryTileSpec({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

const List<DuaaCategoryTileSpec> kDuaaCategoryTiles = [
  DuaaCategoryTileSpec(
    category: DuaaContentCategory.fiqhHajj,
    title: 'فقه الحج',
    subtitle: 'فيديوهات وإرشادات',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF1E5A7A),
  ),
  DuaaCategoryTileSpec(
    category: DuaaContentCategory.audioDuas,
    title: 'أدعية صوتية',
    subtitle: 'استماع وتلاوة',
    icon: Icons.graphic_eq_rounded,
    color: Color(0xFF0F5847),
  ),
  DuaaCategoryTileSpec(
    category: DuaaContentCategory.fiqhMessages,
    title: 'رسائل فقهية',
    subtitle: 'مواد مختصرة',
    icon: Icons.article_rounded,
    color: Color(0xFFB85A33),
  ),
  DuaaCategoryTileSpec(
    category: DuaaContentCategory.pilgrimAdvice,
    title: 'وصايا الحاج',
    subtitle: 'نصائح للحاج',
    icon: Icons.volunteer_activism_rounded,
    color: Color(0xFFC9A961),
  ),
];

class DuaaViewBody extends StatelessWidget {
  const DuaaViewBody({super.key});

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);
  static const Color _ink = Color(0xFF1A2421);
  static const Color _muted = Color(0xFF6B7570);

  @override
  Widget build(BuildContext context) {
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
          child: BlocBuilder<DuaaCubit, DuaaState>(
            builder: (context, state) {
              if (state is! DuaaSuccess) {
                return StateRender.fullLoadingScreenImage;
              }
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: _DuaaSectionHeader()),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p16,
                      4,
                      AppPadding.p16,
                      AppPadding.p100,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppSize.s14,
                        mainAxisSpacing: AppSize.s14,
                        childAspectRatio: 0.95,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final spec = kDuaaCategoryTiles[i];
                          return _DuaaCategoryTile(
                            spec: spec,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => DuaaCategoryListView(
                                    category: spec.category,
                                    title: spec.title,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        childCount: kDuaaCategoryTiles.length,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DuaaSectionHeader extends StatelessWidget {
  const _DuaaSectionHeader();

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
              color: DuaaViewBody._gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppSize.s14),
              border: Border.all(
                color: DuaaViewBody._gold.withValues(alpha: 0.5),
              ),
            ),
            child: const Icon(
              Icons.auto_stories_rounded,
              color: DuaaViewBody._darkGreen,
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
                  'الأدعية والمحتوى',
                  style: TextStyle(
                    color: DuaaViewBody._darkGreen,
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
                    color: DuaaViewBody._muted,
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

class _DuaaCategoryTile extends StatelessWidget {
  const _DuaaCategoryTile({
    required this.spec,
    required this.onTap,
  });

  final DuaaCategoryTileSpec spec;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = spec.color;
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
                          child: Icon(spec.icon, color: color, size: 26),
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
                          spec.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: DuaaViewBody._darkGreen,
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Cairo',
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          spec.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: DuaaViewBody._ink.withValues(alpha: 0.6),
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
