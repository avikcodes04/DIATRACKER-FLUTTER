import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<void> sendOtp(String email) async {
    await _supabase.auth.signInWithOtp(
      email: email,
    );
  }

  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await _supabase.auth.verifyOTP(
      email: email,
      token: otp,
      type: OtpType.email,
    );
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  User? currentUser() {
    return _supabase.auth.currentUser;
  }
}