import 'package:dio/dio.dart';
import 'package:nirvana_mobile/core/network/api_endpoints.dart';
import 'package:nirvana_mobile/core/network/dio_client.dart';
import 'package:nirvana_mobile/features/business/models/business_model.dart';

class BusinessService {
  Future<BusinessModel> getBusinessById(int id) async {
    try {
      final response = await DioClient.dio.get(
        '${ApiEndpoints.businessById}/$id',
      );
      return BusinessModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch business',
      );
    }
  }

  Future<List<BusinessModel>> getFeaturedBusinesses({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.featuredBusinesses,
        queryParameters: {"page": page, "size": size},
      );
      return (response.data["content"] as List)
          .map((e) => BusinessModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch featured businesses",
      );
    }
  }

  Future<List<BusinessModel>> getBusinessBySearch({
    String query = "",
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.businessBySearch,
        queryParameters: {"q": query, "page": page, "size": size},
      );
      return (response.data["content"] as List)
          .map((e) => BusinessModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch business",
      );
    }
  }

  Future<List<BusinessModel>> getBusinesses({
    String type = "",
    int page = 0,
    int size = 10,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.businessByCategory,
        queryParameters: {"type": type, "page": page, "size": size},
      );
      return (response.data["content"] as List)
          .map((e) => BusinessModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to fetch business",
      );
    }
  }

  Future<bool> followBusiness(int id) async {
    try {
      final response = await DioClient.dio.post(
        '${ApiEndpoints.businessById}/$id/toggle-follow',
      );
      return response.data["success"];
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Failed to follow business",
      );
    }
  }
}
