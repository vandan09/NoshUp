import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.redAccent.shade400,
              Colors.redAccent,
            ]),
      ),
    );
  }
}
