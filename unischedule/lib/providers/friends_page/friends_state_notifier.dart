import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/friends_page/friend_model.dart';

class FriendsStateNotifier extends StateNotifier<List<Friend>> {
  List<Friend> allFriends = [];

  FriendsStateNotifier(List<Friend> initialFriends) : super(initialFriends) {
    allFriends = initialFriends;
  }

  void filterFriends(String searchText) {
    if (searchText.isEmpty) {
      state = allFriends;
    } else {
      state = allFriends.where((friend) =>
        friend.name.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }

  void setFriends(List<Friend> friends) {
    allFriends = friends;
    state = friends;
  }
}

final friendsStateNotifierProvider = StateNotifierProvider<FriendsStateNotifier, List<Friend>>((ref) {
  return FriendsStateNotifier([]);
});
