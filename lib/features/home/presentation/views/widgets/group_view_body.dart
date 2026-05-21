import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/app_page_carousel.dart';
import 'package:holly_quran/features/home/data/group_catalog_data.dart';
import 'package:holly_quran/features/home/data/models/duaa/group_model.dart';
import 'card_group.dart';

class GroupViewBody extends StatefulWidget {
  const GroupViewBody({super.key});

  @override
  State<GroupViewBody> createState() => _GroupViewBodyState();
}

class _GroupViewBodyState extends State<GroupViewBody> {
  int _activeIndex = 0;
  late final List<GroupModel> _groups;

  @override
  void initState() {
    super.initState();
    _groups = getAppGroupCatalog();
  }

  @override
  Widget build(BuildContext context) {
    final viewportFraction =
        Responsive.groupCarouselViewportFraction(context);

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.background),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: AppSize.s8),
                  Expanded(
                    child: RepaintBoundary(
                      child: AppPageCarousel(
                        itemCount: _groups.length,
                        viewportFraction: viewportFraction,
                        alignItemsTop: true,
                        autoPlay: true,
                        onPageChanged: (index) {
                          if (_activeIndex != index) {
                            setState(() => _activeIndex = index);
                          }
                        },
                        itemBuilder: (ctx, index) {
                          final group = _groups[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p8,
                            ),
                            child: CardGroup(
                              group: group,
                              saPhone: group.saPhone,
                              onTap: () => GoRouter.of(context).pushNamed(
                                Routes.groupDetailsRoute,
                                pathParameters: {'id1': '${group.id}'},
                                extra: group.toJson(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s12),
                  _GroupCarouselDots(
                    count: _groups.length,
                    activeIndex: _activeIndex,
                  ),
                  SizedBox(
                    height: Responsive.bottomChromeHeight(context),
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

class _GroupCarouselDots extends StatelessWidget {
  const _GroupCarouselDots({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeIndex == index ? AppColors.primary : Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
