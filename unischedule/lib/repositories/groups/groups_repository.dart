import 'package:hive/hive.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/network/dio_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'groups_repository.g.dart';

abstract class GroupsRepository {
  // TODO add here all use cases for groups
  Future<List<GroupModel>> fetchGroups();
}

class GroupsRepositoryImpl extends GroupsRepository {

  final DioApiService client;
  final Ref ref;

  GroupsRepositoryImpl({required this.ref, required this.client});

  @override
  Future<List<GroupModel>> fetchGroups() async {
    List<GroupModel> groups = [];
    try {
      groups = await client.getRequest("user/0MebgXs8fBYREjDKMlwq/groups")
          .then((response) { // TODO change endpoint
        return response.map<GroupModel>((json) => GroupModel.fromJson(json)).toList();
      });
    } catch (e) {
      final box = await Hive.openBox('groupBox'); // TODO change box name to constant
      groups = box.values.map((e) => e as GroupModel).toList();
    }
    return groups;
  }

  // TODO add onDispose method to save the state of the groups
}

@riverpod
GroupsRepositoryImpl groupsRepository(GroupsRepositoryRef ref) {
  return GroupsRepositoryImpl(ref: ref, client: DioApiServiceFactory.getService(HTTPConstants.GROUPS_BASE_URL));
}