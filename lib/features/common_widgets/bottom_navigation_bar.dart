import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/view_models/bottom_navBar/bottom_nav_bar_cubit.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.cubit,
    required this.currentIndex,
    super.key,
  });

  final BottomNavBarCubit cubit;
  final int currentIndex;

  static const _navBarIcons = [
    ImageAssets.azkarMasaa,
    ImageAssets.hesnMuslim,
    ImageAssets.share,
    ImageAssets.about,
  ];

  static const _navBarTitles = [
    AppStrings.pilgrimBag,
    AppStrings.pilgrimGuide,
    AppStrings.admins,
    AppStrings.who,
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      height: AppSize.s100,
      itemCount: BottomNavBarCubit.allItemsCount - 1,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? AppColors.white : AppColors.grey;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_navBarIcons[index], width: AppSize.s50),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  _navBarTitles[index],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: color,
                      ),
                ),
              ),
            ),
          ],
        );
      },
      backgroundColor: AppColors.primary,
      activeIndex: currentIndex,
      splashSpeedInMilliseconds: AppConstants.bottomNavSpeedTime,
      notchSmoothness: NotchSmoothness.defaultEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: AppSize.s32,
      rightCornerRadius: AppSize.s32,
      onTap: (index) => cubit.changeIndex(index: index),
    );
  }
}
