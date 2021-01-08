import 'package:meta/meta.dart';

class PomodoroTime {
  PomodoroTime({
    @required this.workTime,
    @required this.restTime,
  });

  final int workTime;
  final int restTime;
}
