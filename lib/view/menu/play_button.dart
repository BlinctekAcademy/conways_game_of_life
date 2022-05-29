import 'package:antoniogameoflife/audio/background_song.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class PlayButton extends SpriteComponent with Tappable, Hoverable {
  double parentWidth;
  Function startGame;

  PlayButton({
    required this.parentWidth,
    required this.startGame,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    size = Vector2(200, 80);
    anchor = Anchor.topCenter;
    position = Vector2(parentWidth / 2, 500);
  }

  void renderBox() {
    PositionComponent buttonBox = PositionComponent(
        anchor: anchor, position: Vector2(100, 20), size: size);

    add(buttonBox);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    startGame();
    BackgroundSong.play();
    return true;
  }
}
