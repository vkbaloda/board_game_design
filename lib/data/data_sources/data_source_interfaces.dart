import 'package:game_design/domain/entities/game_entity.dart';

abstract class ILocalDataSource {
  Future<int> saveGame(GameEntity game);
  Future<List<GameEntity>> getAllGames();
  Future<GameEntity> getGameById(int gameId); //throws GameNotFoundException
}
