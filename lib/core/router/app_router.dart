import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:diatrack/core/router/app_routes.dart';
import 'package:diatrack/features/auth/presentation/screens/login_screen.dart';
import 'package:diatrack/features/auth/presentation/screens/signup_screen.dart';
import 'package:diatrack/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:diatrack/features/home/presentation/screens/home_screen.dart';
import 'package:diatrack/features/patients/presentation/screens/patients_screen.dart';
import 'package:diatrack/features/ai_recommendation/presentation/screens/ai_input_screen.dart';
import 'package:diatrack/features/ai_recommendation/presentation/screens/ai_result_screen.dart';
import 'package:diatrack/features/profile/presentation/screens/profile_screen.dart';
import 'package:diatrack/features/navigation/presentation/screens/main_scaffold_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final email = (state.extra as String?) ?? '';
          return OtpVerificationScreen(email: email);
        },
      ),

      // AI Result Detail (Pushed on top of bottom navigation)
      GoRoute(
        path: AppRoutes.aiResult,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final result = (state.extra as Map<String, dynamic>?) ?? {};
          return AiResultScreen(result: result);
        },
      ),

      // Bottom Navigation Stateful Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffoldScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Branch 1: Patients
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.patients,
                builder: (context, state) => const PatientsScreen(),
              ),
            ],
          ),

          // Branch 2: AI Input
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.aiInput,
                builder: (context, state) => const AiInputScreen(),
              ),
            ],
          ),

          // Branch 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
