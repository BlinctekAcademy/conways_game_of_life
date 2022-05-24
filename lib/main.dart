import 'package:conway_gol/controllers/grid_controller.dart';
import 'package:conway_gol/screen_elements/gol_grid.dart';
import 'package:conway_gol/screen_elements/gol_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => GridController())],
      child: MaterialApp(
        title: 'Conway GOL',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const GameMenu(),
          const SizedBox(
            height: 20,
          ),
          const ConwayGrid(),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'ACTUAL SPEED: ${context.watch<GridController>().speed} ms | GENERATION: ${context.watch<GridController>().actualGeneration}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
