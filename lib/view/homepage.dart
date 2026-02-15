import 'dart:async';

import 'package:brickbreakdown/view/ball.dart';
import 'package:brickbreakdown/view/coverscreen.dart';
import 'package:brickbreakdown/view/player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double ballX = 0;
  double ballY = 0;

  //startGame
  void startGame() {
    hasGameStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        ballY += 0.001;
      });
    });
  }

  //move player left
  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 <= -1)) {
        playerX -= 0.2;
      }
    });
  }

  //move player right
  void moveRight() {
    setState(() {
      if (!(playerX + 0.2 >= 1)) {
        playerX += 0.2;
      }
    });
  }

  //player
  double playerX = 0;
  double playerWidth = 0.3;

  //Game Settings
  bool hasGameStarted = false;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                //tap to play
                Coverscreen(hasGameStarted: hasGameStarted),
                //ball
                Ball(ballX: ballX, ballY: ballY),
                //player
                Player(playerWidth: playerWidth, playerX: playerX),
                Container(
                  alignment: Alignment(playerX, 0.9),
                  child: Container(
                    color: currentTheme.colorScheme.tertiary,
                    width: 4,
                    height: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
