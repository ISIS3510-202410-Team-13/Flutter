import 'package:unischedule/constants/constants.dart';
import 'package:flutter/material.dart';
import 'slide_transition_builder.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: SlideTransitionBuilder(),
      TargetPlatform.iOS: SlideTransitionBuilder(),
    }),
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.limerick),
    textTheme: textTheme(context),
  );
}