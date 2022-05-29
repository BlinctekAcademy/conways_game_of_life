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
      margin: const EdgeInsets.only(top: 160, left: 10),
      child: SizedBox(
        width: 230,
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
