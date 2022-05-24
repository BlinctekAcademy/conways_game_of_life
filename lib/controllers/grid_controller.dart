import 'package:conway_gol/logic/game_logic.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GridController extends ChangeNotifier {
  static int colCount = 35;
  static int rowCount = colCount;
  GameOfLife game = GameOfLife(side: colCount);
  bool isRunning = false;
  int speed = 500;
  int actualGeneration = 0;

  void play() {
    isRunning = true;
    passGenerations();
  }

  void pause() {
    isRunning = false;
    notifyListeners();
  }

  void restart() {
    game.board = game.createMap();
    isRunning = false;
    actualGeneration = 0;
    notifyListeners();
  }

  void changeSpeed() {
    if (speed == 500) {
      speed = 300;
    } else if (speed == 300) {
      speed = 100;
    } else {
      speed = 500;
    }
    notifyListeners();
  }

  void attMap() {
    game.attMap();
  }

  void tapCell(int x, int y) {
    game.board[y][x] = (game.board[y][x] + 1) % 2;
    notifyListeners();
  }

  Future<void> passGenerations() async {
    while (isRunning) {
      await Future.delayed(Duration(milliseconds: speed));
      attMap();
      actualGeneration += 1;
      notifyListeners();
    }
  }
}
