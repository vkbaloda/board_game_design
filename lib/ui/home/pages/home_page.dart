import 'package:flutter/material.dart';
import 'package:game_design/data/data_sources/sharedpreference_local_datasource.dart';
import 'package:game_design/data/repositories/game_repository.dart';
import 'package:game_design/domain/entities/game_entity.dart';
import 'package:game_design/domain/utils/board_size_helper.dart';
import 'package:game_design/domain/utils/get_previous_games.dart';
import 'package:game_design/ui/game/pages/game_page.dart';
import 'package:game_design/ui/home/providers/home_provider.dart';
import 'package:game_design/ui/home/providers/home_provider_events.dart';
import 'package:game_design/ui/widgets/board_preview_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // adding the provide in the widget tree
    return ChangeNotifierProvider<IHomeProvider>(
      create: (context) => HomeProvider(
        iGetPreviousGames: GetPreviousGames(
          gameRepo: GameRepository(
            iLocalDataSource: SharedPrefLocalDataSource(
              sharedPreferences: SharedPreferences
                  .getInstance(), //todo: gives Future<SharedPreference>
            ),
          ),
        ),
      ),
      builder: (context, _) {
        //the page view
        return Scaffold(
          body: ListView(
            children: [
              // play button to start new game
              TextButton(
                onPressed: () => _onPlayClick(context),
                child: const Text("Play"),
              ),
              const SizedBox(height: 20),

              // gamePreview list using gameEntities from provider
              Selector<IHomeProvider, List<GameEntity>>(
                selector: (context, provider) => List.from(provider.gamesList),
                builder: (context, games, _) {
                  //using default board size
                  final IBoardSizeHelper sizeHelper =
                      BoardSizeHelper.fromDefault();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), //to avoid internal scrolling
                    itemCount: games.length,
                    itemBuilder: (_, index) {
                      final game = games[index];

                      return GestureDetector(
                        onTap: () => _onPreviewClick(context, game),
                        child: SizedBox(
                          height: 200,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: BoardPreviewWidget(
                              columns: sizeHelper.columns,
                              rows: sizeHelper.rows,
                              cellSize: IBoardSizeHelper.getCellSize(),
                              playerLoc: game.playerEntity,
                              treasureLoc: game.treasureEntity,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onPlayClick(BuildContext context) {
    Navigator.pushNamed(context, GamePage.ROUTE_NAME)
        .then((value) => _refreshList(context));
  }

  void _onPreviewClick(BuildContext context, GameEntity game) {
    Navigator.pushNamed(context, GamePage.ROUTE_NAME, arguments: game)
        .then((value) => _refreshList(context));
  }

  void _refreshList(BuildContext context) {
    //refreshes the preview list after coming from GamePage
    Provider.of<IHomeProvider>(context, listen: false)
        .notify(GamePreviewListRefresh());
  }
}
