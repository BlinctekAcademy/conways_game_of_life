
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/board_cubit.dart';
import '../widgets/cell.dart';

class GameOfLifeScreen extends StatefulWidget {
  final String title;
  const GameOfLifeScreen({Key? key, required this.title}) : super(key: key);

  

  @override
  _GameOfLifeScreenState createState() => _GameOfLifeScreenState();
}

class _GameOfLifeScreenState extends State<GameOfLifeScreen> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                onPressed: () {
                  boardCubit.forward();
                },
                child: const Text("Start", style: TextStyle(color: Colors.black),),
                ),
                TextButton(
                onPressed: () {
                  boardCubit.pause(); //fix
                },
                child: const Text("Stop", style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
