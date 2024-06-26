import 'dart:io';
import 'package:unischedule/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// TODO implement these keys in the backend
const _errorKey = 'error';
const _messageKey = 'message';

class DioApiServiceFactory {
  static final Map<String, DioApiService> _services = {};

  static DioApiService getService(String baseUrl) {
    if (!_services.containsKey(baseUrl)) {
      _services[baseUrl] = DioApiService(baseUrl);
    }
    return _services[baseUrl]!;
  }
}

class DioApiService {

  final String baseUrl;
  late Dio dio;

  DioApiService(this.baseUrl) {
    dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 30000),
      baseUrl: baseUrl,
    );
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ));
    }
    dio.interceptors.add(
      InterceptorsWrapper(onError: (e, handler) => _onError(e, handler)),
    );
  }

  void _setToken(String? userToken) {
    if (userToken != null && userToken.isNotEmpty) {
      dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer $userToken';
    }
  }

  Future<void> _onError(
      DioException err,
      ErrorInterceptorHandler handler,
    ) async {
    await _captureException(err);
    handler.reject(err);
  }

  Future<void> _captureException(
      DioException err,
      ) async {
    // TODO replace with crashlytics
/*    await Sentry.captureException(
      {
        'error': err.toString(),
        'endpoint': err.requestOptions.path.toString(),
        'response': err.response.toString(),
        'serverMessage': err.message.toString(),
      },
      stackTrace: err.stackTrace,
    );*/
  }

  Future<dynamic> getRequest(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  Future<dynamic> postRequest(
      String uri, {
        String? userToken,
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    _setToken(userToken);
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  Future<dynamic> deleteRequest(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on DioException catch (err) {
      _returnDioErrorResponse(err);
    }
  }

  CustomException _returnDioErrorResponse(DioException error) {
    var data = error.response?.data;
    String? message;
    if (data is! String) {
      message = data?[_errorKey] ?? data?[_messageKey];
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      throw FetchDataException(
        error.response?.statusCode,
        StringConstants.connectionTimeout,
      );
    }
    switch (error.response?.statusCode) {
      // TODO Customize with backend error codes
      case 400:
        throw BadRequestException(
          error.response?.statusCode,
          StringConstants.badRequest,
        );
      case 401:
        throw UnauthorizedException(
          error.response?.statusCode,
          StringConstants.unauthorizedRequest,
        );
      case 403:
        throw UnauthorizedException(
          error.response?.statusCode,
          StringConstants.accessForbidden,
        );
      case 404:
        throw FetchDataException(
          error.response?.statusCode,
          message ?? StringConstants.anErrorOccurred,
        );
      case 500:
      default:
        throw FetchDataException(
          error.response?.statusCode ?? 500,
          StringConstants.anErrorOccurred,
        );
    }
  }
}

class CustomException implements Exception {
  final int? statusCode;
  final String? message;

  CustomException([this.statusCode, this.message]);

  @override
  String toString() {
    return '$message${statusCode != null ? ': $statusCode' : ''}';
  }
}

class FetchDataException extends CustomException {
  FetchDataException([super.statusCode, super.message]);
}

class BadRequestException extends CustomException {
  BadRequestException([super.statusCode, super.message]);
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([super.statusCode, super.message]);
}

class InvalidInputException extends CustomException {
  InvalidInputException([super.statusCode, super.message]);
}