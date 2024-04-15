import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/friends_page/friend_model.dart';

class FriendsStateNotifier extends StateNotifier<List<Friend>> {
  List<Friend> allFriends = [];

  FriendsStateNotifier(List<Friend> initialFriends) : super(initialFriends) {
    allFriends = initialFriends;
  }

  void setFriends(List<Friend> friends) {
    allFriends = friends;
    state = friends;
  }

  List<Friend> getFilteredFriends(String searchText) {
    if (searchText.isEmpty) {
      return allFriends;
    } else {
      return allFriends.where((friend) =>
          friend.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
}

final friendsStateNotifierProvider = StateNotifierProvider<FriendsStateNotifier, List<Friend>>((ref) {
  return FriendsStateNotifier([]);
});
