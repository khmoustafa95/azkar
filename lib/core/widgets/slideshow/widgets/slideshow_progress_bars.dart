import 'package:flutter/material.dart';

/// Row of thin segmented progress bars rendered at the top of an
/// [ImmersiveSlideShow], one segment per slide.
///
/// * Segments before [currentIndex] are fully filled.
/// * Segment at [currentIndex] follows the supplied [progress] animation.
/// * Segments after [currentIndex] are empty.
class SlideshowProgressBars extends StatelessWidget {
  const SlideshowProgressBars({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.progress,
    this.height = 3,
    this.spacing = 4,
    this.barColor = Colors.white,
    this.trackColor = const Color(0x55FFFFFF),
  });

  final int count;
  final int currentIndex;

  /// Animation in `[0, 1]` representing how much of the current slide has
  /// elapsed. Pass the [AnimationController] driving auto-advance.
  final Animation<double> progress;

  final double height;
  final double spacing;
  final Color barColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++) ...[
          Expanded(
            child: _Segment(
              height: height,
              fill: i < currentIndex
                  ? const AlwaysStoppedAnimation<double>(1)
                  : i == currentIndex
                      ? progress
                      : const AlwaysStoppedAnimation<double>(0),
              barColor: barColor,
              trackColor: trackColor,
            ),
          ),
          if (i != count - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
    required this.height,
    required this.fill,
    required this.barColor,
    required this.trackColor,
  });

  final double height;
  final Animation<double> fill;
  final Color barColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: trackColor,
        child: AnimatedBuilder(
          animation: fill,
          builder: (context, _) {
            return FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: fill.value.clamp(0.0, 1.0),
              child: Container(color: barColor),
            );
          },
        ),
      ),
    );
  }
}
