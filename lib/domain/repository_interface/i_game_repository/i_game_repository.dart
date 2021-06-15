import 'package:game_design/domain/entities/game_entity.dart';

// we may like to do something for exceptions; though with sharedPreference there's no exception
abstract class IGameRepository {
  Future<int> saveGame(GameEntity game);
  Future<List<GameEntity>> getAllGames();
  Future<GameEntity?> getGameById(int gameId); //return null if no game present
}
