import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent with HasGameRef {
  late final backgroundImage;
  late Vector2 screenSize;

  Background() : super(anchor: Anchor.center);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    loadGameRef();
    renderComponents();
  }

  void loadGameRef() {
    backgroundImage = gameRef.images.fromCache("background.jpg");
    screenSize = gameRef.size;
  }

  RectangleComponent renderBlind() {
    Paint paint1 = Paint()
      ..color = const Color.fromARGB(143, 23, 3, 36)
      ..style = PaintingStyle.fill;
    RectangleComponent blind = RectangleComponent.fromRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
    )..paint = paint1;

    return blind;
  }

  SpriteAnimationComponent renderBackground() {
    final spriteSize = Vector2(640, 400);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 12, stepTime: 0.1, textureSize: spriteSize);

    SpriteAnimationComponent background =
        SpriteAnimationComponent.fromFrameData(backgroundImage, spriteData)
          ..size = Vector2(screenSize.x, screenSize.y + 100);

    return background;
  }

  void renderComponents() {
    addAll([renderBackground(), renderBlind()]);
  }
}
