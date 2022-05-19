import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class SpeedSlider extends PositionComponent {
  double gameSpeed;
  Sprite sprite;
  final Function increaseSpeed;
  final Function decreaseSpeed;

  SpeedSlider({
    required this.gameSpeed,
    required this.sprite,
    required this.increaseSpeed,
    required this.decreaseSpeed,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    Paint paint1 = Paint()
      ..color = Color.fromARGB(0, 0, 0, 0)
      ..style = PaintingStyle.fill;

    SpriteButtonComponent plusButton = createButton();

    add(createText('Speed'));
    add(plusButton..position = Vector2(75, 0));
  }

  SpriteButtonComponent createButton() {
    SpriteButtonComponent sliderComponent = SpriteButtonComponent(
      button: sprite,
      onPressed: () {
        increaseSpeed();
      },
      size: Vector2(40, 40),
      anchor: Anchor.topCenter,
    );

    return sliderComponent;
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
