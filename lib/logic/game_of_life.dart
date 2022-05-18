import 'dart:async';
import 'package:antoniogameoflife/logic/cell.dart';
import 'package:flame/components.dart';

class GameOfLife extends PositionComponent {
  final int gameWidth;
  final int gameHeight;
  final double cellSize;
  late double cellWidthAmount;
  late double cellHeightAmount;
  late Sprite cellSprite;
  List<List<Cell>> cells = [];

  GameOfLife({
    required this.gameWidth,
    required this.gameHeight,
    required this.cellSize,
  }) {
    cellWidthAmount = (gameWidth / cellSize).floorToDouble();
    cellHeightAmount = (gameHeight / cellSize).floorToDouble();
  }

  @override
  Future<void>? onLoad() async {
    createCells();
    renderBoard();
  }

  void createCells() {
    List<List<Cell>> newCellList = _generateBoard();

    // Defining neighbors
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        _findNeighbors(newCellList, y, x);
      }
    }
    cells = newCellList;
  }

  List<List<Cell>> _generateBoard() {
    List<List<Cell>> cellList = [];
    // Creating cell board
    for (int y = 0; y < cellHeightAmount; y++) {
      cellList.add([]);

      for (int x = 0; x < cellWidthAmount; x++) {
        Cell newCell = Cell(
          column: y,
          line: x,
          value: 0,
        );
        cellList[y].add(newCell);
      }
    }

    return cellList;
  }

  void _findNeighbors(List<List<Cell>> list, int y, int x) {
    List<Cell> neighbors = [];

    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        if (dx == 0 && dy == 0) {
        } else {
          int vx = x + dx;
          int vy = y + dy;
          if (vy >= 0 &&
              vy < cellHeightAmount &&
              vx >= 0 &&
              vx < cellWidthAmount) {
            neighbors.add(list[vy][vx]);
          }
        }
      }
    }

    list[y][x].neighbors = neighbors;
  }

  void _calculateGeneration() {
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        int aliveNeighbors = _calculateAliveNeighbors(y, x);

        if (aliveNeighbors >= 2 && aliveNeighbors < 3) {
        } else if (aliveNeighbors == 3) {
          cells[y][x].toggleOnCell();
        } else {
          cells[y][x].killCell();
        }
      }
    }
  }

  int _calculateAliveNeighbors(int y, int x) {
    int aliveNeighborCounter = 0;

    for (var element in cells[y][x].neighbors) {
      if (element.value == 1) aliveNeighborCounter++;
    }

    return aliveNeighborCounter;
  }

  void _updateGeneration() {
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        cells[y][x].updateRoundValues();
      }
    }
  }

  void renderBoard() {
    // render cell sprite

    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        Cell currentCell = cells[y][x];

        add(currentCell
          ..sprite = cellSprite
          ..position = Vector2(
              cellSize * currentCell.line, cellSize * currentCell.column)
          ..size = Vector2(
            cellSize,
            cellSize,
          ));
      }
    }
  }

  void clear() {
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        cells[y][x].next = 0;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update cell sprite
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        Cell currentCell = cells[y][x];
        if (currentCell.value == 1) {
          currentCell.setOpacity(1);
        }
        if (currentCell.value == 0) {
          currentCell.setOpacity(0);
        }
      }
    }
  }

  execute() {
    _calculateGeneration();
    _updateGeneration();
  }
}
