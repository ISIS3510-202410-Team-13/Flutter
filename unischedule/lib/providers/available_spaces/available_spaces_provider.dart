import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';
import 'package:unischedule/utils/time.dart';

part 'available_spaces_provider.g.dart';

@riverpod
Future<List<AvailableSpacesModel>> fetchAvailableSpaces(FetchAvailableSpacesRef ref) async {
  final availableSpacesRepository = ref.watch(availableSpacesRepositoryProvider);
  final availableSpacesParams = ref.watch(availableSpacesParamsProvider);

  return availableSpacesRepository.fetchAvailableSpaces(
    availableSpacesParams.dayOfWeek,
    availableSpacesParams.startTime,
    availableSpacesParams.endTime,
  );
}

final availableSpacesParamsProvider = StateProvider<AvailableSpacesParamsModel>(
  (ref) => AvailableSpacesParamsModel(start: DateTime.now(), duration: const Duration(hours: 1)),
);

class AvailableSpacesParamsModel {
  late final DateTime start;
  late final Duration duration;

  AvailableSpacesParamsModel({
    required this.start,
    required this.duration,
  });

  String get dayOfWeek => dayOfWeekId[start.weekday]!;
  String get startTime => DateFormat('Hm').format(start).replaceAll(':', '');
  String get endTime => DateFormat('Hm').format(addMinutesUntilMidnight(start, duration)).replaceAll(':', '');
}