import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menubar/menubar.dart';
import 'package:provider/provider.dart';

import '../../logic/timer_logic/timer_cubit.dart';
import '../dialogs/settings_dialog.dart';

class SkipCycleIntent extends Intent {}

class ResetIntent extends Intent {}

class SettingsIntent extends Intent {}

class DesktopBindings extends StatefulWidget {
  const DesktopBindings({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _DesktopBindingsState createState() => _DesktopBindingsState();
}

class _DesktopBindingsState extends State<DesktopBindings> {
  final _skipKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyS,
  );
  final _resetKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyR,
  );
  final _settingsKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.comma,
  );

  TimerCubit timerCubit;
  bool _settingsOpen = false;
  @override
  void initState() {
    timerCubit = context.read<TimerCubit>();
    setApplicationMenu([
      Submenu(
        label: 'Timer',
        children: [
          MenuItem(
            label: 'Skip Cycle',
            shortcut: _skipKeySet,
            onClicked: _onSkipCycleClicked,
          ),
          MenuItem(
            label: 'Reset Timer',
            shortcut: _resetKeySet,
            onClicked: _onResetClicked,
          ),
          const MenuDivider(),
          MenuItem(
            label: 'Preferences',
            shortcut: _settingsKeySet,
            onClicked: _onSettingsClicked,
          ),
        ],
      ),
    ]);
    super.initState();
  }

  void _onSkipCycleClicked() {
    timerCubit.nextCycle();
  }

  void _onResetClicked() {
    timerCubit.resetTimer();
  }

  void _onSettingsClicked() async {
    if (!_settingsOpen) {
      _settingsOpen = true;
      final hasSaved = await showDialog<bool>(
        context: context,
        builder: (context) {
          return SettingsDialog();
        },
      );
      if (hasSaved ?? false) {
        timerCubit
          ..initTimes()
          ..resetTimer();
      }
      _settingsOpen = false;
    } else
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        _skipKeySet: SkipCycleIntent(),
        _resetKeySet: ResetIntent(),
        _settingsKeySet: SettingsIntent(),
      },
      actions: {
        SkipCycleIntent: CallbackAction(onInvoke: (e) => _onSkipCycleClicked()),
        ResetIntent: CallbackAction(onInvoke: (e) => _onResetClicked()),
        SettingsIntent: CallbackAction(onInvoke: (e) => _onSettingsClicked()),
      },
      child: widget.child,
    );
  }
}
