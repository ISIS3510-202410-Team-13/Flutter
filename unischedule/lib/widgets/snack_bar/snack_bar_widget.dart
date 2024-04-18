import 'package:unischedule/constants/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: ColorConstants.cloudyGrey,
        fontSize: 14,
      ),
    ),
    backgroundColor: ColorConstants.desertStorm,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: ColorConstants.limerick, width: 1.0)
    ),
    elevation: 0.0,
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}