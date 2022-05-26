import 'package:antoniogameoflife/audio/background_song.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

class MusicButton extends SpriteComponent with Tappable, HasGameRef {
  late Sprite onSprite;
  late Sprite offSprite;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    loadAssets();
    sprite = onSprite;
  }

  void loadAssets() {
    onSprite = Sprite(gameRef.images.fromCache('music.png'));
    offSprite = Sprite(gameRef.images.fromCache('no_music.png'));
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (FlameAudio.bgm.isPlaying == false) {
      BackgroundSong.play();
      sprite = onSprite;
    } else {
      BackgroundSong.pause();
      sprite = offSprite;
    }

    return true;
  }
}
