// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service_modules.dart';
import '../logic/settings_logic/settings_cubit_cubit.dart';
import '../core/preferences_service.dart';
import '../logic/timer_logic/timer_cubit.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final serviceModules = _$ServiceModules();
  final resolvedSharedPreferences = await serviceModules.prefs;
  gh.factory<SharedPreferences>(() => resolvedSharedPreferences);
  gh.lazySingleton<StorageService>(
      () => StorageService(get<SharedPreferences>()));
  gh.factory<TimerCubit>(() => TimerCubit(get<StorageService>()));
  gh.factory<SettingsCubitCubit>(
      () => SettingsCubitCubit(get<StorageService>()));
  return get;
}

class _$ServiceModules extends ServiceModules {}
