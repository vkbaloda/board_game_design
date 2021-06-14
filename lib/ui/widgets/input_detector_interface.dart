import 'package:flutter/material.dart';
import 'package:game_design/ui/utils/direction_enum.dart';
import 'package:game_design/ui/widgets/swipe_input_detector.dart';

typedef InteractionCallback = void Function(Direction dir);
enum DetectorType { swipe } //, dPad, keyboard, mouse

abstract class InputDetectorInterface extends StatelessWidget {
  InputDetectorInterface({
    required InteractionCallback interactionCallBack,
    required Widget child,
    Key? key,
  }) : super(key: key);

  factory InputDetectorInterface.byType({
    required DetectorType type,
    required InteractionCallback interactionCallback,
    required Widget child,
    Key? key,
  }) {
    switch (type) {
      case DetectorType.swipe:
      default:
        return SwipeInputDetector(
          interactionCallback: interactionCallback,
          child: child,
          key: key,
        );
    }
  }
}
