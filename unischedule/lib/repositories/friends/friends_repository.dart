import 'package:unischedule/models/models.dart';
import 'package:unischedule/services/network/friends_api_service.dart';

class FriendsRepository {
  final FriendsApiService _apiService;

  FriendsRepository(this._apiService);

Future<List<Friend>> getFriends(String userId, [String? query]) async {
  final data = await _apiService.fetchFriends(userId);
  var friends = data.map<Friend>((json) => Friend.fromJson(json)).toList();
  
  // Filtra los amigos si se proporciona una consulta de búsqueda
  if (query != null && query.isNotEmpty) {
    friends = friends.where((friend) => friend.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
  
  return friends;
}
}
