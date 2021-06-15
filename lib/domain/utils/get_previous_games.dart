import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/repository_interface/i_game_repository.dart';

abstract class IGetPreviousGames{
  Future<List<GameEntity>> getAllGames();
}

class GetPreviousGames implements IGetPreviousGames{
  final IGameRepository gameRepo;

  GetPreviousGames({required this.gameRepo});

  Future<List<GameEntity>> getAllGames(){
    return gameRepo.getAllGames();
  }
}