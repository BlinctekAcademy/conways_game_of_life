import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class CellSizeController extends PositionComponent with HasGameRef {
  double cellSize;
  final List<double> cellSizeList;
  final Function increase;
  final Function decrease;
  late final Sprite plusSprite;
  late final Sprite minusSprite;

  CellSizeController({
    required this.cellSize,
    required this.cellSizeList,
    required this.increase,
    required this.decrease,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    loadAssets();

    SpriteButtonComponent plusButton = createIncreaseButton();
    SpriteButtonComponent minusButton = createDecreaseButton();

    add(createText(label()));
    add(plusButton..position = Vector2(58, 0));
    add(minusButton..position = Vector2(-58, 0));
  }

  void loadAssets() {
    plusSprite = Sprite(gameRef.images.fromCache('plus_button.png'));
    minusSprite = Sprite(gameRef.images.fromCache('minus_button.png'));
  }

  SpriteButtonComponent createIncreaseButton() {
    SpriteButtonComponent plusComponent = SpriteButtonComponent(
      button: plusSprite,
      onPressed: () {
        increase();
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
        decrease();
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

  String label() {
    if (cellSizeList.indexOf(cellSize) == 0) {
      return 'Small';
    } else if (cellSizeList.indexOf(cellSize) == 1) {
      return 'Regular';
    } else if (cellSizeList.indexOf(cellSize) == 2) {
      return 'Large';
    }

    return 'Error';
  }
}
