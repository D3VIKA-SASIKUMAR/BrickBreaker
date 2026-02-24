import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickWidth;
  final double brickHeight;
  final bool brickBroken;
  final Color color;

  const Brick({
    super.key,
    required this.brickX,
    required this.brickY,
    required this.brickWidth,
    required this.brickHeight,
    required this.brickBroken,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return brickBroken
        ? const SizedBox.shrink()
        : Container(
            alignment: Alignment(
              (2 * brickX + brickWidth) / (2 - brickWidth),
              brickY,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: color,
              ),
            ),
          );
  }
}
