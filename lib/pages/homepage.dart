import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pallete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.newAccentColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top Bar ──────────────────────────────────────────
              _TopBar(),
              const SizedBox(height: 24),

              // ── Greeting + Summary Card ──────────────────────────
              _GreetingCard(),
              const SizedBox(height: 24),

              // ── Quick Stats Row ──────────────────────────────────
              _SectionLabel("Today's Overview"),
              const SizedBox(height: 12),
              _QuickStatsRow(),
              const SizedBox(height: 24),

              // ── Upcoming Appointments ────────────────────────────
              _SectionLabel("Upcoming Appointments"),
              const SizedBox(height: 12),
              _AppointmentCard(
                patientName: "Rajan Mehta",
                time: "10:30 AM",
                tag: "Follow-up",
                tagColor: Pallete.secondSuggestionBoxColor,
                tagTextColor: Pallete.newTextColor,
              ),
              const SizedBox(height: 10),
              _AppointmentCard(
                patientName: "Sunita Bose",
                time: "12:00 PM",
                tag: "Dialysis",
                tagColor: Pallete.thirdSuggestionBoxColor,
                tagTextColor: const Color(0xFF7A5000),
              ),
              const SizedBox(height: 10),
              _AppointmentCard(
                patientName: "Amit Sharma",
                time: "2:45 PM",
                tag: "New Patient",
                tagColor: const Color(0xFFE8E0FF),
                tagTextColor: const Color(0xFF4A3A8A),
              ),
              const SizedBox(height: 24),

              // ── Recent Alerts ────────────────────────────────────
              _SectionLabel("Recent Alerts"),
              const SizedBox(height: 12),
              _AlertTile(
                icon: Icons.warning_amber_rounded,
                color: const Color(0xFFFF8A65),
                title: "High Creatinine",
                subtitle: "Patient Rajan Mehta — Lab result flagged",
              ),
              const SizedBox(height: 10),
              _AlertTile(
                icon: Icons.medication_outlined,
                color: Pallete.accentColor,
                title: "Prescription Due",
                subtitle: "Sunita Bose's prescription expires in 2 days",
              ),
              const SizedBox(height: 24),


            ],
          ),
        ),
      ),
    );
  }
}

// ── Top Bar ──────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning,",
              style: GoogleFonts.comfortaa(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              "Dr. John Doe",
              style: GoogleFonts.comfortaa(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Pallete.mainFontColor,
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
              backgroundColor: Pallete.accentColor.withOpacity(0.15),
              child: Icon(Icons.person, color: Pallete.accentColor, size: 22),
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
            border: Border.all(color: Pallete.newBorderColor),
          ),
          child: Icon(icon, color: Pallete.mainFontColor, size: 20),
        ),
        if (badge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Pallete.borderColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Greeting Card ─────────────────────────────────────────────────────────────

class _GreetingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Pallete.accentColor,
            const Color(0xFF1A9E7E),
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
                  "Tuesday, 9 June",
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
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
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            Icons.medical_services_outlined,
            color: Colors.white.withOpacity(0.25),
            size: 72,
          ),
        ],
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────

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
        color: Pallete.mainFontColor,
      ),
    );
  }
}

// ── Quick Stats Row ───────────────────────────────────────────────────────────

class _QuickStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: "Appointments",
            value: "8",
            icon: Icons.calendar_today_outlined,
            bg: Pallete.secondSuggestionBoxColor,
            iconColor: Pallete.newTextColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: "Pending Labs",
            value: "3",
            icon: Icons.biotech_outlined,
            bg: Pallete.thirdSuggestionBoxColor,
            iconColor: const Color(0xFF7A5000),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: "Alerts",
            value: "2",
            icon: Icons.warning_amber_outlined,
            bg: const Color(0xFFFFE5E5),
            iconColor: Pallete.borderColor,
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
              color: Pallete.mainFontColor,
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

// ── Appointment Card ──────────────────────────────────────────────────────────

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
        border: Border.all(color: Pallete.newBorderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Pallete.accentColor.withOpacity(0.1),
            child: Text(
              patientName[0],
              style: GoogleFonts.comfortaa(
                color: Pallete.accentColor,
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
                    color: Pallete.mainFontColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: GoogleFonts.comfortaa(
                          fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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

// ── Alert Tile ────────────────────────────────────────────────────────────────

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
        border: Border.all(color: Pallete.newBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
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
                    color: Pallete.mainFontColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.comfortaa(
                      fontSize: 12, color: Colors.grey.shade500),
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

// ── Quick Actions Grid ────────────────────────────────────────────────────────

class _QuickActionsGrid extends StatelessWidget {
  final List<_ActionItem> actions = const [
    _ActionItem(Icons.person_add_outlined, "New Patient"),
    _ActionItem(Icons.note_add_outlined, "Write Prescription"),
    _ActionItem(Icons.science_outlined, "Request Lab"),
    _ActionItem(Icons.chat_bubble_outline, "Messages"),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: actions.map((a) => _ActionCell(item: a)).toList(),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  const _ActionItem(this.icon, this.label);
}

class _ActionCell extends StatelessWidget {
  final _ActionItem item;
  const _ActionCell({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Pallete.newBorderColor),
          ),
          child: Icon(item.icon, color: Pallete.accentColor, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          item.label,
          textAlign: TextAlign.center,
          style: GoogleFonts.comfortaa(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}