import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PomodoroTime extends Equatable {
  PomodoroTime({
    @required this.workTime,
    @required this.restTime,
  });

  final int workTime;
  final int restTime;

  @override
  List<Object> get props => [workTime, restTime];
}
