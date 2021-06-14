import 'package:flutter/material.dart';

enum BoardCellType { simple }

abstract class BoardCellWidget extends Widget {
  factory BoardCellWidget.factory({BoardCellType type = BoardCellType.simple, Key? key}) {
    return SimpleCellWidget(key: key);
  }
}

class SimpleCellWidget extends StatelessWidget implements BoardCellWidget {
  const SimpleCellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 0.5)),
    );
  }
}
