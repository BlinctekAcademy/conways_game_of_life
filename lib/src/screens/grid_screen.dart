import 'package:marianne_of_life/src/constants/color_constants.dart';
import 'package:marianne_of_life/src/game_objects/simple_rules.dart';
import 'package:marianne_of_life/src/widgets/colour_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Iterable<MapEntry<int, T>> enumerate<T>(Iterable<T> items) sync* {
  int index = 0;
  for (T item in items) {
    yield MapEntry(index, item);
    index = index + 1;
  }
}

class MaterialCanvasGoL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("rebuilt");
    Color? aliveColor = Provider.of<ColorConstants>(context).aliveColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.all_inclusive),
              onPressed: () =>
                  Provider.of<GoLTruths>(context, listen: false).resetGame(),
            ),
            IconButton(
              icon: Icon(Icons.play_arrow_rounded),
              onPressed: () =>
                  Provider.of<GoLTruths>(context, listen: false).driveUpdate(),
            ),
            Text(Provider.of<GoLTruths>(context).gameMessage!),
            Text(Provider.of<GoLTruths>(context).totalAlive.toString()),
            PopupMenuButton(
                itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                          value: "Select Colour",
                          child: GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => ColourMenu()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Only black to choose"),
                                Icon(
                                  Icons.circle,
                                  color: ColorConstants().aliveColor,
                                )
                              ],
                            ),
                          )),
                    ])
          ],
        ),
      ),
      body: Material(
        child: Consumer<GoLTruths>(
          builder: (context, _goLTruths, _) => GestureDetector(
            onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) =>
                _drawCellsToLife(details),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _goLTruths.crossAxis),
              children: enumerate(_goLTruths.truths)
                  .expand((row) => row.value
                      .asMap()
                      .map((col, cell) => MapEntry(
                          col, _cellWidget(context, row.key, col, cell)))
                      .values)
                  .toList(),
            ),
          ),
        ),
        color: aliveColor,
      ),
    );
  }

  Widget _cellWidget(BuildContext context, int row, int col, bool cell) {
    const int exclusionRange = 2;

    CellLocation loc = CellLocation(
      row: row,
      col: col,
    );
    if (row < exclusionRange ||
        col < exclusionRange ||
        row >= Provider.of<GoLTruths>(context).truths.length - exclusionRange ||
        col >= Provider.of<GoLTruths>(context).crossAxis - exclusionRange)
      return Container();

    return Consumer<GoLTruths>(
        builder: (context, _goLTruths, _) => Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                color: _goLTruths.truths[row][col]
                    ? ColorConstants().aliveColor
                    : Colors.white,
                child: ListTile(
                  onTap: () => _goLTruths.toggleCell = loc,
                ),
              ),
            ));
  }

  _drawCellsToLife(LongPressMoveUpdateDetails details) {}
}
