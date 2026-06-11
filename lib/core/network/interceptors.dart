import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:nirvana_mobile/core/network/dio_client.dart';
import 'package:nirvana_mobile/core/storage/secure_storage.dart';

import '../../routes/app_routes.dart';

class AuthInterceptor extends Interceptor {
  bool _isRefreshing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      try {
        final refreshToken = await SecureStorage.getRefreshToken();
        if (refreshToken == null) {
          await _forceLogout();
          return handler.next(err);
        }

        final dio = Dio(BaseOptions(baseUrl: DioClient.dio.options.baseUrl));
        final response = await dio.post(
          'api/auth/refresh-token',
          data: {"refreshToken": refreshToken},
        );
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        await SecureStorage.setAccessToken(newAccessToken);
        await SecureStorage.setRefreshToken(newRefreshToken);

        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.fetch(retryOptions);

        return handler.resolve(retryResponse);
      } catch (e) {
        await _forceLogout();
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }
}

Future<void> _forceLogout() async {
  await SecureStorage.clearAll();
  Get.offAllNamed(AppRoutes.login);
}
