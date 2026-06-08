import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = "accessToken";

  static Future<void> setAccessToken(String token) async {
    await _storage.write(key: "accessToken", value: token);
  }

  static Future<void> setRefreshToken(String token) async {
    await _storage.write(key: "refreshToken", value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
