import 'package:flutter/material.dart';

import '../components/action_bar.dart';
import '../components/timer_info.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ActionBar(),
          Expanded(child: TimerInfo()),
        ],
      ),
    );
  }
}
