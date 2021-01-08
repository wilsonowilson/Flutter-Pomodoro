import 'package:flutter/material.dart';

class TimerActionButton extends StatelessWidget {
  const TimerActionButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
  })  : assert(icon != null && onPressed != null),
        super(key: key);

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: FloatingActionButton(
        child: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
