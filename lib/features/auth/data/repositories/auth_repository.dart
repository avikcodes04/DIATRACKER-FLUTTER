import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/core/constants/api_endpoints.dart';
import 'package:diatrack/core/network/api_client.dart';
import 'package:diatrack/core/storage/storage_service.dart';
import 'package:diatrack/features/auth/data/models/login_response.dart';
import 'package:diatrack/features/auth/data/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storageService = ref.watch(storageServiceProvider);
  return AuthRepository(apiClient, storageService);
});

class AuthRepository {
  final ApiClient _apiClient;
  final StorageService _storageService;

  AuthRepository(this._apiClient, this._storageService);

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.login,
      headers: {
        'X-Auth-Mode': 'token',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    final loginResponse = LoginResponse.fromJson(response as Map<String, dynamic>);
    await _storageService.saveLogin(loginResponse);
    return loginResponse;
  }

  Future<void> signup({
    required String username,
    required String email,
    required String password,
    required String name,
  }) async {
    await _apiClient.post(
      ApiEndpoints.signup,
      body: {
        'username': username,
        'email': email,
        'password': password,
        'name': name,
      },
    );
  }

  Future<void> confirmSignup({
    required String email,
    required String otp,
  }) async {
    await _apiClient.post(
      ApiEndpoints.confirm,
      body: {
        'email': email,
        'otp': otp,
      },
    );
  }

  Future<UserModel> getCurrentUser() async {
    final response = await _apiClient.get(
      ApiEndpoints.me,
      requiresAuth: true,
    );

    return UserModel.fromJson(response as Map<String, dynamic>);
  }

  Future<bool> isLoggedIn() async {
    return await _storageService.isLoggedIn();
  }

  Future<void> logout() async {
    await _storageService.clear();
  }
}
