import 'package:unischedule/models/friends_page/friend_model.dart';
import 'package:unischedule/services/network/friends_api_service.dart';

class FriendsRepository {
  final FriendsApiService _apiService;

  FriendsRepository(this._apiService);

  Future<List<Friend>> getFriends(String userId) async {
    final data = await _apiService.fetchFriends(userId);
    return data.map<Friend>((json) => Friend.fromJson(json)).toList();
  }
}
