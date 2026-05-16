import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/hajj_tracker/data/hajj_tracker_steps.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/cubit/hajj_tracker_state.dart';

class HajjTrackerCubit extends Cubit<HajjTrackerState> {
  HajjTrackerCubit(this._prefs)
      : super(
          HajjTrackerState(
            pilgrimName: _prefs.getHajjPilgrimNameSync(),
            steps: _prefs.getHajjStepsSync(kHajjTrackerStepCount),
            umrahCount: _prefs.getHajjUmrahCountSync(),
          ),
        );

  final AppPreferences _prefs;

  Future<void> refreshFromPrefs() async {
    emit(
      HajjTrackerState(
        pilgrimName: _prefs.getHajjPilgrimNameSync(),
        steps: _prefs.getHajjStepsSync(kHajjTrackerStepCount),
        umrahCount: _prefs.getHajjUmrahCountSync(),
      ),
    );
  }

  /// Toggle: checking requires previous step; unchecking clears this and all later steps.
  Future<void> toggleStep(int index) async {
    if (index < 0 || index >= kHajjTrackerStepCount) return;
    final current = state.steps;
    if (current[index]) {
      final cleared = List<bool>.from(current);
      for (var i = index; i < kHajjTrackerStepCount; i++) {
        cleared[i] = false;
      }
      emit(state.copyWith(steps: cleared));
    } else {
      if (!state.canTurnOn(index)) return;
      final next = List<bool>.from(current);
      next[index] = true;
      emit(state.copyWith(steps: next));
    }
    await _persist();
  }

  Future<void> resetProgress() async {
    emit(
      state.copyWith(
        steps: List<bool>.filled(kHajjTrackerStepCount, false),
        umrahCount: 0,
      ),
    );
    await _persist();
  }

  /// Saves the finished umrah cycle and clears the first five steps only.
  Future<bool> startNewUmrah() async {
    if (!state.allUmrahStepsDone) return false;

    final cleared = List<bool>.from(state.steps);
    for (var i = 0; i < kHajjUmrahRepeatableStepCount; i++) {
      cleared[i] = false;
    }

    emit(
      state.copyWith(
        steps: cleared,
        umrahCount: state.umrahCount + 1,
      ),
    );
    await _persist();
    return true;
  }

  Future<void> _persist() async {
    await _prefs.setHajjSteps(state.steps);
    await _prefs.setHajjUmrahCount(state.umrahCount);
  }
}
