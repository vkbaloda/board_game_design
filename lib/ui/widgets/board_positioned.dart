import 'package:flutter/material.dart';

class BoardPositioned extends StatelessWidget {
  final int row;
  final int column;
  final double cellSize;
  final Widget child;

  const BoardPositioned({
    Key? key,
    required this.row,
    required this.column,
    required this.cellSize,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: row * cellSize,
      left: column * cellSize,
      child: child,
    );
  }
}
