import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ballX = 0;
  double ballY = 0;
  void startGame() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY -= 0.01;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              //tap to play
              Container(
                alignment: Alignment(0, -0.2),
                child: Text(
                  "Tap to Play",
                  style: TextStyle(color: currentTheme.colorScheme.tertiary),
                ),
              ),
              //ball
              Container(
                alignment: Alignment(ballX, ballY),
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    color: currentTheme.colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
