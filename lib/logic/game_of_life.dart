import 'dart:async';
import 'package:antoniogameoflife/logic/cell.dart';
import 'package:flame/components.dart';

class GameOfLife extends PositionComponent with HasGameRef {
  final double cellSize;
  late final int gameWidth;
  late final int gameHeight;
  late final double cellWidthAmount;
  late final double cellHeightAmount;
  List<List<Cell>> cells = [];
  bool clearGame = false;
  late PositionComponent board;
  late Sprite cellSprite;

  GameOfLife({
    required this.cellSize,
  });

  @override
  Future<void>? onLoad() async {
    cellSprite = Sprite(gameRef.images.fromCache("cell_sprite.png"));
    gameWidth = gameRef.size[0].floor() - 50;
    gameHeight = gameRef.size[1].floor() - 100;
    cellWidthAmount = (gameWidth / cellSize).floorToDouble();
    cellHeightAmount = (gameHeight / cellSize).floorToDouble();

    renderBoard();
  }

  void renderBoard() {
    createCells();
    board = createBoard();
    add(board);
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

  PositionComponent createBoard() {
    PositionComponent newBoard = PositionComponent();
    // render cell sprite
    for (int y = 0; y < cellHeightAmount; y++) {
      for (int x = 0; x < cellWidthAmount; x++) {
        Cell currentCell = cells[y][x];

        newBoard.add(currentCell
          ..sprite = cellSprite
          ..position = Vector2(
              cellSize * currentCell.line, cellSize * currentCell.column)
          ..size = Vector2(
            cellSize,
            cellSize,
          ));
      }
    }
    return newBoard;
  }

  void clear() {
    clearGame = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (clearGame == true) {
      remove(board);
      createCells();
      board = createBoard();
      add(board);
      clearGame = false;
    }
  }

  execute() {
    _calculateGeneration();
    _updateGeneration();
  }
}
