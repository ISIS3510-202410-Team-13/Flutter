import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/models.dart';

class FriendsStateNotifier extends StateNotifier<List<FriendModel>> {
  List<FriendModel> allFriends = [];

  FriendsStateNotifier(List<FriendModel> initialFriends) : super(initialFriends) {
    allFriends = initialFriends;
  }

  void setFriends(List<FriendModel> friends) {
    allFriends = friends;
    state = friends;
  }

  List<FriendModel> getFilteredFriends(String searchText) {
    if (searchText.isEmpty) {
      return allFriends;
    } else {
      return allFriends.where((friend) =>
          friend.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
}

final friendsStateNotifierProvider = StateNotifierProvider<FriendsStateNotifier, List<FriendModel>>((ref) {
  return FriendsStateNotifier([]);
});
