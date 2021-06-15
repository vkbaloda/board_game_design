import 'package:game_design/data/data_sources/data_source_interfaces.dart';
import 'package:game_design/data/errors_exceptions/exceptions.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/repository_interface/i_game_repository.dart';

// keeps data in local storage
class GameRepository implements IGameRepository {
  static GameRepository? _instance;
  ILocalDataSource iLocalDataSource;

  GameRepository._({required this.iLocalDataSource});

  factory GameRepository({required iLocalDataSource}) {
    if (_instance == null) {
      _instance = GameRepository._(iLocalDataSource: iLocalDataSource);
    }
    return _instance!;
  }

  @override
  Future<List<GameEntity>> getAllGames() {
    return iLocalDataSource.getAllGames();
  }

  @override
  Future<GameEntity?> getGameById(int gameId) async {
    try {
      return iLocalDataSource.getGameById(gameId);
    } on GameNotFoundException catch (e) {
      return null;
    }
  }

  @override
  Future<int> saveGame(GameEntity game) {
    return iLocalDataSource.saveGame(game);
  }
}
