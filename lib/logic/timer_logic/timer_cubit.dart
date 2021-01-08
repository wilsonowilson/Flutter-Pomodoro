import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:pomodoro/core/pomodoro_time.dart';

import '../../constants/pomodoro_constants.dart';
import '../../core/preferences_service.dart';
import '../../core/ticker.dart' as tick;

part 'timer_state.dart';

@Injectable()
class TimerCubit extends Cubit<TimerState> {
  TimerCubit(this._storage) : super(TimerState.initial());

  final StorageService _storage;
  final ticker = tick.Ticker();

  StreamSubscription<int> _tickerSubscription;

  void initTimes() {
    final times = _storage.getTimes();
    final workTime = times.workTime ?? 10;
    final restTime = times.restTime ?? 3;
    emit(
      state.copyWith(
        duration: workTime,
        pomodoroTime: PomodoroTime(
          workTime: workTime,
          restTime: restTime,
        ),
      ),
    );
  }

  void startTimer() async {
    await _tickerSubscription?.cancel();
    emit(state.copyWith(status: TimerStatus.active));
    _tickerSubscription =
        ticker.tick(ticks: state.duration).listen(_mapTickerEventToState);
  }

  void _mapTickerEventToState(int event) {
    if (event > 0)
      emit(
        state.copyWith(
          status: TimerStatus.active,
          duration: event,
        ),
      );
    else
      nextCycle();
  }

  void nextCycle() {
    pauseTimer();
    final cycles = state.cycles;
    final currentCycle = state.currentCycle;
    if (cycles == currentCycle) {
      emit(state.copyWith(status: TimerStatus.complete));
      resetTimer();
      return;
    }

    /// Continue to next cycle
    final newCycle = currentCycle + 1;
    final newMode = state.mode.isWork ? TimerMode.relax : TimerMode.work;

    emit(state.copyWith(
      mode: newMode,
      status: TimerStatus.complete,
      duration: state.mode.isWork
          ? state.pomodoroTime.restTime
          : state.pomodoroTime.workTime,
      currentCycle: newCycle,
    ));
  }

  void pauseTimer() {
    if (state.status == TimerStatus.active) {
      _tickerSubscription?.pause();
      emit(state.copyWith(
        status: TimerStatus.paused,
      ));
    }
  }

  void resumeTimer() {
    if (state.status == TimerStatus.paused) {
      _tickerSubscription?.resume();
      emit(state.copyWith(status: TimerStatus.active));
    }
  }

  void resetTimer() async {
    await _tickerSubscription?.cancel();
    emit(TimerState.initial());
    initTimes();
  }
}
