import 'dart:async';
import 'dart:ui';
import 'package:antoniogameoflife/view/play_button.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart' hide Image;

class Menu extends PositionComponent {
  double parentWidth;
  late Timer clock;
  late Image playButtonImage;
  late Image clearButtonImage;
  Function startGame;

  late PositionComponent titleComponent;
  late PlayButton playButton;
  late SpriteButton clearButton;

  Menu({
    required this.parentWidth,
    required this.playButtonImage,
    required this.clearButtonImage,
    required this.startGame,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    createPlayButton();
    renderGameTitle();
    renderSubtitle();
    startTimer();
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
    const shadowStyle = TextStyle(
      fontFamily: 'perfect',
      fontSize: 60,
      color: Color.fromARGB(255, 212, 39, 134),
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

  void createClearButton() {
    SpriteButtonComponent clearButtonComponent = SpriteButtonComponent(
      button: Sprite(clearButtonImage),
      onPressed: () {},
      size: Vector2(200, 80),
      anchor: Anchor.topCenter,
      position: Vector2(parentWidth / 2, 500),
    );

    add(clearButtonComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    clock.update(dt);
  }
}
