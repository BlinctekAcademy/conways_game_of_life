import 'package:antoniogameoflife/logic/game_of_life.dart';
import 'package:antoniogameoflife/view/hud/cell_size_controller.dart';
import 'package:antoniogameoflife/view/hud/music_button.dart';
import 'package:antoniogameoflife/view/hud/pause_button.dart';
import 'package:antoniogameoflife/view/hud/speed_controller.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/bgm.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

class GameHud extends PositionComponent with HasGameRef {
  final GameOfLife game;
  final Function increaseSpeed;
  final Function decreaseSpeed;
  final Function increaseCellSize;
  final Function decreaseCellSize;
  late Vector2 gameSize;
  final List<double> gameSpeedList;
  final List<double> cellSizeList;
  double gameSpeed;
  double cellSize;
  Timer timer;

  GameHud({
    required this.timer,
    required this.gameSpeed,
    required this.gameSpeedList,
    required this.cellSize,
    required this.cellSizeList,
    required this.game,
    required this.increaseSpeed,
    required this.decreaseSpeed,
    required this.increaseCellSize,
    required this.decreaseCellSize,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    gameSize = gameRef.size;
    size = Vector2(gameRef.size[0], 100);

    RectangleComponent box = renderBox(gameSize);
    SpriteButtonComponent clearButton = renderClearButton();
    PauseButton pauseButton = renderPause();
    SpeedController speedController = createSpeedController();
    CellSizeController cellSizeController = createCellSizeController();
    MusicButton musicButton = createMusicButton();

    box.addAll([
      pauseButton,
      clearButton,
      speedController,
      cellSizeController,
      musicButton
    ]);
    add(box);
  }

  RectangleComponent renderBox(Vector2 gameSize) {
    Paint paint1 = Paint()
      ..color = Color.fromARGB(0, 0, 0, 0)
      ..style = PaintingStyle.fill;
    Rect rectangle =
        Rect.fromLTWH(0, gameSize[1] - 100, gameSize[0], gameSize[1]);
    RectangleComponent box = RectangleComponent.fromRect(rectangle);

    box.paint = paint1;

    return box;
  }

  SpriteButtonComponent renderClearButton() {
    SpriteButtonComponent clearButtonComponent = SpriteButtonComponent(
      button: Sprite(gameRef.images.fromCache("clear.png")),
      onPressed: () {
        game.clear();
      },
      size: Vector2(200, 80),
      anchor: Anchor.topLeft,
      position: Vector2(10, 0),
    );

    return clearButtonComponent;
  }

  PauseButton renderPause() {
    Sprite resumeSprite = Sprite(gameRef.images.fromCache("resume.png"));
    Sprite pauseSprite = Sprite(gameRef.images.fromCache("pause.png"));

    PauseButton pause = PauseButton(
      timer: timer,
      resumeSprite: resumeSprite,
      pauseSprite: pauseSprite,
    )
      ..size = Vector2(80, 80)
      ..anchor = Anchor.topCenter
      ..position = Vector2(gameSize[0] / 2, 0)
      ..sprite = timer.isRunning() ? pauseSprite : resumeSprite;

    return pause;
  }

  SpeedController createSpeedController() {
    SpeedController clearButtonComponent = SpeedController(
        gameSpeed: gameSpeed,
        gameSpeedList: gameSpeedList,
        increaseSpeed: () {
          increaseSpeed();
        },
        decreaseSpeed: () {
          decreaseSpeed();
        })
      ..size = Vector2(200, 80)
      ..anchor = Anchor.topCenter
      ..position = Vector2(gameSize[0] - 30, 12);

    return clearButtonComponent;
  }

  CellSizeController createCellSizeController() {
    CellSizeController cellSizeButton = CellSizeController(
        cellSize: cellSize,
        cellSizeList: cellSizeList,
        increase: () {
          increaseCellSize();
        },
        decrease: () {
          decreaseCellSize();
        })
      ..size = Vector2(200, 80)
      ..anchor = Anchor.topCenter
      ..position = Vector2(gameSize[0] - 250, 12);

    return cellSizeButton;
  }

  MusicButton createMusicButton() {
    MusicButton musicButtonComponent = MusicButton()
      ..size = Vector2(80, 80)
      ..anchor = Anchor.topCenter
      ..position = Vector2(260, 0);

    return musicButtonComponent;
  }
}
