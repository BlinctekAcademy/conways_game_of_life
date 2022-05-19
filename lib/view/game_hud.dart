import 'package:antoniogameoflife/logic/game_of_life.dart';
import 'package:antoniogameoflife/view/pause_button.dart';
import 'package:antoniogameoflife/view/speed_slider.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

class GameHud extends PositionComponent with HasGameRef {
  final Sprite clearSprite;
  final Sprite resumeSprite;
  final Sprite pauseSprite;
  final Sprite plusButtonSprite;
  final Sprite minusButtonSprite;
  final GameOfLife game;
  final Function increaseSpeed;
  final Function decreaseSpeed;
  late Vector2 gameSize;
  final List<double> gameSpeedList;
  double gameSpeed;
  Timer timer;

  GameHud({
    required this.clearSprite,
    required this.resumeSprite,
    required this.pauseSprite,
    required this.plusButtonSprite,
    required this.minusButtonSprite,
    required this.timer,
    required this.gameSpeed,
    required this.gameSpeedList,
    required this.game,
    required this.increaseSpeed,
    required this.decreaseSpeed,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    gameSize = gameRef.size;

    size = Vector2(gameRef.size[0], 100);

    RectangleComponent box = renderBox(gameSize);
    SpriteButtonComponent clearButton = renderClearButton();
    PauseButton pauseButton = renderPause();
    var slider = createSlider();

    box.addAll([pauseButton, clearButton, slider]);
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
    Paint paint1 = Paint()
      ..color = Color.fromARGB(0, 0, 0, 0)
      ..style = PaintingStyle.fill;

    SpriteButtonComponent clearButtonComponent = SpriteButtonComponent(
      button: clearSprite,
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

  SpeedSlider createSlider() {
    Paint paint1 = Paint()
      ..color = Color.fromARGB(0, 0, 0, 0)
      ..style = PaintingStyle.fill;

    SpeedSlider clearButtonComponent = SpeedSlider(
        gameSpeed: gameSpeed,
        gameSpeedList: gameSpeedList,
        plusSprite: plusButtonSprite,
        minusSprite: minusButtonSprite,
        increaseSpeed: () {
          increaseSpeed();
        },
        decreaseSpeed: () {
          decreaseSpeed();
        })
      ..size = Vector2(200, 80)
      ..anchor = Anchor.topRight
      ..position = Vector2(gameSize[0] - 10, 0);

    return clearButtonComponent;
  }
}
