import 'dart:math' show Point;

abstract class ICreateNewPoint {
  Point<int> call({
    required int columns,
    required int rows,
    List<Point<int>> ignoreList = const [],
  });
}

class CreateNewPoint extends ICreateNewPoint {
  Point<int> call({
    required int columns,
    required int rows,
    List<Point<int>> ignoreList = const [],
  }) {
    //use Random to get values up to columns and rows that don't match from ignoreList
    return Point(0, 0); //todo: dummy value
  }
}
