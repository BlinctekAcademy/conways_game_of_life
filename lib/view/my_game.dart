import 'package:antoniogameoflife/audio/background_song.dart';
import 'package:antoniogameoflife/logic/game_of_life.dart';
import 'package:antoniogameoflife/view/background.dart';
import 'package:antoniogameoflife/view/hud/game_hud.dart';
import 'package:antoniogameoflife/view/menu/menu.dart';
import 'package:antoniogameoflife/view/hud/pause_button.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MyGame extends FlameGame with HasTappables, HasHoverables {
  late Timer gameTick;
  late GameOfLife game;
  late Menu menu;
  late GameHud hud;

  final List<double> gameSpeedList = [0.04, 0.1, 0.4, 0.8, 1.2];
  final List<double> cellSizeList = [20, 30, 50];
  late double gameSpeedInSeconds;
  late double cellSize;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // Load Sprites
    await images.load("cell_sprite.png");
    await images.load("pause.png");
    await images.load("resume.png");
    await images.load("clear.png");
    await images.load("play.png");
    await images.load("plus_button.png");
    await images.load("minus_button.png");
    await images.load("music.png");
    await images.load("no_music.png");
    await images.load("background.jpg");

    // Load music
    BackgroundSong.initialize();

    gameSpeedInSeconds = gameSpeedList[2];
    cellSize = cellSizeList[1];
    startTimer();
    createGame();
    createMenu();
    renderBackground();

    add(menu);
  }

  void renderBackground() {
    add(Background());
  }

  GameOfLife createGame() {
    game = GameOfLife(
      cellSize: cellSize,
    );
    return game;
  }

  void startGame() {
    add(game);
    createHud();
    add(hud);
  }

  void createMenu() {
    menu = Menu(
      startGame: () {
        startGame();
        remove(menu);
      },
    );
  }

  void createHud() {
    hud = GameHud(
        timer: gameTick,
        gameSpeed: gameSpeedInSeconds,
        gameSpeedList: gameSpeedList,
        cellSize: cellSize,
        cellSizeList: cellSizeList,
        game: game,
        increaseSpeed: increaseSpeed,
        decreaseSpeed: decreaseSpeed,
        increaseCellSize: increaseCellSize,
        decreaseCellSize: decreaseCellSize);
  }

  void startTimer({bool isPaused = true}) {
    gameTick = Timer(
      gameSpeedInSeconds,
      onTick: () {
        game.execute();
      },
      repeat: true,
    );

    if (isPaused == true) {
      gameTick.pause();
    }
  }

  void restartTimer() {
    bool isPaused = !gameTick.isRunning();
    gameTick.stop();
    startTimer(isPaused: isPaused);
    remove(hud);
    createHud();
    add(hud);
  }

  void restartGame() {
    remove(hud);
    remove(game);
    createGame();
    createHud();
    add(game);
    add(hud);
  }

  void increaseSpeed() {
    int index = gameSpeedList.indexOf(gameSpeedInSeconds);
    if (index != -1) {
      gameSpeedInSeconds = gameSpeedList[index + 1];
      restartTimer();
    }
  }

  void decreaseSpeed() {
    int index = gameSpeedList.indexOf(gameSpeedInSeconds);
    if (index != -1 && index != 0) {
      gameSpeedInSeconds = gameSpeedList[index - 1];
      restartTimer();
    }
  }

  void increaseCellSize() {
    int index = cellSizeList.indexOf(cellSize);
    if (index != -1 && index < cellSizeList.length) {
      cellSize = cellSizeList[index + 1];
      gameTick.stop();
      restartGame();
    }
  }

  void decreaseCellSize() {
    int index = cellSizeList.indexOf(cellSize);
    if (index != -1 && index != 0) {
      cellSize = cellSizeList[index - 1];
      gameTick.stop();
      restartGame();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    gameTick.update(dt);
  }
}
