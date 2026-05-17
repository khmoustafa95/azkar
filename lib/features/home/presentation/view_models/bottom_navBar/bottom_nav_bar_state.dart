part of 'bottom_nav_bar_cubit.dart';

@immutable
class BottomNavBarState {
  const BottomNavBarState(this.currentIndex);

  final int currentIndex;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavBarState && currentIndex == other.currentIndex;

  @override
  int get hashCode => currentIndex.hashCode;
}
