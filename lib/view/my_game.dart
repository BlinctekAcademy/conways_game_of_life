import 'package:antoniogameoflife/audio/background_song.dart';
import 'package:antoniogameoflife/logic/game_of_life.dart';
import 'package:antoniogameoflife/view/background.dart';
import 'package:antoniogameoflife/view/game_hud.dart';
import 'package:antoniogameoflife/view/menu.dart';
import 'package:antoniogameoflife/view/pause_button.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with HasTappables, HasHoverables {
  late Timer gameTick;
  late GameOfLife game;
  late Menu menu;
  late GameHud hud;
  final List<double> gameSpeedList = [0.04, 0.1, 0.4, 0.8, 1];
  late double gameSpeedInSeconds = gameSpeedList[2];

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    startTimer();

    game = GameOfLife(
      gameWidth: size[0].floor(),
      gameHeight: size[1].floor() - 100,
      cellSize: 30,
    );

    // Load Sprites
    game.cellSprite = await loadSprite("cell_sprite.png");
    await images.load("pause.png");
    await images.load("resume.png");
    await images.load("clear.png");
    await images.load("play.png");
    await images.load("plus_button.png");
    await images.load("minus_button.png");

    // Background sprite
    await images.load("background.jpg");

    // Load audio
    await FlameAudio.audioCache.load('song.mp3');

    menu = Menu(
      parentWidth: size[0],
      playButtonImage: images.fromCache("play.png"),
      clearButtonImage: images.fromCache("clear.png"),
      startGame: () {
        startGame();
      },
    );

    renderBackground();
    //add(menu);
    startGame();
  }

  void startGame() async {
    add(game);
    //remove(menu);
    createHud();
    add(hud);
  }

  void createHud() {
    hud = GameHud(
      clearSprite: Sprite(images.fromCache("clear.png")),
      resumeSprite: Sprite(images.fromCache("resume.png")),
      pauseSprite: Sprite(images.fromCache("pause.png")),
      plusButtonSprite: Sprite(images.fromCache("plus_button.png")),
      minusButtonSprite: Sprite(images.fromCache("minus_button.png")),
      timer: gameTick,
      gameSpeed: gameSpeedInSeconds,
      game: game,
      increaseSpeed: increaseSpeed,
      decreaseSpeed: decreaseSpeed,
    );
  }

  void startTimer({bool isPaused = true}) {
    gameTick = Timer(
      gameSpeedInSeconds,
      onTick: () {
        game.execute();
        print('tic');
      },
      repeat: true,
    );

    if (isPaused == true) {
      gameTick.pause();
    }
  }

  void increaseSpeed() {
    int index = gameSpeedList.indexOf(gameSpeedInSeconds) + 1;
    if (index != -1) {
      gameSpeedInSeconds = gameSpeedList[index];
    }

    restartTimer();
  }

  void decreaseSpeed() {
    int index = gameSpeedList.indexOf(gameSpeedInSeconds) - 1;
    if (index != -1) {
      gameSpeedInSeconds = gameSpeedList[index];
    }
    restartTimer();
  }

  void restartTimer() {
    bool isPaused = !gameTick.isRunning();
    gameTick.stop();
    startTimer(isPaused: isPaused);
    remove(hud);
    createHud();
    add(hud);
  }

  void renderBackground() {
    Background bg = Background(
        backgroundImage: images.fromCache("background.jpg"), screenSize: size);
    add(bg);
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameTick.update(dt);
  }
}
