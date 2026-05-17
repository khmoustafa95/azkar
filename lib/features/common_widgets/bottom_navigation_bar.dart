import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
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
    return BottomAppBar(
      color: AppColors.primary,
      height: AppSize.s100,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
      shape: const CircularNotchedRectangle(),
      notchMargin: AppSize.s8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(BottomNavBarCubit.allItemsCount - 1, (index) {
          final isActive = currentIndex == index;
          final color = isActive ? AppColors.white : AppColors.grey;
          return Expanded(
            child: InkWell(
              onTap: () => cubit.changeIndex(index: index),
              child: Column(
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
