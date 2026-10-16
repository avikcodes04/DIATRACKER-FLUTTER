import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:diatrack/features/auth/data/models/login_response.dart';

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

class StorageService {
  final FlutterSecureStorage _storage;

  StorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const FlutterSecureStorage _staticStorage = FlutterSecureStorage();

  // Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _usernameKey = 'username';

  /// Save complete login response
  Future<void> saveLogin(LoginResponse login) async {
    await _storage.write(key: _accessTokenKey, value: login.accessToken);
    await _storage.write(key: _refreshTokenKey, value: login.refreshToken);
    await _storage.write(key: _usernameKey, value: login.username);
  }

  /// Save only access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Read access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Read refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Read username
  Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  /// Is user logged in?
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all stored auth data
  Future<void> clear() async {
    await _storage.deleteAll();
  }

  // Static backward compatibility helpers
  static Future<void> saveLoginStatic(LoginResponse login) =>
      _staticStorage.write(key: _accessTokenKey, value: login.accessToken)
          .then((_) => _staticStorage.write(key: _refreshTokenKey, value: login.refreshToken))
          .then((_) => _staticStorage.write(key: _usernameKey, value: login.username));

  static Future<void> saveAccessTokenStatic(String token) =>
      _staticStorage.write(key: _accessTokenKey, value: token);

  static Future<String?> getAccessTokenStatic() =>
      _staticStorage.read(key: _accessTokenKey);

  static Future<String?> getRefreshTokenStatic() =>
      _staticStorage.read(key: _refreshTokenKey);

  static Future<String?> getUsernameStatic() =>
      _staticStorage.read(key: _usernameKey);

  static Future<bool> isLoggedInStatic() async {
    final token = await getAccessTokenStatic();
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearStatic() => _staticStorage.deleteAll();
}
