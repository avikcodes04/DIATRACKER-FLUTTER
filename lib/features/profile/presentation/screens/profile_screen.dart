import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';
import 'package:diatrack/core/router/app_routes.dart';
import 'package:diatrack/features/auth/presentation/controllers/auth_controller.dart';
import 'package:diatrack/features/profile/presentation/widgets/profile_action_tile.dart';
import 'package:diatrack/features/profile/presentation/widgets/profile_info_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    final name = user?.name.isNotEmpty == true ? user!.name : "Dr. Sarah Jenkins";
    final email = user?.email.isNotEmpty == true ? user!.email : "doctor@diatrack.com";
    final role = user?.role ?? "Chief Nephrologist";
    final hospital = user?.hospital ?? "City Kidney Care Center";
    final phone = user?.phone ?? "+91 98765 43210";

    return Scaffold(
      backgroundColor: AppColors.newAccentColor,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.comfortaa(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.newTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.accentColor.withValues(alpha: 0.15),
              child: const Icon(
                Icons.person,
                size: 50,
                color: AppColors.accentColor,
              ),
            ),
            const SizedBox(height: 12),

            // Name & Role
            Text(
              name,
              style: GoogleFonts.comfortaa(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainFontColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              role,
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Info Tiles
            ProfileInfoTile(
              icon: Icons.email_outlined,
              label: "Email",
              value: email,
            ),
            ProfileInfoTile(
              icon: Icons.phone_outlined,
              label: "Phone",
              value: phone,
            ),
            ProfileInfoTile(
              icon: Icons.local_hospital_outlined,
              label: "Hospital",
              value: hospital,
            ),
            const ProfileInfoTile(
              icon: Icons.badge_outlined,
              label: "License No.",
              value: "MCI-2024-8841",
            ),

            const Divider(),
            const SizedBox(height: 8),

            // Actions
            ProfileActionTile(
              icon: Icons.edit_outlined,
              label: "Edit Profile",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile editing is disabled in demo mode")),
                );
              },
            ),
            ProfileActionTile(
              icon: Icons.lock_outline,
              label: "Change Password",
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password change is disabled in demo mode")),
                );
              },
            ),
            ProfileActionTile(
              icon: Icons.logout,
              label: "Logout",
              color: Colors.red,
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to sign out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await ref.read(authControllerProvider.notifier).logout();
                  if (context.mounted) {
                    context.go(AppRoutes.login);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
