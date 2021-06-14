import 'package:game_design/domain/resources/Constants.dart' hide maxScore;

abstract class IBoardSizeHelper {
  int get columns;
  int get rows;

  static double getCellSize({
    int? columns,
    int? rows,
    double? width,
    double? height,
  }) {
    //gets size based on available screen space
    return defaultCellSize; //todo: dummy value
  }
}

class BoardSizeHelper implements IBoardSizeHelper {
  final int columns;
  final int rows;

  BoardSizeHelper._({required this.rows, required this.columns});

  factory BoardSizeHelper.fromDefault() {
    return BoardSizeHelper._(rows: defaultRowsNo, columns: defaultColumnsNo);
  }
}
