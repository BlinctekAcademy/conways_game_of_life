import 'package:flame/components.dart';
import 'package:flame/input.dart';

class Cell extends SpriteComponent with Tappable {
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
}
