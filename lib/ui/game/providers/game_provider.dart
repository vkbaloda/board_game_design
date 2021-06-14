import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:game_design/domain/entities/PlayerEntity.dart';
import 'package:game_design/domain/entities/TreasureEntity.dart';
import 'package:game_design/domain/resources/Constants.dart' show maxScore;
import 'package:game_design/ui/game/providers/game_provider_events.dart';
import 'package:game_design/ui/game/utils/create_new_point.dart';
import 'package:game_design/ui/utils/board_size_helper.dart';
import 'package:game_design/ui/utils/direction_enum.dart';

abstract class IGameProvider extends ChangeNotifier {
  //state getters
  int get score;
  PlayerEntity get playerEntity;
  TreasureEntity get treasureEntity;
  IBoardSizeHelper get iBoardSizeHelper;

  //notify event method
  void notify(GameProviderEvent event);
}

enum _GameState { loading, play }

class GameProvider extends IGameProvider {
  //state objects
  late int score;
  late PlayerEntity playerEntity;
  late TreasureEntity treasureEntity;
  late _GameState _gameState;

  //dependencies
  final ICreateNewPoint iCreateNewPoint;
  final IBoardSizeHelper iBoardSizeHelper;

  GameProvider({required this.iCreateNewPoint, required this.iBoardSizeHelper})
      : score = 0,
        _gameState = _GameState.loading{
    _reset();
  }

  @override
  void notify(GameProviderEvent event) {
    switch (event.runtimeType) {
      case GameInteractionEvent:
        if (_gameState == _GameState.loading) return;
        _onUserInteraction((event as GameInteractionEvent).dir);
        break;
      default:
        throw UnsupportedError("some event is not addressed in the switch cases");
    }
  }

  void _onUserInteraction(Direction dir) {
    switch (dir) {  //may add methods in playerEntity to do job easier
      case Direction.left:
        if(playerEntity is not at leftEdget) move playerEntity left;
        break;
      case Direction.up:
        if(playerEntity is not at upperEdget) move playerEntity up;
        break;
      case Direction.right:
        if(playerEntity is not at rightEdget) move playerEntity right;
        break;
      case Direction.down:
        if(playerEntity is not at bottomEdget) move playerEntity down;
        break;
    }
    notifyListeners();

    // check if got a treasure
    if(treasureEntity == playerEntity){
      treasureEntity = TreasureEntity.fromPoint(_getNewPoint());
      score++;
      notifyListeners();

      // checks if won the game
      if(score == maxScore){
        // may wait for a sec
        _reset();
      }
    }
  }

  void _reset(){	//class GameProvider
    _gameState = _GameState.loading;
    score = 0;
    treasureEntity = TreasureEntity.fromPoint(_getNewPoint());
    do{
      playerEntity = PlayerEntity.fromPoint(_getNewPoint());
    } while (playerEntity == treasureEntity);
    _gameState = _GameState.play;
    notifyListeners();
  }

  Point<int> _getNewPoint(){
    return iCreateNewPoint(
      columns: iBoardSizeHelper.columns,
      rows:iBoardSizeHelper.rows,
    );
  }
}
