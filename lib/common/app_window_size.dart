import 'package:flutter/material.dart';

class AppWindowSize {
  double _screenWidth = 0;
  double _screenHeight = 0;

  init(BuildContext context) {
    if (_screenHeight == 0) {
      _screenHeight = MediaQuery.of(context).size.height;
    }
    if (_screenWidth == 0) {
      _screenWidth = MediaQuery.of(context).size.width;
    }
  }

  /// Returns the width of the screen.
  double get screenWidth => _screenWidth;

  /// Returns the height of the screen.
  double get screenHeight => _screenHeight;
}
