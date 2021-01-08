import 'package:flutter/material.dart';

import 'progress.dart';

class CycleIndicator extends StatelessWidget {
  const CycleIndicator({
    Key key,
    @required this.cycles,
    @required this.currentCycle,
  }) : super(key: key);
  final int cycles;
  final int currentCycle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: _children,
    );
  }

  List<Widget> get _children {
    final children = <Widget>[];
    var currentW = 0;
    for (var cycle = 0; cycle < currentCycle; cycle++) {
      children.add(
        currentW.isEven
            ? const ProgressPill(greyedOut: false)
            : const ProgressDot(greyedOut: false),
      );
      currentW++;
    }
    final remaining = cycles - currentCycle;
    for (var cycle = 0; cycle < remaining; cycle++) {
      children.add(
        currentW.isEven
            ? const ProgressPill(greyedOut: true)
            : const ProgressDot(greyedOut: true),
      );
      currentW++;
    }
    return children;
  }
}
