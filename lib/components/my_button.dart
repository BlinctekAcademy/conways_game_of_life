import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function function;
  final String tooltip;
  final Icon icon;

  const MyButton(
      {Key? key,
      required this.function,
      required this.tooltip,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80, left: 30),
      child: SizedBox(
        width: 400,
        height: 90,
        child: FloatingActionButton(
            onPressed: (() {
              function();
            }),
            tooltip: tooltip,
            child: icon),
      ),
    );
  }
}
