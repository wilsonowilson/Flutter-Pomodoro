import 'package:flutter/material.dart';

import '../components/action_bar.dart';
import '../components/desktop_bindings.dart';
import '../components/timer_info.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesktopBindings(
      child: Scaffold(
        body: Row(
          children: [
            ActionBar(),
            Expanded(child: TimerInfo()),
          ],
        ),
      ),
    );
  }
}
