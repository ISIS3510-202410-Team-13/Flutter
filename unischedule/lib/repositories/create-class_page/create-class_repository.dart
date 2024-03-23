import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/create-class_page/create-class_model.dart';
import '../../../services/network/available-spaces_api_service.dart';

part 'create-class_repository.g.dart';

abstract class AvailableSpacesRepository {
  Future<List<AvailableSpacesResponseModel>> fetchAvailableSpaces(AvailableSpacesRequestModel request);
}

class AvailableSpacesRepositoryImpl extends AvailableSpacesRepository {
  final AvailableSpacesApiService client;

  AvailableSpacesRepositoryImpl({required this.client});

  @override
  Future<List<AvailableSpacesResponseModel>> fetchAvailableSpaces(AvailableSpacesRequestModel request) async {
    var response = await client.getRequest('', request.toJson());
    if (response is List<dynamic>) {
      // Convert each dynamic element to AvailableSpacesResponseModel
      return response.map((e) => AvailableSpacesResponseModel.fromJson(e)).toList();
    } else {
      // Handle the case where the response is not a list
      throw Exception('Unexpected response format');
    }
  }
}

@riverpod
AvailableSpacesRepositoryImpl availableSpacesRepository(AvailableSpacesRepositoryRef ref) {
  return AvailableSpacesRepositoryImpl(client: AvailableSpacesApiService());
}