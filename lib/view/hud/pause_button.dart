import 'package:flame/components.dart';
import 'package:flame/input.dart';

class PauseButton extends SpriteComponent with Tappable {
  Timer timer;
  late Sprite resumeSprite;
  late Sprite pauseSprite;

  PauseButton({
    required this.timer,
    required this.resumeSprite,
    required this.pauseSprite,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (timer.isRunning()) {
      timer.pause();
      sprite = resumeSprite;
    } else {
      timer.resume();
      sprite = pauseSprite;
    }

    return true;
  }

  @override
  void update(double dt) {
    if (timer.isRunning() && sprite == resumeSprite) {
      sprite = pauseSprite;
    }

    if (!timer.isRunning() && sprite == pauseSprite) {
      sprite = resumeSprite;
    }

    super.update(dt);
  }
}
