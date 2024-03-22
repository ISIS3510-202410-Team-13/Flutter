import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/create-class_page/create-class_model.dart';
import '../../../repositories/create-class_page/create-class_repository.dart';

part 'create-class_provider.g.dart';

@riverpod
Future<List<AvailableSpacesResponseModel>> availableSpaces(ref) async {
  final availableSpacesRepository = ref.watch(availableSpacesRepositoryProvider);
  final availableSpacesParams = ref.watch(availableSpacesParamsProvider);

  return availableSpacesRepository.fetchAvailableSpaces(availableSpacesParams.toRequestModel());
}

final availableSpacesParamsProvider = StateProvider<AvailableSpacesParamsModel>(
      (ref) => AvailableSpacesParamsModel("Monday", const TimeOfDay(hour: 8, minute: 0), 60), // FIXME - Change default values
);

class AvailableSpacesParamsModel {
  final String dayOfWeek;
  final TimeOfDay startTime;
  final int duration;

  AvailableSpacesParamsModel(this.dayOfWeek, this.startTime, this.duration);

  AvailableSpacesRequestModel toRequestModel() {
    return AvailableSpacesRequestModel(
      dayOfWeek: dayOfWeekMap[dayOfWeek] ?? 'l',  // FIXME - Define interface for these literal values and prevent anything other than the expected values
      startTime: timeOfDayToString(startTime),
      endTime: timeOfDayToString(addMinutes(startTime, duration)),
    );
  }

  Map<String, String> dayOfWeekMap = {
    'Monday': 'l',
    'Tuesday': 'm',
    'Wednesday': 'i',
    'Thursday': 'j',
    'Friday': 'v',
    'Saturday': 's',
    'Sunday': 'd',
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
}
