import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:window_activator/window_activator.dart';
import 'package:window_size/window_size.dart';

import 'constants/color_constants.dart';
import 'constants/size_constants.dart';
import 'injection/injection.dart';
import 'logic/settings_logic/settings_cubit.dart';
import 'logic/timer_logic/timer_cubit.dart';
import 'views/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(kWindowSize);
  setWindowMaxSize(kWindowSize);
  await configureInjection(Environment.prod);
  const initializationSettingsMacOS = MacOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: false,
    // requestSoundPermission: true,
  );
  const initializationSettings = InitializationSettings(
    macOS: initializationSettingsMacOS,
  );
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (_) => WindowActivator.activateWindow(),
  );
  runApp(Pomodoro());
}

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TimerCubit>()..initTimes()),
        BlocProvider(
          create: (context) => getIt<SettingsCubit>()..getExistingTimes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          fontFamily: 'Montserrat',
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<TimerCubit>()..initTimes()),
            BlocProvider(
              create: (context) => getIt<SettingsCubit>()..getExistingTimes(),
            ),
          ],
          child: HomeScreen(),
        ),
      ),
    );
  }
}
