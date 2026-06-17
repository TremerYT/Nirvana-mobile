import 'package:dio/dio.dart';
import 'package:nirvana_mobile/core/network/api_endpoints.dart';
import 'package:nirvana_mobile/core/network/dio_client.dart';
import 'package:nirvana_mobile/features/profile/models/user_model.dart';

class UserService {
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await DioClient.dio.get(ApiEndpoints.userProfile);
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch user profile",
      );
    }
  }

}
