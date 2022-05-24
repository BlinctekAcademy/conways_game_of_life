import 'package:conway_gol/controllers/grid_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameMenu extends StatelessWidget {
  const GameMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
            heroTag: 'play_button',
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: const Icon(Icons.play_arrow),
            onPressed: () {
              context.read<GridController>().play();
            }),
        const SizedBox(
          width: 50,
        ),
        FloatingActionButton(
          heroTag: 'pause_button',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () {
            context.read<GridController>().pause();
          },
          child: const Icon(Icons.pause),
        ),
        const SizedBox(
          width: 50,
        ),
        FloatingActionButton(
            heroTag: 'restart_button',
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              context.read<GridController>().restart();
            },
            child: const Icon(
              Icons.restart_alt,
            )),
        const SizedBox(
          width: 50,
        ),
        FloatingActionButton(
            heroTag: 'speed_button',
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: () {
              context.read<GridController>().changeSpeed();
            },
            child: const Icon(
              Icons.speed,
            )),
      ],
    );
  }
}
