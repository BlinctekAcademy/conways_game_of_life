import 'dart:async';

import 'package:flutter/foundation.dart';

class GoLTruths with ChangeNotifier {
  List<List<bool>> _cells = [];
  List<List<bool>> _nextIterationCells = [];
  bool _expansionSymmetricRequired = false;
  String? _gameMessage;
  bool _ready = false;
  bool _running = false;
  Timer? updateTimer;

  static const int _width = 26;
  static const int _height = 52;

  int get crossAxis => _cells[0].length;
  List<List<bool>> get truths => _cells;
  int get totalAlive => _tallyTruths();
  String? get gameMessage => _gameMessage;
  bool get isReady => _ready;
  bool get isRunning => _running;

  set toggleCell(CellLocation loc) => _toggleCell(loc);

  _toggleCell(CellLocation loc) {
    _cells[loc.row!][loc.col!] = !_cells[loc.row!][loc.col!];

    notifyListeners();
  }

  void initGame({int width = _width, int height = _height}) {
    for (int j = 0; j < height; j++) {
      _cells.add([]);
    }
    for (int i = 0; i < width; i++) {
      for (List<bool> row in _cells) {
        row.add(false);
      }
    }

    _nextIterationCells = List.from(_cells);
    _gameMessage = "Conway's Game of life!";
    if (_running) _running = false;
    _ready = true;
    notifyListeners();
  }

  resetGame() {
    _cells.clear();
    if (updateTimer != null) updateTimer!.cancel();
    initGame();
  }

  driveUpdate() {
    _gameMessage = "Let's see what happens...";
    _running = true;
    updateTimer =
        Timer.periodic(Duration(milliseconds: 25), (timer) => update());
  }

  void update() {
    if (_expansionSymmetricRequired) {
      _expansionSymmetricRequired = false;
    }
    _updateRows();
    notifyListeners();
  }

  void _updateRows() {
    _nextIterationCells =
        _cells.map((e) => e.map((cell) => false).toList()).toList();
    for (int i = 1; i < _cells.length - 1; i++) {
      for (int j = 1; j < _cells[0].length - 1; j++) {
        _updateCell(i, j);
      }
    }

    _cells = _nextIterationCells.map((e) => e).toList();
  }

  void _updateCell(int i, int j) {
    int aliveNeighbours = 0;
    bool currentCell = _cells[i][j];
    List<bool> neighbours = [
      _cells[i - 1][j],
      _cells[i - 1][j - 1],
      _cells[i - 1][j + 1],
      _cells[i][j - 1],
      _cells[i][j + 1],
      _cells[i + 1][j],
      _cells[i + 1][j - 1],
      _cells[i + 1][j + 1],
    ];
    for (bool neighbour in neighbours) if (neighbour) aliveNeighbours++;
    if (!currentCell && aliveNeighbours == 3) {
      _nextIterationCells[i][j] = true;
    } else if (currentCell && (aliveNeighbours == 2 || aliveNeighbours == 3)) {
      _nextIterationCells[i][j] = true;
    } else {
      _nextIterationCells[i][j] = false;
    }
    const int growthTrigger = 5;
    if (i <= growthTrigger ||
        j <= growthTrigger ||
        i >= _cells.length - growthTrigger ||
        j >= _cells[1].length - growthTrigger) if (_nextIterationCells[i][j])
      _expansionSymmetricRequired = true;
  }

  _tallyTruths() {
    int total = 0;
    for (List<bool> row in _cells) {
      for (bool cell in row) {
        if (cell) total++;
      }
    }
    return total;
  }
}

class Cell {
  final int? id;
  bool? status;
  Cell({this.id, this.status});
}

class CellLocation {
  final int? row;
  final int? col;
  const CellLocation({this.row, this.col});
}
