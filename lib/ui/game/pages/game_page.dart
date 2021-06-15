import 'package:flutter/material.dart';
import 'package:game_design/data/data_sources/sharedpreference_local_datasource.dart';
import 'package:game_design/data/repositories/game_repository.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/utils/save_game.dart';
import 'package:game_design/ui/game/providers/game_provider.dart';
import 'package:game_design/domain/utils/create_new_point.dart';
import 'package:game_design/ui/game/providers/game_provider_events.dart';
import 'package:game_design/ui/game/widgets/board_game_widget.dart';
import 'package:game_design/domain/utils/board_size_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePage extends StatelessWidget {
  static const ROUTE_NAME = "game_page";

  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // getting paused game from arguments send by home screen
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    late final GameEntity? game;
    if (args != null && args is GameEntity) game = args;

    // adding provider to the widget tree
    return ChangeNotifierProvider<IGameProvider>(
      create: (_) => GameProvider(
        iCreateNewPoint: CreateNewPoint(),
        iBoardSizeHelper: BoardSizeHelper.fromDefault(),
        iSaveGame: SaveGame(
          gameRepo: GameRepository(
            iLocalDataSource: SharedPrefLocalDataSource(
              sharedPreferences: SharedPreferences
                  .getInstance(), //todo: gives Future<SharedPreference>
            ),
          ),
        ),
        pausedGame: game,
      ),

      // screen ui
      builder: (context, _) => WillPopScope(
        onWillPop: () => _onBackPress(context), //won't work in IOS
        child: Scaffold(
          appBar: AppBar(
            title: Selector<IGameProvider, int>(
              builder: (_, score, __) => Text("$score"),
              selector: (_, gameProvider) => gameProvider.score,
            ),
          ),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: BoardGameWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPress(BuildContext context) async {
    final userChoice = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Do you want to save the game before going?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 0),
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, -1),
              child: Text("exit"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 1),
              child: Text("save & exit"),
            ),
          ],
        );
      },
    );
    if (userChoice == 0) return false;
    if (userChoice == 1) {
      await Provider.of<IGameProvider>(context, listen: false)
          .notify(SaveGameEvent());
    }
    return true;
  }
}
