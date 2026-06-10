import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pallete.dart';
import 'package:diatrack/pages/ai_input_page.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Stub data
  final List<Map<String, dynamic>> _patients = [
    {
      "name": "Ramesh Patel",
      "id": "CKD-001",
      "age": 58,
      "gender": "Male",
      "diagnosis": "CKD Stage 5",
      "lastVisit": "2026-06-05",
      "status": "Critical",
    },
    {
      "name": "Sunita Sharma",
      "id": "CKD-002",
      "age": 45,
      "gender": "Female",
      "diagnosis": "CKD Stage 3",
      "lastVisit": "2026-06-07",
      "status": "Stable",
    },
    {
      "name": "Arjun Mehta",
      "id": "CKD-003",
      "age": 63,
      "gender": "Male",
      "diagnosis": "CKD Stage 4",
      "lastVisit": "2026-06-06",
      "status": "Moderate",
    },
    {
      "name": "Priya Nair",
      "id": "CKD-004",
      "age": 39,
      "gender": "Female",
      "diagnosis": "CKD Stage 2",
      "lastVisit": "2026-06-08",
      "status": "Stable",
    },
    {
      "name": "Vikram Singh",
      "id": "CKD-005",
      "age": 71,
      "gender": "Male",
      "diagnosis": "CKD Stage 5",
      "lastVisit": "2026-06-04",
      "status": "Critical",
    },
  ];

  List<Map<String, dynamic>> get _filtered => _patients
      .where(
        (p) =>
            p['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p['id'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p['diagnosis'].toLowerCase().contains(_searchQuery.toLowerCase()),
      )
      .toList();

  Color _statusColor(String status) {
    switch (status) {
      case 'Critical':
        return Colors.red;
      case 'Moderate':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patients",
          style: GoogleFonts.comfortaa(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Pallete.accentColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {}, // TODO: filter bottom sheet
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiInputPage()),
          );
        }, // TODO: navigate to add patient
        backgroundColor: Pallete.accentColor,
        child: const Icon(Icons.person_add_outlined, color: Colors.white),
      ),
      body: Column(
        children: [
          // ── Search Bar ───────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: "Search by name, ID or diagnosis...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ── Count ────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${_filtered.length} patient${_filtered.length == 1 ? '' : 's'}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),

          // ── List ─────────────────────────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_search,
                          size: 60,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "No patients found",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final p = _filtered[index];
                      return _patientCard(p);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _patientCard(Map<String, dynamic> p) {
    final statusColor = _statusColor(p['status']);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {}, // TODO: navigate to patient detail
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 26,
                backgroundColor: Pallete.accentColor.withOpacity(0.12),
                child: Text(
                  p['name'].split(' ').map((e) => e[0]).take(2).join(),
                  style: TextStyle(
                    color: Pallete.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            p['name'],
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        // Status badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: statusColor.withOpacity(0.4),
                            ),
                          ),
                          child: Text(
                            p['status'],
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${p['id']}  ·  ${p['age']} yrs  ·  ${p['gender']}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.medical_information_outlined,
                          size: 13,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          p['diagnosis'],
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          p['lastVisit'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
