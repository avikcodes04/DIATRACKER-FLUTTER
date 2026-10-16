import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/features/auth/data/models/user_model.dart';
import 'package:diatrack/features/auth/data/repositories/auth_repository.dart';

class AuthState {
  final bool isInitialLoading;
  final bool isAuthenticated;
  final bool isLoading;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.isInitialLoading = true,
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isInitialLoading,
    bool? isAuthenticated,
    bool? isLoading,
    UserModel? user,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final authControllerProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    Future.microtask(() => checkAuthStatus());
    return const AuthState();
  }

  Future<void> checkAuthStatus() async {
    try {
      final loggedIn = await _authRepository.isLoggedIn();
      if (loggedIn) {
        try {
          final user = await _authRepository.getCurrentUser();
          state = state.copyWith(
            isInitialLoading: false,
            isAuthenticated: true,
            user: user,
          );
          return;
        } catch (_) {
          state = state.copyWith(
            isInitialLoading: false,
            isAuthenticated: true,
          );
          return;
        }
      }
    } catch (_) {}

    state = state.copyWith(
      isInitialLoading: false,
      isAuthenticated: false,
    );
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _authRepository.login(email: email, password: password);
      UserModel? user;
      try {
        user = await _authRepository.getCurrentUser();
      } catch (_) {}

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Bypass login for demo/testing when server is offline
  void bypassLoginForDemo() {
    state = state.copyWith(
      isAuthenticated: true,
      user: const UserModel(
        username: 'demo_doctor',
        email: 'doctor@diatrack.com',
        name: 'Dr. Sarah Jenkins',
        role: 'Chief Nephrologist',
      ),
    );
  }

  Future<bool> signup({
    required String username,
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _authRepository.signup(
        username: username,
        email: email,
        password: password,
        name: name,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> confirmSignup({required String email, required String otp}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _authRepository.confirmSignup(email: email, otp: otp);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.logout();
    } catch (_) {}
    state = const AuthState(
      isInitialLoading: false,
      isAuthenticated: false,
    );
  }
}
