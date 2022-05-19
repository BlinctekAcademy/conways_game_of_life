import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class SpeedSlider extends PositionComponent {
  double gameSpeed;
  final Sprite plusSprite;
  final Sprite minusSprite;
  final Function increaseSpeed;
  final Function decreaseSpeed;

  SpeedSlider({
    required this.gameSpeed,
    required this.plusSprite,
    required this.minusSprite,
    required this.increaseSpeed,
    required this.decreaseSpeed,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    Paint paint1 = Paint()
      ..color = Color.fromARGB(0, 0, 0, 0)
      ..style = PaintingStyle.fill;

    SpriteButtonComponent plusButton = createIncreaseButton();
    SpriteButtonComponent minusButton = createDecreaseButton();

    add(createText('Speed'));
    add(plusButton..position = Vector2(55, 0));
    add(minusButton..position = Vector2(-55, 0));
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
}
