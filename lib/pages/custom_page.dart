
import 'package:conways/cubits/tile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/board_cubit.dart';
import '../widgets/cell.dart';

class GameOfLife extends StatefulWidget {
  final String title;
  const GameOfLife({Key? key, required this.title}) : super(key: key);

  

  @override
  _GameOfLife createState() => _GameOfLife();
}

class _GameOfLife extends State<GameOfLife> {
  final dimension = 20.0;
  late int rowCount, columnCount;

  @override
  Widget build(BuildContext context) {
    const screenWidth = 800;
    const screenHeight = 500;

    rowCount = screenHeight ~/ dimension;
    columnCount = screenWidth ~/ dimension;

    final boardCubit = BlocProvider.of<BoardCubit>(context);
    boardCubit.initBoard(rows: rowCount, columns: columnCount);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 200),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            for (final i in List.generate(rowCount, (i) => i))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final j in List.generate(columnCount, (i) => i))
                    Tile(
                      dimension: dimension,
                      tileCubit: boardCubit.tileCubits[i][j],
                    ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.yellow,
                shape: const CircleBorder(),
                onPressed: () {
                  boardCubit.forward();
                },
                child: const Icon(
                    Icons.arrow_right, size: 30,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: MaterialButton(
                  color: Colors.yellow,
                  shape: const CircleBorder(),
                  onPressed: () {
                    boardCubit.pause();
                  },
                  child: const Icon(
                      Icons.stop, size: 20,
                    ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
