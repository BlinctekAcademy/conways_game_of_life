import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class CellSizeController extends PositionComponent {
  double cellSize;
  final List<double> cellSizeList;
  final Sprite plusSprite;
  final Sprite minusSprite;
  final Function increase;
  final Function decrease;

  CellSizeController({
    required this.cellSize,
    required this.cellSizeList,
    required this.plusSprite,
    required this.minusSprite,
    required this.increase,
    required this.decrease,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    SpriteButtonComponent plusButton = createIncreaseButton();
    SpriteButtonComponent minusButton = createDecreaseButton();

    add(createText(label()));
    add(plusButton..position = Vector2(58, 0));
    add(minusButton..position = Vector2(-58, 0));
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
