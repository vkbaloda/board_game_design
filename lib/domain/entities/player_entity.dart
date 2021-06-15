import 'dart:math' show Point;

import 'package:flutter/material.dart' show immutable;

@immutable
class PlayerEntity extends Point<int> {
  const PlayerEntity({required int row, required int column})
      : super(column, row);

  PlayerEntity.fromPoint(Point<int> point)
      : this(column: point.x, row: point.y);
}
