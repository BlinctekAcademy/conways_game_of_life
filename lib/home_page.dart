import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_processing/flutter_processing.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pixelsPerCell = 20.0;
  late int rowCount;
  late int colCount;
  late List<List<bool>> _grid;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('./images/life.gif'),
            fit: BoxFit.cover,    
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SafeArea(
            child: Processing(
              sketch: Sketch.simple(
                setup: (sketch) async {
                  sketch.frameRate = 24;
                  sketch.size(
                    width: 800,
                    height: 400,
                  );
                  colCount = (sketch.width / pixelsPerCell).floor();
                  rowCount = (sketch.height / pixelsPerCell).floor();
                  _grid = generateGrid();
                },
                draw: (sketch) async { 
                  sketch.background(color: Colors.black);
                  sketch.fill(color: Colors.white);
                  for (int col = 0; col < colCount; col++) {
                    for (int row = 0; row < rowCount; row++) {
                      if (_grid[col][row]) {
                        final block = Offset(col * pixelsPerCell, row * pixelsPerCell);
                        sketch.rect(rect: Rect.fromLTWH(block.dx, block.dy, pixelsPerCell, pixelsPerCell));
                      }
                    }
                  }
                  createNextGeneration();
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _grid = generateGrid();
            });
          },
          backgroundColor: Colors.yellow,
          tooltip: 'Reset',
          child: const Icon(
            Icons.replay_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  // random grid
  List<List<bool>> generateGrid() {
    return List.generate(
      colCount,
      (index) => List.generate(
        rowCount,
        (index) => Random().nextBool(),
      ),
    );
  }

  void createNextGeneration() {
    var newGrid = List.generate(
      colCount,
      (index) => List.generate(
        rowCount,
        (index) => Random().nextBool(),
      ),
    );

    for (int col = 0; col < colCount; col++) {
      for (int row = 0; row < rowCount; row++) {
        newGrid[col][row] = calculateNextCellValue(col, row);
      }
    }

    _grid = newGrid;
  }

  bool calculateNextCellValue(int col, int row) {
    int liveNeighboursCount = 0;

    // cima esquerda
    liveNeighboursCount += (col > 0) && row > 0 && _grid[col - 1][row - 1] ? 1 : 0;

    // cima
    liveNeighboursCount += (row > 0) && _grid[col][row - 1] ? 1 : 0;

    // direita cima
    liveNeighboursCount += (col < colCount - 1) && (row > 0) && _grid[col + 1][row - 1] ? 1 : 0;

    // direita
    liveNeighboursCount += (col < colCount - 1) && _grid[col + 1][row] ? 1 : 0;

    // baixo direita
    liveNeighboursCount += (col < colCount - 1) && (row < rowCount - 1) && _grid[col + 1][row + 1] ? 1 : 0;

    // baixo
    liveNeighboursCount += (row < rowCount - 1) && _grid[col][row + 1] ? 1 : 0;

    // baixo esquerda
    liveNeighboursCount += (col > 0) && (row < rowCount - 1) && _grid[col - 1][row + 1] ? 1 : 0;

    // esquerda
    liveNeighboursCount += (col > 0) && _grid[col - 1][row] ? 1 : 0;

    if (_grid[col][row] &&
        liveNeighboursCount >= 2 &&
        liveNeighboursCount <= 3) {
      // cell survives
      return true;
    } else if (!_grid[col][row] && liveNeighboursCount == 3) {
      // new cell is born
      return true;
    } else if (_grid[col][row] && liveNeighboursCount > 3) {
      // cell dies due to over population
      return false;
    } else {
      // cell remains dead
      return false;
    }
  }
}