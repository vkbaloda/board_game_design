import 'dart:math' show Point;

import 'package:flutter/material.dart' show immutable;

@immutable
class TreasureEntity extends Point<int> {
  const TreasureEntity({required int row, required int column})
      : super(column, row);

  TreasureEntity.fromPoint(Point<int> point)
      : this(row: point.y, column: point.x);
}
