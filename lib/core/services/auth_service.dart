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
      final response = await DioClient.dio.post(ApiEndpoints.login, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<Response> requestOtp(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.requestOtp,
          data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'OTP request failed');
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

  Future<Response> resetPassword(Map<String, dynamic> data) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.resetPassword,
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Password reset failed');
    }
  }
}
