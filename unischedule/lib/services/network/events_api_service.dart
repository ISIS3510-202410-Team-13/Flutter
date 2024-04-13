import 'package:dio/dio.dart';
import '../../../constants/http/http_constants.dart';

class EventsApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: HTTPConstants.EVENTS_BASE_URL));

  Future<List<dynamic>> fetchEvents(String userId) async {
    final String url = 'user/$userId/events';
    print('Making API call to: ${dio.options.baseUrl}$url');

    try {
      final response = await dio.get(url);
      return response.data;
    } on DioError catch (e) {
      print('DioError: ${e.response}');
      rethrow;
    }
  }
}
