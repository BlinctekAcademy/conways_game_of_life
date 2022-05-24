import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conway_gol/controllers/grid_controller.dart';

class ConwayGrid extends StatelessWidget {
  const ConwayGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int col = GridController.colCount;
    int row = GridController.rowCount;
    return Container(
        width: 500,
        height: 500,
        color: Colors.grey,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: col,
              childAspectRatio: 1,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 0.5),
          itemCount: row * col,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: context.watch<GridController>().game.board[index ~/ col]
                          [index % col] ==
                      0
                  ? Colors.white
                  : Colors.black,
              child: GestureDetector(
                onTap: () {
                  context
                      .read<GridController>()
                      .tapCell((index % col), (index ~/ col));
                },
              ),
            );
          },
        ));
  }
}
