class GameOfLife {
  late final int side;
  late List<List<int>> board;

  GameOfLife({required this.side}) {
    board = createMap();
  }

  List<List<int>> createMap() {
    List<List<int>> tempMap = [];
    List<int> tempLine = [];

    for (int i = 0; i < side; i++) {
      tempLine = [];
      for (int j = 0; j < side; j++) {
        tempLine.add(0);
      }
      tempMap.add(tempLine);
    }
    return tempMap;
  }

  void createCell(List<int> coordinate) {
    board[coordinate[0]][coordinate[1]] = 1;
  }

  void killCell(List<int> coordinate) {
    board[coordinate[0]][coordinate[1]] = 0;
  }

  int neighborCounter(int x, int y) {
    int neighCounter = 0;
    final List<List<int>> testCoordinates = [
      [y - 1, x - 1],
      [y - 1, x],
      [y - 1, x + 1],
      [y, x - 1],
      [y, x + 1],
      [y + 1, x - 1],
      [y + 1, x],
      [y + 1, x + 1]
    ];
    List<List<int>> validCoordinates = [];
    validCoordinates = [];
    for (int z = 0; z < testCoordinates.length; z++) {
      if (testCoordinates[z][0] > -1 &&
          testCoordinates[z][0] < board.length &&
          testCoordinates[z][1] > -1 &&
          testCoordinates[z][1] < board[0].length) {
        validCoordinates.add(testCoordinates[z]);
      } else {
        if (testCoordinates[z][0] == -1) {
          testCoordinates[z][0] = board.length - 1;
        }
        if (testCoordinates[z][1] == -1) {
          testCoordinates[z][1] = board.length - 1;
        }
        if (testCoordinates[z][0] == board.length) {
          testCoordinates[z][0] = 0;
        }
        if (testCoordinates[z][1] == board.length) {
          testCoordinates[z][1] = 0;
        }
        validCoordinates.add(testCoordinates[z]);
      }
    }

    for (int w = 0; w < validCoordinates.length; w++) {
      if (board[validCoordinates[w][0]][validCoordinates[w][1]] == 1) {
        neighCounter += 1;
      }
    }
    return neighCounter;
  }

  List<List<int>> checkBirth() {
    List<List<int>> nextBirths = [];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[0].length; j++) {
        if (neighborCounter(j, i) == 3) {
          nextBirths.add([i, j]);
        }
      }
    }
    return nextBirths;
  }

  List<List<int>> checkDeath() {
    List<List<int>> nextDeaths = [];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[0].length; j++) {
        if (neighborCounter(j, i) < 2 || neighborCounter(j, i) > 3) {
          nextDeaths.add([i, j]);
        }
      }
    }
    return nextDeaths;
  }

  attMap() {
    List<List<int>> deaths = checkDeath();
    List<List<int>> births = checkBirth();

    for (int i = 0; i < deaths.length; i++) {
      killCell(deaths[i]);
    }
    for (int i = 0; i < births.length; i++) {
      createCell(births[i]);
    }
  }

  void restartMap() {
    board = createMap();
  }
}
