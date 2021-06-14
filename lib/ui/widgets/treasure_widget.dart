import 'package:flutter/material.dart';

enum TreasureType { simple }

abstract class TreasureWidget extends Widget {
  factory TreasureWidget.factory(
      {TreasureType type = TreasureType.simple, Key? key}) {
    return SimpleTreasureWidget(key: key);
  }
}

class SimpleTreasureWidget extends StatelessWidget implements TreasureWidget {
  const SimpleTreasureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.work);
  }
}
