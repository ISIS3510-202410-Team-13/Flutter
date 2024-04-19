import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/services/network/dio_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'available_spaces_repository.g.dart';

abstract class AvailableSpacesRepository {
  // TODO add here all CRUD operations
  Future<List<AvailableSpacesModel>> fetchAvailableSpaces(String dayOfWeek, String startTime, String endTime);
}

class AvailableSpacesRepositoryImpl extends AvailableSpacesRepository {

  final DioApiService client;
  final Ref ref;

  AvailableSpacesRepositoryImpl({required this.ref, required this.client});

  @override
  Future<List<AvailableSpacesModel>> fetchAvailableSpaces(String dayOfWeek, String startTime, String endTime) async {
    final data = {'dayOfWeek': dayOfWeek, 'startTime': startTime, 'endTime': endTime};
    List<AvailableSpacesModel> availableSpaces = await client.postRequest(HTTPConstants.AVAILABLE_SPACES_ENDPOINT, data: data)
        .then((response) => response.map<AvailableSpacesModel>((json) => AvailableSpacesModel.fromJson(json)).toList())
        .catchError((error) => <AvailableSpacesModel>[]);
    return availableSpaces;
  }
}

@riverpod
AvailableSpacesRepositoryImpl availableSpacesRepository(AvailableSpacesRepositoryRef ref) {
  return AvailableSpacesRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.AVAILABLE_SPACES_BASE_URL),
  );
}