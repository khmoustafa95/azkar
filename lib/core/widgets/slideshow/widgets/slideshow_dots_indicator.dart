import 'package:flutter/material.dart';

/// Animated dot indicator for [SlideShow]. The active dot widens into a
/// short pill to provide clear focus, similar to popular onboarding
/// indicators.
class SlideshowDotsIndicator extends StatelessWidget {
  const SlideshowDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor = const Color(0xFF0F5847),
    this.inactiveColor = const Color(0xFFCFD6D2),
    this.size = 7,
    this.activeWidth = 22,
    this.spacing = 6,
  });

  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double activeWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++) ...[
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: i == currentIndex ? activeWidth : size,
              height: size,
              decoration: BoxDecoration(
                color: i == currentIndex ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(size),
              ),
            ),
            if (i != count - 1) SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}
