import 'package:unischedule/constants/constants.dart';

Map<int, String> dayOfWeekId = {
  1: TypeConstants.monday,
  2: TypeConstants.tuesday,
  3: TypeConstants.wednesday,
  4: TypeConstants.thursday,
  5: TypeConstants.friday,
  6: TypeConstants.saturday,
  7: TypeConstants.sunday,
};

DateTime addMinutesUntilMidnight(DateTime time, Duration duration) {
  if (time.add(duration).day != time.day) {
    return DateTime(time.year, time.month, time.day, 23, 59);
  }
  return time.add(duration);
}