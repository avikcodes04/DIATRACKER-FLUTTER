import 'dart:convert';

import 'package:diatrack/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:diatrack/config/secrets.dart';
import 'package:diatrack/services/storage_service.dart';

class AuthService {
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(Secrets.login),
        headers: {
          "Content-Type": "application/json",
          "X-Auth-Mode":"token",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      print('Login response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonResponse);
        return loginResponse;
      }

      final jsonResponse = jsonDecode(response.body);
      final error = jsonResponse["error"] as String;
      throw Exception("Login failed: $error");
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
  final accessToken = await StorageService.getAccessToken();

  if (accessToken == null) {
    throw Exception("User is not logged in");
  }

  final response = await http.get(
    Uri.parse(Secrets.me),
    headers: {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception("Failed to fetch user");
}
}
