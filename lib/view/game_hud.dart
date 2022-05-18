import 'package:antoniogameoflife/logic/game_of_life.dart';
import 'package:antoniogameoflife/view/pause_button.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'dart:ui';

class GameHud extends PositionComponent with HasGameRef {
  final Sprite clearSprite;
  final Sprite resumeSprite;
  final Sprite pauseSprite;
  final GameOfLife game;
  late Vector2 gameSize;
  var timer;

  GameHud({
    required this.clearSprite,
    required this.resumeSprite,
    required this.pauseSprite,
    required this.timer,
    required this.game,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    gameSize = gameRef.size;

    size = Vector2(gameRef.size[0], 100);

    RectangleComponent box = renderBox(gameSize);
    SpriteButtonComponent clearButton = renderClearButton();
    PauseButton pauseButton = renderPause();

    box.addAll([pauseButton, clearButton]);
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
      ..position = Vector2(gameSize[0] / 2, 0);

    return pause;
  }
}
