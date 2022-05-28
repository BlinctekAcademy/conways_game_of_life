import 'package:marianne_of_life/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:color_parser/color_parser.dart'; //thanks github user deepak786!

List<Color> colourOptions = [
  Colors.purple[
      600]!, // elements of the swatch table appear to return Color? not Color
  Colors.red[600]!,
  Colors.blue[600]!,
  Colors.orange[600]!
];

class ColourMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: colourOptions
          .map(
            (colourOption) => ColourOptionTile(
              colourOption: colourOption,
            ),
          )
          .toList(),
    );
  }
}

class ColourOptionTile extends StatelessWidget {
  final Color colourOption;
  const ColourOptionTile({
    Key? key,
    required this.colourOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        onTap: () => Provider.of<ColorConstants>(context, listen: false)
            .setAliveColor = colourOption,
        leading: Icon(
          Icons.circle,
          color: colourOption,
        ),
        title:
            Text("Colour option ${ColorParser.color(colourOption).toName()}"),
      ),
    );
  }
}
