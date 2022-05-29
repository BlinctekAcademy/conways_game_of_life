import 'package:flutter/material.dart';
import 'package:game_of_life/components/game_of_life_grid.dart';
import 'classes/game.dart' show Game;
import 'components/my_button.dart' show MyButton;

class MyGameOfLife extends StatefulWidget {
  const MyGameOfLife({Key? key}) : super(key: key);

  @override
  State<MyGameOfLife> createState() => _MyGameOfLifeState();
}

class _MyGameOfLifeState extends State<MyGameOfLife> {
  Game? game;

  @override
  Widget build(BuildContext context) {
    game ??= Game(updateScreen);

    return Scaffold(
      backgroundColor: const Color.fromARGB(135, 2, 2, 2),
      body: SafeArea(
        child: Row(
          children: [
            Column(
              children: [
                MyButton(
                    function: game!.play,
                    tooltip: 'Play',
                    icon: const Icon(Icons.play_arrow)),
                MyButton(
                    function: game!.accelerate,
                    tooltip: 'Accelerate',
                    icon: const Icon(Icons.skip_next)),
                MyButton(
                    function: game!.restart,
                    tooltip: 'Restart',
                    icon: const Icon(Icons.restart_alt)),
              ],
            ),
            Column(
              children: [
                MyButton(
                    function: game!.pause,
                    tooltip: 'Pause',
                    icon: const Icon(Icons.pause)),
                MyButton(
                    function: game!.decelerate,
                    tooltip: 'Decelerate',
                    icon: const Icon(Icons.skip_previous)),
                MyButton(
                    function: game!.random,
                    tooltip: 'Random',
                    icon: const Icon(Icons.shuffle))
              ],
            ),
            GameOfLifeGrid(game: game!),
          ],
        ),
      ),
    );
  }

  void updateScreen(Function function) {
    setState(() {
      function();
    });
  }
}
