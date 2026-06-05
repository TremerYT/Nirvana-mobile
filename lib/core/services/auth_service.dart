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

  Future<Response> login(String email, String password) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<Response> verifyOtp(String phone, String otp) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.verification,
        data: {"phone": phone, "verificationCode": otp},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Verification failed');
    }
  }
}
