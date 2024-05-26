import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';


part 'groups_provider.g.dart';

// TODO add here all use cases as functions
@riverpod
Future<List<GroupModel>> fetchGroups(FetchGroupsRef ref) {
  final groupsRepository = ref.watch(groupsRepositoryProvider);
  ref.keepAlive();

  return groupsRepository.fetchGroups();
}

@riverpod
Future<void> addGroup(
    AddGroupRef ref, {
      required GroupModel group,
    }
){
  final groupsRepository = ref.watch(groupsRepositoryProvider);
  ref.keepAlive();

  return groupsRepository.addGroup(group)
      .then((_) => ref.refresh(fetchGroupsProvider));
}