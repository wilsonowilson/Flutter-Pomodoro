part of 'timer_cubit.dart';

enum TimerMode { work, relax }
enum TimerStatus { initial, active, paused, complete }

extension TimerModeExtension on TimerMode {
  bool get isWork => this == TimerMode.work;
  String get asString => toString().split('.').last;
}

class TimerState extends Equatable {
  TimerState({
    @required this.mode,
    @required this.status,
    @required this.duration,
    @required this.cycles,
    @required this.pomodoroTime,
    @required this.currentCycle,
  });

  factory TimerState.initial() => TimerState(
        mode: TimerMode.work,
        status: TimerStatus.initial,
        duration: kWorkTime,
        currentCycle: 1,
        cycles: kCycleCount,
        pomodoroTime: PomodoroTime(
          restTime: kRestTime,
          workTime: kWorkTime,
        ),
      );

  final TimerMode mode;
  final TimerStatus status;
  final int duration;
  final PomodoroTime pomodoroTime;
  final int cycles;
  final int currentCycle;
  @override
  List<Object> get props {
    return [
      mode,
      status,
      duration,
      cycles,
      currentCycle,
    ];
  }

  TimerState copyWith({
    TimerMode mode,
    TimerStatus status,
    int duration,
    PomodoroTime pomodoroTime,
    int cycles,
    int currentCycle,
  }) {
    return TimerState(
      mode: mode ?? this.mode,
      status: status ?? this.status,
      duration: duration ?? this.duration,
      pomodoroTime: pomodoroTime ?? this.pomodoroTime,
      cycles: cycles ?? this.cycles,
      currentCycle: currentCycle ?? this.currentCycle,
    );
  }
}
