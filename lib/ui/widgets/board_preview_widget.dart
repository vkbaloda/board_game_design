import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:game_design/ui/widgets/board_positioned.dart';
import 'package:game_design/ui/widgets/board_widget.dart';
import 'package:game_design/ui/widgets/player_widget.dart';
import 'package:game_design/ui/widgets/treasure_widget.dart';

class BoardPreviewWidget extends StatelessWidget {
  final int rows;
  final int columns;
  final double cellSize;
  final Point<int> treasureLoc;
  final Point<int> playerLoc;

  const BoardPreviewWidget({
    required this.rows,
    required this.columns,
    required this.cellSize,
    required this.playerLoc,
    required this.treasureLoc,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BoardWidget(
          rows: rows,
          columns: columns,
          cellSize: cellSize,
        ),
        BoardPositioned(
          row: playerLoc.y,
          column: playerLoc.x,
          cellSize: cellSize,
          child: PlayerWidget.factory(),
        ),
        BoardPositioned(
          row: treasureLoc.y,
          column: treasureLoc.x,
          cellSize: cellSize,
          child: TreasureWidget.factory(),
        ),
      ],
    );
  }
}
