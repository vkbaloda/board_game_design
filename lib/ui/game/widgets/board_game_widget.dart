import 'package:flutter/material.dart';
import 'package:game_design/ui/game/providers/game_provider.dart';
import 'package:game_design/ui/game/providers/game_provider_events.dart';
import 'package:game_design/ui/utils/board_size_helper.dart';
import 'package:game_design/ui/utils/direction_enum.dart';
import 'package:game_design/ui/widgets/animated_board_translation.dart';
import 'package:game_design/ui/widgets/board_positioned.dart';
import 'package:game_design/ui/widgets/board_widget.dart';
import 'package:game_design/ui/widgets/input_detector_interface.dart';
import 'package:game_design/ui/widgets/player_widget.dart';
import 'package:game_design/ui/widgets/treasure_widget.dart';
import 'package:provider/provider.dart';

class BoardGameWidget extends StatelessWidget {
  const BoardGameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeHelper =
        Provider.of<IGameProvider>(context, listen: false).iBoardSizeHelper;
    final cellSize = IBoardSizeHelper.getCellSize();
    return Consumer<IGameProvider>(
      builder: (BuildContext cContext, gameProvider, Widget? board) {
        return InputDetectorInterface.byType(
          type: DetectorType.swipe,
          interactionCallback: (Direction dir) {
            gameProvider.notify(GameInteractionEvent(dir));
          },
          child: Stack(
            children: [
              board!,
              BoardPositioned(
                key: ValueKey(gameProvider.treasureEntity),
                row: gameProvider.treasureEntity.y,
                column: gameProvider.treasureEntity.x,
                cellSize: cellSize,
                child: TreasureWidget.factory(),
              ),
              AnimatedBoardTranslation.factory(
                row: gameProvider.playerEntity.y,
                column: gameProvider.playerEntity.x,
                cellSize: cellSize,
                child: PlayerWidget.factory(),
              ),
            ],
          ),
        );
      },
      child: BoardWidget(
        rows: sizeHelper.rows,
        columns: sizeHelper.columns,
        cellSize: cellSize,
      ),
    );
  }
}
