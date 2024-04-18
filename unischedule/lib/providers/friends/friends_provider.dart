import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';


part 'friends_provider.g.dart';

// TODO add here all use cases as functions
@riverpod
Future<List<FriendModel>> fetchFriends(FetchFriendsRef ref) {
  final friendsRepository = ref.watch(friendsRepositoryProvider);
  ref.keepAlive();

  return friendsRepository.fetchFriends();
}