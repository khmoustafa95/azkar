import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/app_page_carousel.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/home/data/models/duaa/group_model.dart';

import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import 'card_member.dart';

class GroupDetailsView extends StatefulWidget {
  final GroupModel group;
  final String id;

  const GroupDetailsView({super.key, required this.group, required this.id});

  @override
  State<GroupDetailsView> createState() => _GroupDetailsViewState();
}

class _GroupDetailsViewState extends State<GroupDetailsView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final viewportFraction =
        Responsive.groupCarouselViewportFraction(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppNavigationBar(title: widget.group.name),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Responsive.contentMaxWidth(context),
                      maxHeight: constraints.maxHeight,
                    ),
                    child: widget.group.members.isEmpty
                        ? _EmptyMembersPlaceholder(
                            maxHeight: constraints.maxHeight,
                          )
                        : Column(
                            children: [
                              const SizedBox(height: AppSize.s8),
                              Expanded(
                                child: RepaintBoundary(
                                  child: AppPageCarousel(
                                    itemCount: widget.group.members.length,
                                    viewportFraction: viewportFraction,
                                    alignItemsTop: true,
                                    autoPlay: true,
                                    onPageChanged: (index) =>
                                        setState(() => activeIndex = index),
                                    itemBuilder: (ctx, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppPadding.p8,
                                          vertical: AppPadding.p4,
                                        ),
                                        child: CardMember(
                                          member:
                                              widget.group.members[index],
                                          logo: widget.group.logo,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSize.s16),
                              _MemberCarouselDots(
                                count: widget.group.members.length,
                                activeIndex: activeIndex,
                              ),
                              const SizedBox(height: AppPadding.p16),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyMembersPlaceholder extends StatelessWidget {
  const _EmptyMembersPlaceholder({required this.maxHeight});

  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight,
      child: Center(
        child: Text(
          'لا يوجد اعضاء في هذه المجموعة',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}

class _MemberCarouselDots extends StatelessWidget {
  const _MemberCarouselDots({
    required this.count,
    required this.activeIndex,
  });

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
            color: activeIndex == index
                ? AppColors.primary
                : Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
