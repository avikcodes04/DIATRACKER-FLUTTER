import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pallete.dart';
import '../widgets/profile_page_widgets/profile_action_tile.dart';
import '../widgets/profile_page_widgets/profile_info_tile.dart';
import "../pages/loginpage.dart";
import 'package:supabase_flutter/supabase_flutter.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
  final user = _authService.currentUser();

  setState(() {
    _user = user;
    _isLoading = false;
  });
}
    
  
  Future<void> _logout() async {
  await _authService.logout();

  if (!mounted) return;

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
    (route) => false,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.comfortaa(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Pallete.accentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // ── Avatar ─────────────────────────────────────────
            CircleAvatar(
              radius: 50,
              backgroundColor: Pallete.accentColor.withOpacity(0.15),
              child: Icon(
                Icons.person,
                size: 50,
                color: Pallete.accentColor,
              ),
            ),
            const SizedBox(height: 12),

            // ── Name & Role ────────────────────────────────────
            Text(
               _user?.email ?? "Loading...",
              style: GoogleFonts.comfortaa(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Nephrologist",
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),

            // ── Info Tiles ─────────────────────────────────────
            ProfileInfoTile(
              icon: Icons.email_outlined,
              label: "Email",
              value: _user?.email ?? "Loading...",
            ),
            ProfileInfoTile(
              icon: Icons.phone_outlined,
              label: "Phone",
              value: "+91 98765 43210",
            ),
            ProfileInfoTile(
              icon: Icons.local_hospital_outlined,
              label: "Hospital",
              value: "City Kidney Care Center",
            ),
            ProfileInfoTile(
              icon: Icons.badge_outlined,
              label: "License No.",
              value: "MCI-2024-XXXX",
            ),

            const Divider(),
            const SizedBox(height: 8),

            // ── Actions ────────────────────────────────────────
            ProfileActionTile(
              icon: Icons.edit_outlined,
              label: "Edit Profile",
              onTap: () {},
            ),
            ProfileActionTile(
              icon: Icons.lock_outline,
              label: "Change Password",
              onTap: () {},
            ),
            ProfileActionTile(
              icon: Icons.logout,
              label: "Logout",
              onTap: _logout,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}