import 'dart:math';

class Board {
  int rowCount;
  int columnCount;
  late List<List<bool>> representation;

  Board({
    required this.rowCount,
    required this.columnCount,
  }) {
    representation = render();
  }

  List<List<bool>> render() {
    List<List<bool>> board = [];

    for (int i = 0; i < columnCount; i++) {
      board.add([]);
      for (int j = 0; j < rowCount; j++) {
        board[i].add(false);
      }
    }
    return board;
  }

  List<List<bool>> randomRender() {
    List<List<bool>> board = [];

    for (int i = 0; i < columnCount; i++) {
      board.add([]);
      for (int j = 0; j < rowCount; j++) {
        board[i].add(Random().nextBool());
      }
    }
    return board;
  }

  void swapIndexValue(int x, int y) {
    representation[x][y] = !representation[x][y];
  }
}
