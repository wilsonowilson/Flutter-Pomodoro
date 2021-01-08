import 'package:flutter/material.dart';
import 'package:pomodoro/views/dialogs/settings_dialog.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../logic/timer_logic/timer_cubit.dart';
import '../widgets/timer_action_button.dart';
import '../widgets/vertical_spacing.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerCubit>();
    final isActive = timer.state.status == TimerStatus.active;
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return SettingsDialog();
          },
        );
      },
      child: Container(
        width: 80,
        height: double.maxFinite,
        decoration: _getBarBackground(timer.state),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerActionButton(
              icon: isActive ? Icons.pause_rounded : Icons.play_arrow_rounded,
              onPressed: isActive ? timer.pauseTimer : timer.startTimer,
            ),
            const VerticalSpacing(20),
            TimerActionButton(
              icon: Icons.restore_rounded,
              onPressed: timer.resetTimer,
            ),
            const VerticalSpacing(20),
            TimerActionButton(
              icon: Icons.skip_next,
              onPressed: timer.nextCycle,
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getBarBackground(TimerState state) {
    final alignment =
        state.mode.isWork ? Alignment.center : Alignment.bottomRight;
    return BoxDecoration(
      image: DecorationImage(
        colorFilter: const ColorFilter.mode(
          Colors.black54,
          BlendMode.dstATop,
        ),
        image: const AssetImage(bgPath),
        fit: BoxFit.cover,
        alignment: alignment,
      ),
    );
  }
}
