import 'package:flame/components.dart';
import 'package:flame/input.dart';

abstract class AbstractCell extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() {
    // TODO: implement onLoad
    sprite = Sprite(gameRef.images.fromCache("cell_sprite.png"));
    return super.onLoad();
  }
}

class Cell extends AbstractCell with Tappable {
  int column;
  int line;
  late List<Cell> neighbors;
  int value;
  int next;

  Cell({
    required this.column,
    required this.line,
    this.value = 0,
    this.next = 0,
  });

  @override
  Future<void>? onLoad() {
    setOpacity(0);
    return super.onLoad();
  }

  void killCell() {
    next = 0;
  }

  void toggleOnCell() {
    next = 1;
  }

  void updateRoundValues() {
    value = next;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    value = 1;
    next = 1;
    return true;
  }

  @override
  void update(double dt) {
    if (value == 1) {
      setOpacity(1);
    } else if (paint.color.opacity == 1 && value == 0) {
      setOpacity(0.08);
    }

    super.update(dt);
  }
}
