import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class ProgressPill extends StatelessWidget {
  const ProgressPill({
    Key key,
    @required this.greyedOut,
  }) : super(key: key);

  final bool greyedOut;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 6,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: greyedOut ? greyColor : lightCyan,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class ProgressDot extends StatelessWidget {
  const ProgressDot({
    Key key,
    @required this.greyedOut,
  }) : super(key: key);

  final bool greyedOut;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: greyedOut ? greyColor : lightCyan,
        shape: BoxShape.circle,
      ),
    );
  }
}
