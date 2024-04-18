import 'package:unischedule/constants/constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.limerick),
    textTheme: textTheme(context),
  );
}