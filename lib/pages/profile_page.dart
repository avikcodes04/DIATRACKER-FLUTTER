import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pallete.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
              "Dr. John Doe",
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
            _infoTile(Icons.email_outlined, "Email", "johndoe@hospital.com"),
            _infoTile(Icons.phone_outlined, "Phone", "+91 98765 43210"),
            _infoTile(Icons.local_hospital_outlined, "Hospital", "City Kidney Care Center"),
            _infoTile(Icons.badge_outlined, "License No.", "MCI-2024-XXXX"),

            const Divider(),
            const SizedBox(height: 8),

            // ── Actions ────────────────────────────────────────
            _actionTile(Icons.edit_outlined, "Edit Profile", () {}),
            _actionTile(Icons.lock_outline, "Change Password", () {}),
            _actionTile(Icons.logout, "Logout", () {}, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Row(
        children: [
          Icon(icon, color: Pallete.accentColor, size: 22),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String label, VoidCallback onTap,
      {Color color = Colors.black87}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Icon(icon, color: color),
      title: Text(label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: onTap,
    );
  }
}