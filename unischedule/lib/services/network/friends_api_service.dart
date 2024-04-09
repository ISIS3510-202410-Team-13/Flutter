import 'package:dio/dio.dart';
import '../../../constants/http/http_constants.dart';

class FriendsApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: HTTPConstants.FRIENDS_BASE_URL));

  Future<List<dynamic>> fetchFriends(String userId) async {
    // Construye la URL completa
    final String url = 'user/$userId/friends';
    print('Making API call to: ${dio.options.baseUrl}$url');

    try {
      // Realiza la solicitud GET
      final response = await dio.get(url);
      return response.data;
    } on DioError catch (e) {
      // Imprime el error si ocurre uno
      print('DioError: ${e.response}');
      // Puedes lanzar una excepción o manejar el error como prefieras aquí
      rethrow;
    }
  }
}
