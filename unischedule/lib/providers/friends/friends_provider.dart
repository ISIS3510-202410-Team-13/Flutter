import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';
import '../connectivity/connectivity_provider.dart';


part 'friends_provider.g.dart';

// TODO add here all use cases as functions
@riverpod
Future<List<FriendModel>> fetchFriends(FetchFriendsRef ref) {
  ref.watch(connectivityStatusProvider);
  final friendsRepository = ref.watch(friendsRepositoryProvider);
  ref.keepAlive();

  return friendsRepository.fetchFriends();
}

@riverpod
FriendModel? getFriend(
    GetFriendRef ref, {
      required String friendId,
    }
) {
  final friend = ref.watch(fetchFriendsProvider).whenData(
    (value) => value.firstWhere((element) => element.id == friendId)
  );
  return friend.value;
}