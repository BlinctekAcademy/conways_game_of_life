import 'dart:async';
import 'dart:ui';
import 'package:antoniogameoflife/view/menu/play_button.dart';
import 'package:antoniogameoflife/view/palette/palette.dart';
import 'package:flame/components.dart';
import 'package:flame/widgets.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter/material.dart' hide Image;

class Menu extends PositionComponent with HasGameRef {
  late double parentWidth;
  late Timer clock;
  late Image playButtonImage;
  Function startGame;

  late PositionComponent titleComponent;
  late PlayButton playButton;
  late SpriteButton clearButton;

  Menu({
    required this.startGame,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    loadAssets();
    createPlayButton();
    renderGameTitle();
    renderSubtitle();
    startTimer();
  }

  void loadAssets() {
    playButtonImage = gameRef.images.fromCache("play.png");
    parentWidth = gameRef.size[0];
  }

  void startTimer() {
    clock = Timer(0.18, onTick: () {
      moveDown();
    }, repeat: true, autoStart: true);
  }

  void moveDown() {
    if (titleComponent.position.y < 0) {
      titleComponent.position.y += 12;
    } else {
      appearButton();
    }
  }

  void appearButton() {
    double opacity = playButton.getOpacity();
    if (opacity <= 0.8) {
      playButton.setOpacity(opacity += 0.2);
    }
  }

  void renderGameTitle() {
    const mainStyle = TextStyle(
      fontFamily: 'perfect',
      fontSize: 60,
      color: Color.fromARGB(255, 255, 255, 255),
    );
    final shadowStyle = TextStyle(
      fontFamily: 'perfect',
      fontSize: 60,
      color: Palette.pink,
    );

    final regular = TextPaint(style: mainStyle);
    final pink = TextPaint(style: shadowStyle);

    TextComponent gameTitle =
        TextComponent(text: "CONWAY'S GAME OF LIFE", textRenderer: regular)
          ..anchor = Anchor.topCenter
          ..position = Vector2(parentWidth / 2, 110);

    TextComponent gameShadow =
        TextComponent(text: "CONWAY'S GAME OF LIFE", textRenderer: pink)
          ..anchor = Anchor.topCenter
          ..position = Vector2(parentWidth / 2, 110 + 5);

    titleComponent = PositionComponent();
    titleComponent.position.y = -200;
    titleComponent.addAll([renderSubtitle(), gameShadow, gameTitle]);
    add(titleComponent);
  }

  TextComponent renderSubtitle() {
    const subtitleStyle = TextStyle(
      fontFamily: 'pixeloid',
      fontSize: 28,
      color: Color.fromARGB(255, 215, 199, 208),
    );

    TextComponent subtitle = TextComponent(
        text: "by Antonio Teixeira",
        textRenderer: TextPaint(style: subtitleStyle))
      ..anchor = Anchor.topCenter
      ..position = Vector2(parentWidth / 2, 163);

    return subtitle;
  }

  void createPlayButton() {
    playButton = PlayButton(
      parentWidth: parentWidth,
      startGame: () {
        startGame();
      },
    )
      ..sprite = Sprite(playButtonImage)
      ..setOpacity(0);

    add(playButton);
  }

  @override
  void update(double dt) {
    super.update(dt);
    clock.update(dt);
  }
}
