import 'package:flutter/material.dart';
import 'package:game_design/domain/utils/direction_enum.dart';
import 'package:game_design/ui/widgets/input_detector.dart';

class SwipeInputDetector extends InputDetector {
  static const double _MIN_SWIPE_VELOCITY = 0.15; //todo: non-checked value
  final Widget child;
  final InteractionCallback interactionCallback;

  SwipeInputDetector({
    required this.interactionCallback,
    required this.child,
    Key? key,
  }) : super(interactionCallBack: interactionCallback, child: child, key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: _onPanEnd,
      child: child,
    );
  }

  void _onPanEnd(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.distance > _MIN_SWIPE_VELOCITY) {
      //swipe is valid
      interactionCallback(_getDirection(details.velocity));
    }
  }

  Direction _getDirection(Velocity velocity) {
    //gets direction from signs of x and y values
    return Direction.left;  //todo
  }
}
