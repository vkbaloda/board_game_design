import 'package:flutter/material.dart';
import 'package:game_design/ui/widgets/board_cell_widget.dart';

class BoardWidget extends StatelessWidget {
  final int rows;
  final int columns;
  final double cellSize;

  const BoardWidget({
    Key? key,
    required this.rows,
    required this.columns,
    required this.cellSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      child: Table(
        defaultColumnWidth: FixedColumnWidth(cellSize),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: List.generate(
          rows,
          (y) => TableRow(
            children: List.generate(
              columns,
              (x) => SizedBox(
                height: cellSize,
                width: cellSize,
                child: BoardCellWidget.factory(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
