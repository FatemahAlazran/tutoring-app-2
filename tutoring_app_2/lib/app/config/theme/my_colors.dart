import 'package:flutter/material.dart';

abstract class MyColors {
  /// check google material design website for color templates
  /// https://m2.material.io/design/color/the-color-system.html#tools-for-picking-colors
  static const Color primary_500 = Color.fromARGB(255, 72, 103, 79);
  static const Color secondary_500 = Color.fromARGB(255, 54, 57, 67);
  static const Color secondary_400 = Color.fromARGB(255, 47, 71, 63);
  static const Color greyscale_500 = Color(0xFF9E9E9E);
  static const Color greyscale_100 = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Colors.black;
  static const MaterialColor blue = Colors.blue;
}
