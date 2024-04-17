import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';

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
  (ref) => AvailableSpacesParamsModel(),
);

class AvailableSpacesParamsModel {
  final String dayOfWeek;
  final String startTime;
  final String endTime;

  AvailableSpacesParamsModel({
    this.dayOfWeek = '',
    this.startTime = '',
    this.endTime = ''
  });
}