import 'package:antoniogameoflife/view/my_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'logic/game_of_life.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}
