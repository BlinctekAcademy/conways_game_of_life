import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conways/pages/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: GoogleFonts.pressStart2p(
                      textStyle: const TextStyle(
                      fontSize: 60.0,
                      fontFamily: '',
                      color: Colors.white,
                    )
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Conwa\'s Game of Life'),
                      WavyAnimatedText('Press Here to Start'),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) => 
                        const GameOfLife(title: 'Conway\'s Game of Life')));
                    },
                  ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}