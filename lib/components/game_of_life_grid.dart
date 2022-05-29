import 'package:flutter/material.dart';
import 'package:game_of_life/classes/game.dart';

class GameOfLifeGrid extends StatefulWidget {
  final Game game;

  const GameOfLifeGrid({Key? key, required this.game}) : super(key: key);

  @override
  State<GameOfLifeGrid> createState() => _GameOfLifeGridState();
}

class _GameOfLifeGridState extends State<GameOfLifeGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
        left: 200,
      ),
      child: SizedBox(
        width: 600,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.game.board.columnCount,
                childAspectRatio: 1,
                mainAxisSpacing: 0.5,
                crossAxisSpacing: 0.5),
            itemCount:
                widget.game.board.columnCount * widget.game.board.rowCount,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: widget.game.board.representation[
                            index ~/ widget.game.board.columnCount]
                        [index % widget.game.board.rowCount]
                    ? Colors.pinkAccent
                    : Colors.white,
                child: GestureDetector(
                    onTap: () => setState(() {
                          widget.game.board.swapIndexValue(
                              index ~/ widget.game.board.columnCount,
                              index % widget.game.board.rowCount);
                        })),
              );
            }),
      ),
    );
  }
}
