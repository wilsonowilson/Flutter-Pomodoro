import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:window_activator/window_activator.dart';

import '../../constants/color_constants.dart';
import '../../logic/timer_logic/timer_cubit.dart';
import '../widgets/cycle_indicator.dart';

class TimerInfo extends StatefulWidget {
  @override
  _TimerInfoState createState() => _TimerInfoState();
}

class _TimerInfoState extends State<TimerInfo> {
  AudioPlayer player;
  FlutterLocalNotificationsPlugin notifications;

  @override
  void initState() {
    player = AudioPlayer();
    notifications = FlutterLocalNotificationsPlugin();
    initNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerCubit>();
    final state = timer.state;
    final minutesStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');

    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) async {
        if (state.status == TimerStatus.complete) {
          _onComplete(state);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '$minutesStr:$secondsStr',
                  maxLines: 1,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 86,
                      fontWeight: FontWeight.w900,
                      fontFeatures: [
                        FontFeature.tabularFigures(),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CycleIndicator(
                    cycles: state.cycles,
                    currentCycle: state.currentCycle,
                  ),
                  Text(
                    state.mode.asString.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onComplete(TimerState state) async {
    final message = !state.mode.isWork
        ? 'Time to take a break'
        : 'Let\'s get back to work!';
    if (await WindowActivator.isMiniaturized()) {
      await notifications.show(
        0,
        'Cycle completed',
        message,
        const NotificationDetails(
          macOS: MacOSNotificationDetails(
            subtitle: 'Click to go back to the app',
          ),
        ),
      );
    } else {
      await WindowActivator.activateWindow();
      await player.setAsset('audio/ding.mp3');
      await player.play();
      await player.seekToPrevious();
    }
  }

  void initNotifications() async {
    await notifications
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
}
