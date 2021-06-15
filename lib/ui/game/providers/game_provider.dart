import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/entities/player_entity.dart';
import 'package:game_design/domain/entities/treasure_entity.dart';
import 'package:game_design/domain/resources/constants.dart' show maxScore;
import 'package:game_design/domain/utils/save_game.dart';
import 'package:game_design/ui/game/providers/game_provider_events.dart';
import 'package:game_design/domain/utils/create_new_point.dart';
import 'package:game_design/domain/utils/board_size_helper.dart';
import 'package:game_design/domain/utils/direction_enum.dart';

enum GameState { loading, play }

abstract class IGameProvider extends ChangeNotifier {
  //state getters
  int get score;
  PlayerEntity get playerEntity;
  TreasureEntity get treasureEntity;
  IBoardSizeHelper get iBoardSizeHelper;
  GameState get gameState;

  //notify event method
  Future<void> notify(GameProviderEvent event);
}

class GameProvider extends IGameProvider {
  //state objects
  late int score;
  late PlayerEntity playerEntity;
  late TreasureEntity treasureEntity;
  late GameState gameState;

  late final int? _gameId;

  //dependencies
  final ICreateNewPoint iCreateNewPoint;
  final IBoardSizeHelper iBoardSizeHelper;
  final ISaveGame iSaveGame;

  GameProvider({
    required this.iCreateNewPoint,
    required this.iBoardSizeHelper,
    GameEntity? pausedGame,
    required this.iSaveGame,
  })
      : score = 0,
        gameState = GameState.loading{
    if(pausedGame == null) {
      _reset();
    }else{
      playerEntity = pausedGame.playerEntity;
      treasureEntity = pausedGame.treasureEntity;
      score = pausedGame.score;
      _gameId = pausedGame.gameId;
      gameState = GameState.play;
      notifyListeners();
    }
  }

  @override
  Future<void> notify(GameProviderEvent event) async{
    switch (event.runtimeType) {
      case GameInteractionEvent:
        if (gameState == GameState.loading) return;
        _onUserInteraction((event as GameInteractionEvent).dir);
        break;
      case SaveGameEvent:
        await iSaveGame.saveGame(GameEntity(
            score: score,
            playerEntity: playerEntity,
            treasureEntity: treasureEntity,
            gameId: _gameId,
        ));
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
    gameState = GameState.loading;
    score = 0;
    treasureEntity = TreasureEntity.fromPoint(_getNewPoint());
    do{
      playerEntity = PlayerEntity.fromPoint(_getNewPoint());
    } while (playerEntity == treasureEntity);
    gameState = GameState.play;
    notifyListeners();
  }

  Point<int> _getNewPoint(){
    return iCreateNewPoint(
      columns: iBoardSizeHelper.columns,
      rows:iBoardSizeHelper.rows,
    );
  }
}
