part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(this.pomodoroTime);
  final PomodoroTime pomodoroTime;
  @override
  List<Object> get props => [pomodoroTime];
}

// class SettingsCubitSaving extends SettingsCubitState {}

class SettingsSaved extends SettingsState {}

class SettingsError extends SettingsState {}
