import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:diatrack/models/login_response.dart';

class StorageService {
  StorageService._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _usernameKey = 'username';

  /// Save complete login response
  static Future<void> saveLogin(LoginResponse login) async {
    await _storage.write(
      key: _accessTokenKey,
      value: login.accessToken,
    );

    await _storage.write(
      key: _refreshTokenKey,
      value: login.refreshToken,
    );

    await _storage.write(
      key: _usernameKey,
      value: login.username,
    );
  }

  /// Save only access token
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(
      key: _accessTokenKey,
      value: token,
    );
  }

  /// Read access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Read refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Read username
  static Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  /// Is user logged in?
  static Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  /// Logout
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}