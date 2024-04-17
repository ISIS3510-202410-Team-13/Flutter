import 'package:flutter/material.dart';

class ColorConstants {


  // TODO replace the color constants with the colors you want to use in your app
/*  static const black = Colors.black;
  static const greyIsTheNewBlack = Color(0xFF1C1C1E);
  static const greyIsTheNewGrey = Color(0xFF2C2C2E);
  static const transparent = Color(0x00ffffff);
  static const walterWhite = Colors.white;
  static const softGrey = Color(0xff424345);
  static const quiteGrey = Color(0xffD5D3D1);
  static const lightPurple = Color(0xff917DF0);
  static const onyx = Color(0xff2A2A32);
  static const ebony = Color(0xff171718);
  static const graphite = Color(0xffAAAAAA);
  static const charcoal = Color(0xff303031);
  static const amsterdamSummer = Color(0xff211F26);
  static const amsterdamSpring = Color(0xff2A2A32);
  static const nearWhite = Color(0xffFEFEFE);*/

  static const limerick = Color(0xFF9DCC18);

  static Color getColorFromString(String? name) {
    if (name == null) {
      return ColorConstants.limerick;
    }

    var color = int.parse(name.replaceAll('#', '0xff'));

    return Color(color);
  }
}