import 'package:flutter/material.dart';
import 'my_game_of_life.dart' show MyGameOfLife;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyGameOfLife(),
    );
  }
}
