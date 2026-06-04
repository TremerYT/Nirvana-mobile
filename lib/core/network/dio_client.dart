import 'package:dio/dio.dart';

import 'interceptors.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions (
      baseUrl: "http://127.0.0.1/api",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      }
    )
  )..interceptors.add(AuthInterceptor());
}