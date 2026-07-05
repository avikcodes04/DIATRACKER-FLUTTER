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
      throw Exception(error);
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
  Future<void> logout() async {
    await StorageService.clear();
  }
   Future<void> signup({
    required String username,
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await http.post(
      Uri.parse(Secrets.signup),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
        "name": name,
      }),
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return;
    }

    throw Exception(
      jsonResponse["message"] ??
          jsonResponse["detail"] ??
          jsonResponse["error"] ??
          "Signup failed",
    );
  }

  // ---------------- Confirm Signup ----------------

  Future<void> confirmSignup({
    required String email,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse(Secrets.confirm),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "otp": otp,
      }),
    );

    final jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return;
    }

    throw Exception(
      jsonResponse["message"] ??
          jsonResponse["detail"] ??
          jsonResponse["error"] ??
          "Confirmation failed",
    );
  }
}
