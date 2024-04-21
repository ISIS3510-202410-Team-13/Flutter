import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/providers/providers.dart';

part 'friends_repository.g.dart';

abstract class FriendsRepository {
  // TODO add here all CRUD operations
  Future<List<FriendModel>> fetchFriends();
}

class FriendsRepositoryImpl extends FriendsRepository {

  final DioApiService client;
  final HiveBoxService<FriendModel> boxService;
  final Ref ref;

  FriendsRepositoryImpl({
    required this.ref,
    required this.client,
    required this.boxService,
  });

  @override
  Future<List<FriendModel>> fetchFriends() async {
    final userId = ref.watch(authenticationStatusProvider)?.uid;
    if (userId == null) {
      throw Exception(StringConstants.unauthorizedRequest);
    }
    List<FriendModel> friends = await client.getRequest('user/$userId/friends')
      .then((response) => response.map<FriendModel>((json) => FriendModel.fromJson(json)).toList())
      .then((friends) async {
        await boxService.clear();
        await boxService.putAll({ for (var friend in friends) friend.id : friend });
        return friends;
      })
      .catchError((error) => boxService.getAll());
    return friends;
  }
}

@riverpod
FriendsRepositoryImpl friendsRepository(FriendsRepositoryRef ref) {
  return FriendsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.FRIENDS_BASE_URL),
    boxService: HiveBoxServiceFactory.friendModelBox,
  );
}