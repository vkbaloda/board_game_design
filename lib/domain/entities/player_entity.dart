import 'dart:math' show Point;

import 'package:flutter/material.dart' show immutable;
import 'package:game_design/domain/utils/direction_enum.dart';

@immutable
class PlayerEntity extends Point<int> {
  const PlayerEntity({required int row, required int column})
      : super(column, row);

  PlayerEntity.fromPoint(Point<int> point)
      : this(column: point.x, row: point.y);

  PlayerEntity movedInDirection(Direction dir){
    switch(dir){
      case Direction.left:
        return PlayerEntity(row: y, column: x-1);
      //... similarly for other cases
      default:
        return this;
    }
  }

  bool isAtEdge(Direction dir, int rows, int columns){
    switch(dir){
      case Direction.left:
        return x == 0;
      case Direction.right:
        return x == rows-1;
      //... similarly for other cases
      default:
        return false;
    }
  }
}
