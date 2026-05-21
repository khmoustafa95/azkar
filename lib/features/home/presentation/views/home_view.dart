import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/bottom_navigation_bar.dart';
import 'package:holly_quran/features/contact_us/presentation/widgets/contact_us_view_body.dart';
import 'package:holly_quran/features/home/presentation/view_models/bottom_navBar/bottom_nav_bar_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/admin_view_body.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_view_body.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/group_view_body.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const _tabTitles = [
    'زاد المناسك',
    'تعليمات و إرشادات',
    'مجموعات التكتل',
    'من نحن ؟',
    'الصفحة الرئيسية',
  ];

  static const _tabBodies = [
    DuaaViewBody(),
    AdminViewBody(),
    GroupViewBody(),
    ContactUsViewBody(),
    HomeViewBody(),
  ];

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
        buildWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
        builder: (context, state) {
          final cubit = context.read<BottomNavBarCubit>();
          final index = state.currentIndex;
          final isHomeTab = index >= BottomNavBarCubit.allItemsCount;
          final stackIndex =
              isHomeTab ? BottomNavBarCubit.allItemsCount - 1 : index;
          final titleIndex = isHomeTab ? 4 : index;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(_tabTitles[titleIndex.clamp(0, _tabTitles.length - 1)]),
              elevation: 5,
              leading: Container(
                margin: const EdgeInsets.all(AppPadding.p2),
                padding: const EdgeInsets.all(AppPadding.p2),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/icon.png'),
                ),
              ),
              titleTextStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: IndexedStack(
              index: stackIndex,
              children: _tabBodies,
            ),
            floatingActionButton: isKeyboardOpen
                ? null
                : SizedBox(
                    height: Responsive.isTablet(context)
                        ? AppSize.s70
                        : AppSize.s80,
                    width: Responsive.isTablet(context)
                        ? AppSize.s70
                        : AppSize.s80,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.primary,
                      shape: const CircleBorder(),
                      onPressed: () {
                        cubit.changeIndex(
                          index: BottomNavBarCubit.allItemsCount,
                        );
                      },
                      child: Image.asset(
                        ImageAssets.home,
                        fit: BoxFit.cover,
                        width: AppSize.s50,
                      ),
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AppBottomNavigationBar(
              cubit: cubit,
              currentIndex: index.clamp(0, BottomNavBarCubit.allItemsCount - 1),
            ),
          );
        },
      ),
    );
  }
}
