import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../constants/http/http_constants.dart';

class AvailableSpacesApiService {

  static final AvailableSpacesApiService _instance = AvailableSpacesApiService._internal();
  late Dio dio;

  factory AvailableSpacesApiService() {
    return _instance;
  }

  // Private constructor
  AvailableSpacesApiService._internal() {
    dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      baseUrl: HTTPConstants.AVAILABLE_SPACES_BASE_URL,
    );
    // Add logging (debug)
    dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ));
    dio.interceptors.add(
      InterceptorsWrapper(onError: (e, handler) => _onError(e, handler)),
    );
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler
  ) async {
    await _captureException(err);
    handler.reject(err);
  }

  Future<void> _captureException(
      DioException err,
      ) async {
    await Sentry.captureException(
      {
        'error': err.toString(),
        'endpoint': err.requestOptions.path.toString(),
        'response': err.response.toString(),
        'serverMessage': err.message.toString(),
      },
      stackTrace: err.stackTrace,
    );
  }

  Future<dynamic> getRequest(String uri, Map<String, dynamic> body) async {
    try {
      var response = await dio.post(uri, data: body);

      return response.data;
    } on DioException catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

}
