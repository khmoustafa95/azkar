import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/view_models/bottom_navBar/bottom_nav_bar_cubit.dart';

/// Docked bottom bar with a center notch for [HomeView]'s FAB.
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

  /// Matches [HomeView] FAB (80) + [CircularNotchedRectangle] margin.
  static const double _fabSlotWidth = 88;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: AppColors.primary,
      height: AppSize.s70,
      padding: const EdgeInsets.only(
        left: AppPadding.p6,
        right: AppPadding.p6,
        top: AppPadding.p4,
        bottom: AppPadding.p2,
      ),
      notchMargin: AppSize.s8,
      shape: const CircularNotchedRectangle(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final fabSlot = constraints.maxWidth < 360
              ? _fabSlotWidth + 8
              : constraints.maxWidth > 600
                  ? _fabSlotWidth + 16
                  : _fabSlotWidth;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _NavSide(
                  indices: const [0, 1],
                  currentIndex: currentIndex,
                  onTap: cubit.changeIndex,
                ),
              ),
              SizedBox(width: fabSlot),
              Expanded(
                child: _NavSide(
                  indices: const [2, 3],
                  currentIndex: currentIndex,
                  onTap: cubit.changeIndex,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NavSide extends StatelessWidget {
  const _NavSide({
    required this.indices,
    required this.currentIndex,
    required this.onTap,
  });

  final List<int> indices;
  final int currentIndex;
  final void Function({required int index}) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < indices.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSize.s4),
          Expanded(
            child: _NavItem(
              isActive: currentIndex == indices[i],
              iconAsset: AppBottomNavigationBar._navBarIcons[indices[i]],
              label: AppBottomNavigationBar._navBarTitles[indices[i]],
              onTap: () => onTap(index: indices[i]),
            ),
          ),
        ],
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.isActive,
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  final bool isActive;
  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  static const double _iconSize = 36;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.white : AppColors.grey;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p2,
            vertical: AppPadding.p2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                width: _iconSize,
                height: _iconSize,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
