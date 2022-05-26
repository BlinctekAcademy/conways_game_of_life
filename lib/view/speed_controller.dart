import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class SpeedController extends PositionComponent with HasGameRef {
  double gameSpeed;
  final List<double> gameSpeedList;
  final Function increaseSpeed;
  final Function decreaseSpeed;
  late final Sprite plusSprite;
  late final Sprite minusSprite;

  SpeedController({
    required this.gameSpeed,
    required this.gameSpeedList,
    required this.increaseSpeed,
    required this.decreaseSpeed,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    loadAssets();
    SpriteButtonComponent plusButton = createIncreaseButton();
    SpriteButtonComponent minusButton = createDecreaseButton();

    add(createText(speedLabel()));
    add(plusButton..position = Vector2(58, 0));
    add(minusButton..position = Vector2(-58, 0));
  }

  void loadAssets() {
    plusSprite = Sprite(gameRef.images.fromCache("plus_button.png"));
    minusSprite = Sprite(gameRef.images.fromCache("minus_button.png"));
  }

  SpriteButtonComponent createIncreaseButton() {
    SpriteButtonComponent plusComponent = SpriteButtonComponent(
      button: plusSprite,
      onPressed: () {
        increaseSpeed();
      },
      size: Vector2(40, 40),
      anchor: Anchor.topLeft,
    );

    return plusComponent;
  }

  SpriteButtonComponent createDecreaseButton() {
    SpriteButtonComponent minusComponent = SpriteButtonComponent(
      button: minusSprite,
      onPressed: () {
        decreaseSpeed();
      },
      size: Vector2(40, 40),
      anchor: Anchor.topRight,
    );

    return minusComponent;
  }

  TextComponent createText(String string) {
    const style = TextStyle(
      fontFamily: 'pixeloid',
      fontSize: 25,
      color: Color.fromARGB(255, 255, 255, 255),
    );
    final regular = TextPaint(style: style);
    TextComponent text = TextComponent(text: string, textRenderer: regular)
      ..anchor = Anchor.topCenter;

    return text;
  }

  String speedLabel() {
    if (gameSpeedList.indexOf(gameSpeed) == 0) {
      return 'Crazy';
    } else if (gameSpeedList.indexOf(gameSpeed) == 1) {
      return 'Fast';
    } else if (gameSpeedList.indexOf(gameSpeed) == 2) {
      return 'Medium';
    } else if (gameSpeedList.indexOf(gameSpeed) == 3) {
      return 'Slow';
    } else if (gameSpeedList.indexOf(gameSpeed) == 4) {
      return 'Zzzz';
    }

    return 'Error';
  }
}
