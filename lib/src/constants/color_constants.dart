import 'package:flutter/material.dart';

class ColorConstants with ChangeNotifier {
  /* 
    these were going to be constant colours at one point but it's a simple app
    so I've opted instead for one colour that the user can change,
    hence the getters and setters and the total lack of a const keyworkd
    on this constant class 
  */
  ColorConstants();

  Color _aliveColor = Colors.black;
  Color? get aliveColor => _aliveColor;
  Color get hRefColor => Colors.blue;
  set setAliveColor(Color color) => _setAliveColor(color);

  void _setAliveColor(Color color) {
    _aliveColor = color;
    notifyListeners();
  }
}

ColorConstants colourConstants = ColorConstants();  // export default line, kinda
