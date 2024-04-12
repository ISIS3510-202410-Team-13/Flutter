import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/groups_page/group_model.dart';

class GroupsStateNotifier extends StateNotifier<List<Group>> {
  List<Group> allGroups = [];

  GroupsStateNotifier(List<Group> initialGroups) : super(initialGroups) {
    allGroups = initialGroups;
  }

  void filterGroups(String searchText) {
    if (searchText.isEmpty) {
      state = allGroups;
    } else {
      state = allGroups.where((group) =>
        group.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
}

final groupsStateNotifierProvider = StateNotifierProvider<GroupsStateNotifier, List<Group>>((ref) {
  return GroupsStateNotifier([]);
});
