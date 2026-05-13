import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';

/// Small pill button that cycles between a list of [Duration]s.
///
/// Renders as `⏱ ٨ ث` (clock icon + Arabic-numeral seconds). Tapping it
/// advances to the next duration in [durations]. Stateless on purpose —
/// the parent owns [currentIndex] and reacts to [onChanged].
class SlideshowSpeedChip extends StatelessWidget {
  const SlideshowSpeedChip({
    super.key,
    required this.durations,
    required this.currentIndex,
    required this.onChanged,
    this.foreground = Colors.white,
    this.background = const Color(0x33FFFFFF),
  });

  final List<Duration> durations;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final seconds = durations[currentIndex].inSeconds;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged((currentIndex + 1) % durations.length),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: foreground.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer_outlined, size: 14, color: foreground),
              const SizedBox(width: 4),
              Text(
                '${arNumber(seconds.toString())} ث',
                style: TextStyle(
                  color: foreground,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
