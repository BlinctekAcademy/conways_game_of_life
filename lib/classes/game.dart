import 'package:game_of_life/classes/board.dart';

class Game {
  List<Board> generations = [];
  int currentGeneration = 0;
  int boardSize = 35;
  bool isPaused = true;
  int delayInMilliseconds = 300;
  final Function updateScreen;

  Game(this.updateScreen) {
    generations.add(Board(rowCount: boardSize, columnCount: boardSize));
  }

  get board {
    return generations[currentGeneration];
  }

  void play() async {
    isPaused = false;
    while (!isPaused) {
      await Future.delayed(Duration(milliseconds: delayInMilliseconds), (() {
        updateScreen(() {
          for (int i = 0; i < 1; i++) {
            createGenerations();
          }
        });
      }));
    }
  }

  void pause() {
    isPaused = true;
  }

  void accelerate() {
    if (delayInMilliseconds > 100) {
      delayInMilliseconds -= 100;
    }
  }

  void decelerate() {
    if (delayInMilliseconds < 2000) {
      delayInMilliseconds += 100;
    }
  }

  void restart() {
    isPaused = true;
    updateScreen(() {
      board.representation = board.render();
    });
  }

  int countNeighbors(int columnIndex, int rowIndex) {
    List<List<int>> neighborsCoordinates = [
      [columnIndex + 1, rowIndex + 1],
      [columnIndex + 1, rowIndex],
      [columnIndex, rowIndex + 1],
      [columnIndex - 1, rowIndex - 1],
      [columnIndex - 1, rowIndex],
      [columnIndex, rowIndex - 1],
      [columnIndex + 1, rowIndex - 1],
      [columnIndex - 1, rowIndex + 1]
    ];

    int count = 0;

    for (int i = 0; i < neighborsCoordinates.length; i++) {
      try {
        if (board.representation[neighborsCoordinates[i][0]]
            [neighborsCoordinates[i][1]]) {
          count++;
        }
      } catch (e) {}
    }
    return count;
  }

  void createGenerations() {
    Board newBoard = Board(rowCount: boardSize, columnCount: boardSize);
    for (int i = 0; i < board.columnCount; i++) {
      for (int j = 0; j < board.rowCount; j++) {
        int neighborsCount = 0;
        neighborsCount = countNeighbors(i, j);
        if (board.representation[i][j]) {
          newBoard.representation[i][j] =
              !(neighborsCount < 2 || neighborsCount > 3);
        } else if (neighborsCount == 3) {
          newBoard.representation[i][j] = true;
        } else {
          newBoard.representation[i][j] = false;
        }
      }
    }
    currentGeneration++;
    generations.add(newBoard);
  }
}
