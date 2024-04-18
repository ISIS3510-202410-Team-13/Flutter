import 'package:flutter/material.dart';

class ColorConstants {

  static const limerick = Color(0xFF9DCC18);
  static const gullGrey = Color(0xFF9FA5C0);
  static const desertStorm = Color(0xFFF8F8F8);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  static Color getColorFromString(String name) {
    var color = int.parse(name.replaceAll('#', '0xFF'));
    return Color(color);
  }
}