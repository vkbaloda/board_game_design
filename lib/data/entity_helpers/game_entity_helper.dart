import 'package:game_design/domain/entities/game_entity.dart';

class GameEntityHelper {
  static const _KEY_SCORE = "score";
  static const _KEY_GAME_ID = "gameId";
  static const _KEY_PLAYER = "player";
  static const _KEY_TREASURE = "treasure";

  static GameEntity fromMap(Map<String, dynamic> gameMap) {
    return GameEntity(
      gameId: gameMap[_KEY_GAME_ID],
      score: gameMap[_KEY_SCORE],
      playerEntity: gameMap[_KEY_PLAYER],
      treasureEntity: gameMap[_KEY_TREASURE],
    );
  }

  static Map<String, dynamic> toMap(GameEntity game){
    return {
      _KEY_GAME_ID: game.gameId,
      _KEY_SCORE: game.score,
      _KEY_PLAYER: game.playerEntity,
      _KEY_TREASURE: game.treasureEntity,
    };
  }
}
