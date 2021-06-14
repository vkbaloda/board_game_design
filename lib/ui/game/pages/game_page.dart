import 'package:flutter/material.dart';
import 'package:game_design/ui/game/providers/game_provider.dart';
import 'package:game_design/ui/game/utils/create_new_point.dart';
import 'package:game_design/ui/game/widgets/board_game_widget.dart';
import 'package:game_design/ui/utils/board_size_helper.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<IGameProvider>(
      create: (_) => GameProvider(
        iCreateNewPoint: CreateNewPoint(),
        iBoardSizeHelper: BoardSizeHelper.fromDefault(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Builder(builder: (appBarContext) {
            return Selector<IGameProvider, int>(
              builder: (_, score, __) => Text("$score"),
              selector: (_, gameProvider) => gameProvider.score,
            );
          }),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BoardGameWidget(),
          ),
        ),
      ),
    );
  }
}
