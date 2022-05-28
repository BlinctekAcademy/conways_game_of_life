import 'package:marianne_of_life/src/constants/color_constants.dart';
import 'package:marianne_of_life/src/game_objects/simple_rules.dart';
import 'package:flutter/material.dart';

import 'src/screens/grid_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => GoLTruths()..initGame(),
        ),
        ChangeNotifierProvider(
            create: (BuildContext context) => ColorConstants())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MaterialCanvasGoL(),
      ),
    );
  }
}
