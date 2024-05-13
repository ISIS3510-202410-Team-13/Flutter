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

    displayMedium: TextStyle(
        fontFamily: StyleConstants.fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: ColorConstants.white,
        shadows: [
          Shadow(
            offset: const Offset(5, 4),
            blurRadius: 4,
            color: ColorConstants.black.withOpacity(0.5),
          ),
        ]
    ),

    displaySmall: null, // TODO: Add custom text styles here

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

    titleLarge: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),

    titleMedium: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),

    titleSmall: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

    bodyLarge: null, // TODO: Add custom text styles here

    bodyMedium: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 20,
    ),

    bodySmall: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 16,
    ),

    labelLarge: null, // TODO: Add custom text styles here

    labelMedium: null, // TODO: Add custom text styles here

    labelSmall: const TextStyle(
      fontFamily: StyleConstants.fontFamily,
      fontSize: 12,
    ),
  );
}
