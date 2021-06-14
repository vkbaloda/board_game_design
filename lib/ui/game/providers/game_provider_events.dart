import 'package:game_design/ui/utils/direction_enum.dart';

abstract class GameProviderEvent{
  const GameProviderEvent();
}

class GameInteractionEvent extends GameProviderEvent{
  final Direction dir;
  const GameInteractionEvent(this.dir);
}