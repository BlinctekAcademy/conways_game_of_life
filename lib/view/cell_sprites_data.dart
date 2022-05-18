import 'package:flame/components.dart';
import 'package:flame/game.dart';

class CellSprites extends Component {
  final SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
    amount: 14,
    stepTime: 0.4,
    textureSize: Vector2(33, 33),
  );
  final SpriteAnimationData emptySpriteData = SpriteAnimationData.sequenced(
    amount: 1,
    stepTime: 1,
    textureSize: Vector2(39, 39),
  );
}
