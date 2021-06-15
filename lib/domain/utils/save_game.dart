import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/repository_interface/i_game_repository.dart';

abstract class ISaveGame{
  Future<int> saveGame(GameEntity game);
}

class SaveGame implements ISaveGame{
  final IGameRepository gameRepo;

  SaveGame({required this.gameRepo});

  Future<int> saveGame(GameEntity game){
    return gameRepo.saveGame(game);
  }
}