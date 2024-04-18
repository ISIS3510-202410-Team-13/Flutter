import 'package:unischedule/constants/constants.dart';
import 'package:flutter/material.dart';

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme.copyWith(

    displayLarge: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: ColorConstants.white,
      shadows: [
        Shadow(
          offset: Offset(5, 4),
          blurRadius: 4,
          color: ColorConstants.black,
        ),
      ]
    ),

    titleMedium: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),

    headlineLarge: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 30,
      fontWeight: FontWeight.normal,
    ),

    headlineMedium: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),

    headlineSmall: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),

    bodyMedium: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 20,
    ),

    bodySmall: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 16,
    ),

  /*
  // TODO - Add your custom text styles here
  TextStyle? displayLarge,
  TextStyle? displayMedium,
  TextStyle? displaySmall,
  TextStyle? headlineLarge,
  TextStyle? headlineMedium,
  TextStyle? headlineSmall,
  TextStyle? titleLarge,
  TextStyle? titleMedium,
  TextStyle? titleSmall,
  TextStyle? bodyLarge,
  TextStyle? bodyMedium,
  TextStyle? bodySmall,
  TextStyle? labelLarge,
  TextStyle? labelMedium,
  TextStyle? labelSmall,
  TextStyle? subtitle1,
  TextStyle? subtitle2,
  TextStyle? button,
  TextStyle? overline,
 */
  );
}
