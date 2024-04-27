import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/providers/providers.dart';

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
    ref.watch(connectivityStatusProvider);
    final userId = ref.watch(authenticationStatusProvider)?.uid;
    if (userId == null) {
      throw Exception(StringConstants.unauthorizedRequest);
    }
    List<GroupModel> groups = await client.getRequest('user/$userId/groups')
      .then((response) => response.map<GroupModel>((json) => GroupModel.fromJson(json)).toList())
      .then((groups) async {
        await boxService.clear();
        await boxService.putAll({ for (var group in groups) group.id : group });
        return groups;
      })
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