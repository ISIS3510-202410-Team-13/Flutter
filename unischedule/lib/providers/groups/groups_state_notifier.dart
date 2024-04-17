import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/models.dart';

class GroupsStateNotifier extends StateNotifier<List<GroupModel>> {
  List<GroupModel> allGroups = [];

  GroupsStateNotifier(List<GroupModel> initialGroups) : super(initialGroups) {
    allGroups = initialGroups;
  }

  void setGroups(List<GroupModel> groups) {
    allGroups = groups;
    state = groups;
  }

  List<GroupModel> getFilteredGroups(String searchText) {
    if (searchText.isEmpty) {
      return allGroups;
    } else {
      return allGroups.where((group) =>
          group.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
}

final groupsStateNotifierProvider = StateNotifierProvider<GroupsStateNotifier, List<GroupModel>>((ref) {
  return GroupsStateNotifier([]);
});
