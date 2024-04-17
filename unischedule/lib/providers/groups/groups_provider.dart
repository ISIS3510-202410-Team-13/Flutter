import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/groups/groups_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'groups_provider.g.dart';

@riverpod
Future<List<GroupModel>> fetchGroups(FetchGroupsRef ref) {
  final groupsRepository = ref.watch(groupsRepositoryProvider);
  ref.keepAlive();

  return groupsRepository.fetchGroups();
}
