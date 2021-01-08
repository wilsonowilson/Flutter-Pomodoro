import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../constants/pomodoro_constants.dart';
import '../../core/pomodoro_time.dart';
import '../../core/preferences_service.dart';

part 'settings_state.dart';

@Injectable()
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._storage) : super(SettingsInitial());

  final StorageService _storage;

  void getExistingTimes() {
    final times = _storage.getTimes();
    final workTime = times.workTime ?? kWorkTime;
    final restTime = times.restTime ?? kRestTime;
    emit(SettingsLoaded(PomodoroTime(
      workTime: workTime,
      restTime: restTime,
    )));
  }

  void saveTimes(int work, int relax) {
    _storage.saveTimes(PomodoroTime(workTime: work, restTime: relax));
    emit(SettingsSaved());
  }
}
