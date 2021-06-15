import 'package:flutter/material.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/utils/get_previous_games.dart';
import 'package:game_design/ui/home/providers/home_provider_events.dart';

abstract class IHomeProvider extends ChangeNotifier {
  List<GameEntity> get gamesList;

  Future<void> notify(HomeProviderEvent event);
}

class HomeProvider extends IHomeProvider {
  List<GameEntity> gamesList;
  final IGetPreviousGames iGetPreviousGames;

  HomeProvider({required this.iGetPreviousGames}) : gamesList = []{
    _refreshGamesList();
  }

  Future<void> notify(HomeProviderEvent event) async{
    switch (event.runtimeType) {
      case GamePreviewListRefresh:
        _refreshGamesList();
        break;
      default:
        throw UnimplementedError("some event is not addressed in the cases");
    }
  }

  Future<void> _refreshGamesList() async{
    gamesList = await iGetPreviousGames.getAllGames();
    notifyListeners();
  }
}
