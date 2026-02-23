import 'package:flutter/material.dart';

class Coverscreen extends StatelessWidget {
  final bool hasGameStarted;
  const Coverscreen({super.key, required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return hasGameStarted
        ? Container()
        : Container(
            alignment: const Alignment(0, -0.1),
            child: Text(
              "Tap to Play",
              style: TextStyle(color: currentTheme.colorScheme.tertiary),
            ),
          );
  }
}
