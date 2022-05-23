import 'package:antoniogameoflife/audio/background_song.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

class MusicButton extends SpriteComponent with Tappable {
  late Sprite onSprite;
  late Sprite offSprite;

  MusicButton({
    required this.onSprite,
    required this.offSprite,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
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
