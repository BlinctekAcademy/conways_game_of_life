import 'package:conways/pages/custom_page.dart';
import 'package:conways/pages/random_page.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                image: DecorationImage(
                image: AssetImage('./images/life.gif'),
                fit: BoxFit.cover,    
                ),
              ),
            ),
            Center(
              child: Container(
                width: 700,
                height: 400,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const GameOfLifeScreen(title: 'Conway\'s Game of Life'))),
                        style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                        child: const Text("CUSTOM PAGE"),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                     ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const RandomPage(title: 'Conway\'s Game of Life'))),
                        style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                        child: const Text("RANDOM PAGE"),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}