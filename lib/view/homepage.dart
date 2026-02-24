import 'dart:async';
import 'package:brickbreakdown/theme/colorscheme.dart';
import 'package:brickbreakdown/view/ball.dart';
import 'package:brickbreakdown/view/brick.dart';
import 'package:brickbreakdown/view/coverscreen.dart';
import 'package:brickbreakdown/view/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Direction { up, down, left, right }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrements = 0.005;
  double ballYIncrements = 0.005;
  Direction ballYDirection = Direction.down;
  Direction ballXDirection = Direction.left;

  // player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // game settings
  bool hasGameStarted = false;
  bool isGameOver = false;
  bool hasWon = false;
  Timer? timer;

  // brick config
  static const int brickRows = 3;
  static const int bricksPerRow = 4;
  static const double brickWidth = 0.4;
  static const double brickHeight = 0.05;
  static const double brickGap = 0.04;

  List<List<dynamic>> myBricks = [];

  @override
  void initState() {
    super.initState();
    _initBricks();
  }

  void _initBricks() {
    myBricks.clear();
    double totalWidth =
        bricksPerRow * brickWidth + (bricksPerRow - 1) * brickGap;
    double startX = -1.0 + (2.0 - totalWidth) / 2.0;

    List<Color> rowColors = [
      LightGameColors.brickRed,
      LightGameColors.brickOrange,
      LightGameColors.brickYellow,
      LightGameColors.brickGreen,
    ];

    for (int row = 0; row < brickRows; row++) {
      for (int col = 0; col < bricksPerRow; col++) {
        double x = startX + col * (brickWidth + brickGap);
        double y = -0.8 + row * (brickHeight + brickGap);
        myBricks.add([x, y, false, rowColors[row % rowColors.length]]);
      }
    }
  }

  void resetGame() {
    setState(() {
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      isGameOver = false;
      hasWon = false;
      hasGameStarted = false;
      ballYDirection = Direction.down;
      ballXDirection = Direction.left;
      _initBricks();
    });
  }

  void startGame() {
    if (hasGameStarted) return;
    hasGameStarted = true;
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (mounted) {
        updateDirection();
        moveBall();
        if (isPlayerDead()) {
          timer.cancel();
          setState(() {
            isGameOver = true;
          });
        }
        checkForBrokenBricks();
      } else {
        timer.cancel();
      }
    });
  }

  void updateDirection() {
    setState(() {
      // Wall collisions
      if (ballX <= -1) {
        ballXDirection = Direction.right;
      } else if (ballX >= 1) {
        ballXDirection = Direction.left;
      }

      if (ballY <= -1) {
        ballYDirection = Direction.down;
      }

      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.up;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == Direction.left) {
        ballX -= ballXIncrements;
      } else if (ballXDirection == Direction.right) {
        ballX += ballXIncrements;
      }

      if (ballYDirection == Direction.down) {
        ballY += ballYIncrements;
      } else if (ballYDirection == Direction.up) {
        ballY -= ballYIncrements;
      }
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1.05) {
      return true;
    }
    return false;
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBricks.length; i++) {
      if (myBricks[i][2] == false) {
        double bX = myBricks[i][0];
        double bY = myBricks[i][1];
        double bWidth = brickWidth;
        double bHeight = brickHeight;

        if (ballX >= bX &&
            ballX <= bX + bWidth &&
            ballY >= bY - bHeight / 2 &&
            ballY <= bY + bHeight / 2) {
          setState(() {
            myBricks[i][2] = true;

            if (ballYDirection == Direction.up) {
              ballYDirection = Direction.down;
            } else {
              ballYDirection = Direction.up;
            }
          });

          checkIfHasWon();
        }
      }
    }
  }

  void checkIfHasWon() {
    bool allBroken = true;
    for (var brick in myBricks) {
      if (brick[2] == false) {
        allBroken = false;
        break;
      }
    }

    if (allBroken) {
      timer?.cancel();
      setState(() {
        hasWon = true;
        isGameOver = true;
      });
    }
  }

  void moveLeft() {
    if (!hasGameStarted || isGameOver) return;
    setState(() {
      if (playerX - 0.1 >= -1) {
        playerX -= 0.1;
      } else {
        playerX = -1;
      }
    });
  }

  void moveRight() {
    if (!hasGameStarted || isGameOver) return;
    setState(() {
      if (playerX + playerWidth + 0.1 <= 1) {
        playerX += 0.1;
      } else {
        playerX = 1 - playerWidth;
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKeyEvent: (event) {
        if (HardwareKeyboard.instance.isLogicalKeyPressed(
          LogicalKeyboardKey.arrowLeft,
        )) {
          moveLeft();
        } else if (HardwareKeyboard.instance.isLogicalKeyPressed(
          LogicalKeyboardKey.arrowRight,
        )) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (isGameOver) {
            resetGame();
          } else if (!hasGameStarted) {
            startGame();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (!hasGameStarted || isGameOver) return;
          setState(() {
            double deltaX =
                (details.delta.dx / MediaQuery.of(context).size.width) * 2;
            playerX += deltaX;

            if (playerX < -1) playerX = -1;
            if (playerX + playerWidth > 1) playerX = 1 - playerWidth;
          });
        },
        child: Scaffold(
          body: Center(
            child: Stack(
              children: [
                ...myBricks.map(
                  (brick) => Brick(
                    brickX: brick[0] as double,
                    brickY: brick[1] as double,
                    brickBroken: brick[2] as bool,
                    color: brick[3] as Color,
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                  ),
                ),

                Coverscreen(hasGameStarted: hasGameStarted),

                if (isGameOver)
                  Container(
                    alignment: const Alignment(0, -0.2),
                    child: Text(
                      hasWon ? "YOU WON!" : "GAME OVER",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: hasWon ? Colors.green : Colors.red,
                      ),
                    ),
                  ),

                // Ball
                Ball(ballX: ballX, ballY: ballY),

                // Player
                Player(playerWidth: playerWidth, playerX: playerX),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
