import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(const BottomNavBarState(5));

  static const int allItemsCount = 5;

  int get currentIndex => state.currentIndex;

  void changeIndex({required int index}) {
    if (state.currentIndex == index) return;
    emit(BottomNavBarState(index));
  }
}
