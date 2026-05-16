import 'package:holly_quran/features/hajj_tracker/data/hajj_tracker_steps.dart';

class HajjTrackerState {
  const HajjTrackerState({
    required this.pilgrimName,
    required this.steps,
    this.umrahCount = 0,
  });

  final String pilgrimName;
  final List<bool> steps;

  /// Completed umrah cycles (after tapping «بدء عمرة جديدة»).
  final int umrahCount;

  bool get allComplete =>
      steps.length == kHajjTrackerStepCount && steps.every((e) => e);

  bool isDone(int index) => index >= 0 && index < steps.length && steps[index];

  /// May turn ON step [index] only if previous is done (or index 0).
  bool canTurnOn(int index) {
    if (index < 0 || index >= steps.length) return false;
    if (steps[index]) return true;
    return index == 0 || steps[index - 1];
  }

  bool get allUmrahStepsDone {
    if (steps.length < kHajjUmrahRepeatableStepCount) return false;
    for (var i = 0; i < kHajjUmrahRepeatableStepCount; i++) {
      if (!steps[i]) return false;
    }
    return true;
  }

  /// Includes the current cycle when its five umrah steps are all checked.
  int get displayUmrahCount => umrahCount + (allUmrahStepsDone ? 1 : 0);

  HajjTrackerState copyWith({
    String? pilgrimName,
    List<bool>? steps,
    int? umrahCount,
  }) {
    return HajjTrackerState(
      pilgrimName: pilgrimName ?? this.pilgrimName,
      steps: steps ?? List<bool>.from(this.steps),
      umrahCount: umrahCount ?? this.umrahCount,
    );
  }
}
