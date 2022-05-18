import 'package:flame_audio/flame_audio.dart';

class BackgroundSong {
  void play() {
    FlameAudio.bgm.play('song.mp3');
  }
}
