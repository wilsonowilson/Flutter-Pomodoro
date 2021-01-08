import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';
import 'pomodoro_time.dart';

@LazySingleton()
class StorageService {
  StorageService(this._preferences);

  final SharedPreferences _preferences;

  void saveTimes(PomodoroTime pomodoroTime) {
    _preferences
      ..setInt(workTimeKey, pomodoroTime.workTime)
      ..setInt(restTimeKey, pomodoroTime.restTime);
  }

  PomodoroTime getTimes() {
    final workTime = _preferences.getInt(workTimeKey);
    final restTime = _preferences.getInt(restTimeKey);
    return PomodoroTime(restTime: restTime, workTime: workTime);
  }
}
