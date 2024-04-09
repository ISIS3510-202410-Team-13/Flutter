import 'package:unischedule/models/groups_page/group_model.dart';
import 'package:unischedule/services/network/groups_api_service.dart';

class GroupsRepository {
  final GroupsApiService _apiService;

  GroupsRepository(this._apiService);

  Future<List<Group>> getGroups(String userId) async {
    final data = await _apiService.fetchGroups(userId);
    return data.map<Group>((json) => Group.fromJson(json)).toList();
  }
}
