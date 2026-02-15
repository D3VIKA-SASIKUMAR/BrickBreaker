import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final ballX;
  final ballY;
  Ball({this.ballY, this.ballX});

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Container(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          color: currentTheme.colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
