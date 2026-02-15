import 'package:flutter/material.dart';

class Coverscreen extends StatelessWidget {
  final bool hasGameStarted;
  Coverscreen({required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.1),
            child: Text(
              "Tap to Play",
              style: TextStyle(color: currentTheme.colorScheme.tertiary),
            ),
          );
  }
}
