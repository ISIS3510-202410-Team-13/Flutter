import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/network/dio_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friends_repository.g.dart';

abstract class FriendsRepository {
  // TODO add here all use cases for friends
  Future<List<FriendModel>> fetchFriends();
}

class FriendsRepositoryImpl extends FriendsRepository {

  final DioApiService client;
  final Ref ref;

  FriendsRepositoryImpl({required this.ref, required this.client});

  @override
  Future<List<FriendModel>> fetchFriends() {
    return client.getRequest("user/0MebgXs8fBYREjDKMlwq/friends").then((response) { // TODO change endpoint
      return response.map<FriendModel>((json) => FriendModel.fromJson(json)).toList();
    });
  }

// TODO add onDispose method to save the state of the friends
}

@riverpod
FriendsRepositoryImpl friendsRepository(FriendsRepositoryRef ref) {
  return FriendsRepositoryImpl(ref: ref, client: DioApiServiceFactory.getService(HTTPConstants.FRIENDS_BASE_URL));
}