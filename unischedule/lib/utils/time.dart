import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';

Map<String, String> dayOfWeekMap = {
  'Monday': TypeConstants.monday,
  'Tuesday': TypeConstants.tuesday,
  'Wednesday': TypeConstants.wednesday,
  'Thursday': TypeConstants.thursday,
  'Friday': TypeConstants.friday,
  'Saturday': TypeConstants.saturday,
  'Sunday': TypeConstants.sunday,
};

TimeOfDay addMinutes(TimeOfDay time, int minutes) {
  int newMinutes = time.minute + minutes;
  int newHour = time.hour + newMinutes ~/ 60;
  newMinutes = newMinutes % 60;
  if (newHour >= 24) {
    return const TimeOfDay(hour: 23, minute: 59);
  } else {
    return TimeOfDay(hour: newHour, minute: newMinutes);
  }
}

String timeOfDayToString(TimeOfDay time) {
  return '${time.hour.toString().padLeft(2, '0')}${time.minute.toString().padLeft(2, '0')}';
}