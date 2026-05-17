import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';

/// Unified app bar: back arrow (left in RTL row), centered title, home shortcut.
class AppNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  const AppNavigationBar({
    required this.title,
    super.key,
    this.actions = const [],
    this.showHomeButton = true,
    this.onBack,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
  });

  final String title;
  final List<Widget> actions;
  final bool showHomeButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color foregroundColor;

  static const Color defaultBarGreen = Color(0xFF083A30);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _goBack(BuildContext context) {
    if (onBack != null) {
      onBack!();
      return;
    }
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(Routes.homeRoute);
    }
  }

  void _goHome(BuildContext context) {
    context.go(Routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w800,
          fontSize: 17,
          fontFamily: 'Cairo',
        );

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: foregroundColor,
      elevation: 4,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            tooltip: 'رجوع',
            onPressed: () => _goBack(context),
            icon: Image.asset(ImageAssets.arrow, width: 30),
          ),
          Expanded(
            child: Text(
              title.trim(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
          ),
          if (showHomeButton)
            IconButton(
              tooltip: 'الرئيسية',
              onPressed: () => _goHome(context),
              icon: Image.asset(ImageAssets.home, width: 35),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
      actions: actions.isEmpty ? null : actions,
    );
  }
}

/// @deprecated Use [AppNavigationBar] — kept for existing imports.
typedef MyAppBar = AppNavigationBar;

/// @deprecated Use [AppNavigationBar] — kept for existing imports.
typedef QuranAppBar = AppNavigationBar;
