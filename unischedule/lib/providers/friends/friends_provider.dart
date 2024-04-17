import 'package:unischedule/models/models.dart';
import 'package:unischedule/repositories/repositories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'friends_provider.g.dart';

@riverpod
Future<List<FriendModel>> fetchFriends(FetchFriendsRef ref) {
  final friendsRepository = ref.watch(friendsRepositoryProvider);
  ref.keepAlive();

  return friendsRepository.fetchFriends();
}