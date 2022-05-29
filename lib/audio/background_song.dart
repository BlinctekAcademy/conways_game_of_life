import 'package:flame_audio/flame_audio.dart';

class BackgroundSong extends FlameAudio {
  static void initialize() async {
    FlameAudio.bgm.stop();
    await FlameAudio.bgm.audioCache.load('song.mp3');
  }

  static void play() {
    FlameAudio.bgm.play('song.mp3');
  }

  static void pause() {
    FlameAudio.bgm.pause();
  }
}
