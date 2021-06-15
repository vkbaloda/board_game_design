import 'package:flutter/material.dart';

enum AnimatedTranslationType { positioned }

abstract class AnimatedBoardTranslation extends Widget {
  factory AnimatedBoardTranslation.factory({
    AnimatedTranslationType type = AnimatedTranslationType.positioned,
    Key? key,
    required int row,
    required int column,
    required double cellSize,
    required Widget child,
  }) {
    return AnimatedBoardPositioned(
      row: row,
      column: column,
      cellSize: cellSize,
      child: child,
      key: key,
    );
  }
}

class AnimatedBoardPositioned extends AnimatedPositioned
    implements AnimatedBoardTranslation {
  static const _ANIMATION_DURATION = Duration(milliseconds: 500);

  const AnimatedBoardPositioned({
    required int row,
    required int column,
    required double cellSize,
    required Widget child,
    Key? key,
  }) : super(
          top: row * cellSize,
          left: column * cellSize,
          child: child,
          duration: _ANIMATION_DURATION,
          key: key,
        );
}
