import 'package:flame/flame.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

class BackgroundSong extends FlameAudio {
  static void initialize() async {
    await FlameAudio.bgm.audioCache.load('song.mp3');
    FlameAudio.bgm.stop();
  }

  static void play() {
    FlameAudio.bgm.play('song.mp3');
  }

  static void pause() {
    FlameAudio.bgm.pause();
  }
}
