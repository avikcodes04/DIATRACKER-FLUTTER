import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';
import 'package:diatrack/core/router/app_routes.dart';
import 'package:diatrack/features/auth/presentation/controllers/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final doctorName = authState.user?.name.isNotEmpty == true
        ? authState.user!.name
        : "Dr. Sarah Jenkins";

    return Scaffold(
      backgroundColor: AppColors.newAccentColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              _TopBar(doctorName: doctorName),
              const SizedBox(height: 24),

              // Greeting + Summary Card
              _GreetingCard(
                onViewSchedule: () => context.go(AppRoutes.patients),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              _SectionLabel("Quick Shortcuts"),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _QuickActionButton(
                      icon: Icons.smart_toy_outlined,
                      label: "AI Recommendation",
                      color: AppColors.accentColor,
                      onTap: () => context.go(AppRoutes.aiInput),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionButton(
                      icon: Icons.people_outline,
                      label: "Patients Directory",
                      color: AppColors.newTextColor,
                      onTap: () => context.go(AppRoutes.patients),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Stats Row
              _SectionLabel("Today's Overview"),
              const SizedBox(height: 12),
              const _QuickStatsRow(),
              const SizedBox(height: 24),

              // Upcoming Appointments
              _SectionLabel("Upcoming Appointments"),
              const SizedBox(height: 12),
              const _AppointmentCard(
                patientName: "Rajan Mehta",
                time: "10:30 AM",
                tag: "Follow-up",
                tagColor: AppColors.secondSuggestionBoxColor,
                tagTextColor: AppColors.newTextColor,
              ),
              const SizedBox(height: 10),
              const _AppointmentCard(
                patientName: "Sunita Bose",
                time: "12:00 PM",
                tag: "Dialysis",
                tagColor: AppColors.thirdSuggestionBoxColor,
                tagTextColor: Color(0xFF7A5000),
              ),
              const SizedBox(height: 10),
              const _AppointmentCard(
                patientName: "Amit Sharma",
                time: "2:45 PM",
                tag: "New Patient",
                tagColor: Color(0xFFE8E0FF),
                tagTextColor: Color(0xFF4A3A8A),
              ),
              const SizedBox(height: 24),

              // Recent Alerts
              _SectionLabel("Recent Alerts"),
              const SizedBox(height: 12),
              const _AlertTile(
                icon: Icons.warning_amber_rounded,
                color: Colors.red,
                title: "Critical Lab: Suresh Patil",
                subtitle: "Serum potassium reached 6.2 mmol/L",
              ),
              const SizedBox(height: 10),
              const _AlertTile(
                icon: Icons.info_outline,
                color: Colors.orange,
                title: "Dialysis Missed: Meena Devi",
                subtitle: "Did not attend scheduled session at 9:00 AM",
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String doctorName;
  const _TopBar({required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good morning 👋",
              style: GoogleFonts.comfortaa(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              doctorName,
              style: GoogleFonts.comfortaa(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.mainFontColor,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _IconBtn(Icons.notifications_outlined, badge: true),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.accentColor.withValues(alpha: 0.15),
              child: const Icon(Icons.person, color: AppColors.accentColor, size: 22),
            ),
          ],
        ),
      ],
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final bool badge;
  const _IconBtn(this.icon, {this.badge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.newBorderColor),
          ),
          child: Icon(icon, color: AppColors.mainFontColor, size: 20),
        ),
        if (badge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.borderColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

class _GreetingCard extends StatelessWidget {
  final VoidCallback onViewSchedule;
  const _GreetingCard({required this.onViewSchedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.accentColor,
            Color(0xFF1A9E7E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dialysis Care Schedule",
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "You have\n8 patients today",
                  style: GoogleFonts.comfortaa(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: onViewSchedule,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "View full schedule →",
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.medical_services_outlined,
            color: Colors.white.withValues(alpha: 0.25),
            size: 72,
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.mainFontColor,
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.newBorderColor),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainFontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatsRow extends StatelessWidget {
  const _QuickStatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(
            label: "Appointments",
            value: "8",
            icon: Icons.calendar_today_outlined,
            bg: AppColors.secondSuggestionBoxColor,
            iconColor: AppColors.newTextColor,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: "Pending Labs",
            value: "3",
            icon: Icons.biotech_outlined,
            bg: AppColors.thirdSuggestionBoxColor,
            iconColor: Color(0xFF7A5000),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: "Alerts",
            value: "2",
            icon: Icons.warning_amber_outlined,
            bg: Color(0xFFFFE5E5),
            iconColor: AppColors.borderColor,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color bg;
  final Color iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.bg,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.comfortaa(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.mainFontColor,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.comfortaa(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String patientName;
  final String time;
  final String tag;
  final Color tagColor;
  final Color tagTextColor;

  const _AppointmentCard({
    required this.patientName,
    required this.time,
    required this.tag,
    required this.tagColor,
    required this.tagTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.newBorderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.accentColor.withValues(alpha: 0.1),
            child: Text(
              patientName[0],
              style: GoogleFonts.comfortaa(
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainFontColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: GoogleFonts.comfortaa(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: tagTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _AlertTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.newBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainFontColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}
