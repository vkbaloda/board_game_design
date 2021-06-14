import 'package:flutter/material.dart';

enum PlayerType { simple }

abstract class PlayerWidget extends Widget {
  factory PlayerWidget.factory({PlayerType type = PlayerType.simple, Key? key}) {
    return SimplePlayerWidget(key: key);
  }
}

class SimplePlayerWidget extends StatelessWidget implements PlayerWidget {
  const SimplePlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.accessibility);
  }
}
