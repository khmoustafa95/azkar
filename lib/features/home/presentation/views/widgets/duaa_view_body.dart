import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/hajj_tracker/data/hajj_tracker_steps.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/cubit/hajj_tracker_cubit.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_scroll_view.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_welcome_view.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:holly_quran/features/home/presentation/view_models/duaa/duaa/duaa_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_adiya_hub_view.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_category_list_view.dart';
import 'package:holly_quran/features/quran/presentation/cubit/quran_cubit.dart';
import 'package:holly_quran/features/quran/presentation/views/quran_reading_view.dart';

/// نوع بلاطة في شبكة «القرآن والمحتوى».
enum DuaaHomeTileKind {
  quran,
  hajjTracker,
  categoryFiqhHajj,
  categoryAdiya,
  categoryFiqhMessages,
  categoryPilgrimAdvice,
}

/// بلاطة واحدة: قرآن، متابعة الحاج، أو قسم محتوى (دعاء/فيديو…).
class DuaaHomeTileSpec {
  const DuaaHomeTileSpec({
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.color,
  });

  final DuaaHomeTileKind kind;
  final String title;
  final String subtitle;

  /// PNG under `assets/icon/` (see [IconAssets] tile* constants).
  final String imageAsset;
  final Color color;

  /// مفتاح [DuaaModel.category] عند فتح قائمة المحتوى.
  String? get categoryKey {
    switch (kind) {
      case DuaaHomeTileKind.categoryFiqhHajj:
        return DuaaContentCategory.fiqhHajj;
      case DuaaHomeTileKind.categoryAdiya:
        return DuaaContentCategory.audioDuas;
      case DuaaHomeTileKind.categoryFiqhMessages:
        return DuaaContentCategory.fiqhMessages;
      case DuaaHomeTileKind.categoryPilgrimAdvice:
        return DuaaContentCategory.pilgrimAdvice;
      case DuaaHomeTileKind.quran:
      case DuaaHomeTileKind.hajjTracker:
        return null;
    }
  }
}

/// ترتيب البلاطات كما طُلب: قرآن، متابعة الحاج، ثم أقسام المحتوى.
const List<DuaaHomeTileSpec> kDuaaHomeTiles = [
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.quran,
    title: 'القرآن الكريم',
    subtitle: 'تلاوة وقراءة',
    imageAsset: IconAssets.quran,
    color: Color(0xFFC9A961),
  ),
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.hajjTracker,
    title: 'متابعة أعمال الحاج',
    subtitle: 'سجل المناسك',
    imageAsset: IconAssets.steps,
    color: Color(0xFF0F5847),
  ),
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.categoryFiqhHajj,
    title: 'فقه الحج',
    subtitle: 'فيديوهات وإرشادات',
    imageAsset: IconAssets.mareiat,
    color: Color(0xFF1E5A7A),
  ),
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.categoryAdiya,
    title: 'أدعية',
    subtitle: 'استماع وتلاوة',
    imageAsset: IconAssets.duaa,
    color: Color(0xFF2D6A4F),
  ),
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.categoryFiqhMessages,
    title: 'رسائل فقهية',
    subtitle: 'مواد مختصرة',
    imageAsset: IconAssets.mareiat,
    color: Color(0xFFB85A33),
  ),
  DuaaHomeTileSpec(
    kind: DuaaHomeTileKind.categoryPilgrimAdvice,
    title: 'وصايا الحاج',
    subtitle: 'نصائح للحاج',
    imageAsset: IconAssets.doknow,
    color: Color(0xFF8B6914),
  ),
];

class DuaaViewBody extends StatelessWidget {
  const DuaaViewBody({super.key});

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);
  static const Color _ink = Color(0xFF1A2421);
  static const Color _muted = Color(0xFF6B7570);

  static void _openQuran(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
          create: (_) => QuranCubit(
            getIt.get<HomeRepoImpl>(),
            getIt.get<AppPreferences>(),
          )..fetchQuran(),
          child: const QuranReadingView(),
        ),
      ),
    );
  }

  static void _openHajjTracker(BuildContext context) {
    final prefs = getIt<AppPreferences>();
    final steps = prefs.getHajjStepsSync(kHajjTrackerStepCount);
    final hasProgress = steps.any((e) => e);
    if (hasProgress) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => BlocProvider(
            create: (_) => HajjTrackerCubit(prefs),
            child: const HajjTrackerScrollView(),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const HajjTrackerWelcomeView(),
        ),
      );
    }
  }

  static void _handleTileTap(BuildContext context, DuaaHomeTileSpec spec) {
    switch (spec.kind) {
      case DuaaHomeTileKind.quran:
        _openQuran(context);
        return;
      case DuaaHomeTileKind.hajjTracker:
        _openHajjTracker(context);
        return;
      case DuaaHomeTileKind.categoryAdiya:
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const DuaaAdiyaHubView(),
          ),
        );
        return;
      case DuaaHomeTileKind.categoryFiqhHajj:
      case DuaaHomeTileKind.categoryFiqhMessages:
      case DuaaHomeTileKind.categoryPilgrimAdvice:
        final cat = spec.categoryKey!;
        final cubitState = context.read<DuaaCubit>().state;
        if (cubitState is! DuaaSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                'يرجى الانتظار، جاري تحميل المحتوى…',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => DuaaCategoryListView(
              category: cat,
              title: spec.title,
            ),
          ),
        );
        return;
    }
  }

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
          child: CustomScrollView(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSize.s14,
                    mainAxisSpacing: AppSize.s14,
                    childAspectRatio: 0.95,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final spec = kDuaaHomeTiles[i];
                      return _DuaaGridTile(
                        spec: spec,
                        onTap: () => _handleTileTap(context, spec),
                      );
                    },
                    childCount: kDuaaHomeTiles.length,
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
                  'زاد المناسك',
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

/// Tile illustration from `assets/icon/` (PNG may include its own plate color).
class _DuaaTileImage extends StatelessWidget {
  const _DuaaTileImage({
    required this.assetPath,
    required this.accent,
  });

  final String assetPath;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 52,
        height: 52,
        color: accent.withValues(alpha: 0.12),
        alignment: Alignment.center,
        child: Image.asset(
          assetPath,
          width: 52,
          height: 52,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}

class _DuaaGridTile extends StatelessWidget {
  const _DuaaGridTile({
    required this.spec,
    required this.onTap,
  });

  final DuaaHomeTileSpec spec;
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
                        _DuaaTileImage(
                          assetPath: spec.imageAsset,
                          accent: color,
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
