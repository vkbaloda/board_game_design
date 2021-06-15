import 'dart:convert' show json;

import 'package:game_design/data/data_sources/data_source_interfaces.dart';
import 'package:game_design/data/entity_helpers/game_entity_helper.dart';
import 'package:game_design/data/errors_exceptions/exceptions.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefLocalDataSource implements ILocalDataSource {
  static const _GAMES_KEY = "GAMES_KEY";
  final SharedPreferences sharedPreferences;
  static SharedPrefLocalDataSource? _instance;

  SharedPrefLocalDataSource._({required this.sharedPreferences});

  factory SharedPrefLocalDataSource({required sharedPreferences}) {
    if (_instance == null) {
      _instance =
          SharedPrefLocalDataSource._(sharedPreferences: sharedPreferences);
    }
    return _instance!;
  }

  Future<int> saveGame(GameEntity game) async {
    final games = await getAllGames();

    final maxId =
        games.fold<int>(0, (prev, g) => prev > g.gameId! ? prev : g.gameId!);
    //may like to reset ids if id value gets bigger then some value
    final gameWithId = game.copyWith(gameId: maxId + 1);
    games.add(gameWithId);

    final encodedGames =
        games.map((g) => json.encode(GameEntityHelper.toMap(g))).toList();
    await sharedPreferences.setStringList(_GAMES_KEY, encodedGames); //async

    return gameWithId.gameId!;
  }

  //returns empty list if no game saved
  Future<List<GameEntity>> getAllGames() async {
    final encodedGames = sharedPreferences.getStringList(_GAMES_KEY);
    if (encodedGames == null) return [];
    final decodedGames = encodedGames
        .map((g) => GameEntityHelper.fromMap(json.decode(g)))
        .toList();
    return decodedGames;
  }

  Future<GameEntity> getGameById(int gameId) async {
    final games = await getAllGames();
    try {
      return games.firstWhere(
          (g) => g.gameId == gameId); //throws IterableElementError.noElement()
    } on StateError catch (e) {
      throw GameNotFoundException();
    }
  }
}
