import 'package:dio/dio.dart';

import 'interceptors.dart';

class DioClient {
  static const _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.2.1.115:8080',
  );

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  )..interceptors.add(AuthInterceptor());
}
