import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';

part 'groups_repository.g.dart';

abstract class GroupsRepository {
  // TODO add here all CRUD operations
  Future<List<GroupModel>> fetchGroups();
}

class GroupsRepositoryImpl extends GroupsRepository {

  final DioApiService client;
  final HiveBoxService<GroupModel> boxService;
  final Ref ref;

  GroupsRepositoryImpl({
    required this.ref,
    required this.client,
    required this.boxService,
  });

  @override
  Future<List<GroupModel>> fetchGroups() async {
    List<GroupModel> groups = await client.getRequest('user/0MebgXs8fBYREjDKMlwq/groups') // TODO change endpoint
      .then((response) => response.map<GroupModel>((json) => GroupModel.fromJson(json)).toList())
      .catchError((error) => boxService.getAll());
    return groups;
  }
}

@riverpod
GroupsRepositoryImpl groupsRepository(GroupsRepositoryRef ref) {
  return GroupsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.GROUPS_BASE_URL),
    boxService: HiveBoxServiceFactory.groupModelBox,
  );
}