import 'package:dio/dio.dart';
import 'package:nirvana_mobile/core/network/api_endpoints.dart';
import 'package:nirvana_mobile/core/network/dio_client.dart';

class AuthService {
  Future<Response> register(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.register,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }

  Future<Response> login(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.login,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<Response> verifyOtp(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.verification,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Verification failed');
    }
  }

  Future<Response> forgotPassword(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.forgotPassword,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Failed to send email for password reset',
      );
    }
  }
}
