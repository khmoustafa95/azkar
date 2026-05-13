import 'package:holly_quran/features/hajj_tracker/data/hajj_tracker_steps.dart';

class HajjTrackerState {
  const HajjTrackerState({
    required this.pilgrimName,
    required this.steps,
  });

  final String pilgrimName;
  final List<bool> steps;

  bool get allComplete =>
      steps.length == kHajjTrackerStepCount && steps.every((e) => e);

  bool isDone(int index) => index >= 0 && index < steps.length && steps[index];

  /// May turn ON step [index] only if previous is done (or index 0).
  bool canTurnOn(int index) {
    if (index < 0 || index >= steps.length) return false;
    if (steps[index]) return true;
    return index == 0 || steps[index - 1];
  }

  HajjTrackerState copyWith({
    String? pilgrimName,
    List<bool>? steps,
  }) {
    return HajjTrackerState(
      pilgrimName: pilgrimName ?? this.pilgrimName,
      steps: steps ?? List<bool>.from(this.steps),
    );
  }
}
