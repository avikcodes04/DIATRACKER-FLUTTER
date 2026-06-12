import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pallete.dart';
import 'package:diatrack/pages/ai_input_page.dart';
import 'package:diatrack/widgets/patient_card.dart';
class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<Map<String, dynamic>> _patients = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://1nu06hynfd.execute-api.us-east-2.amazonaws.com/default/getPatientsList',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> raw = data['patients'] ?? [];

        setState(() {
          _patients = raw.map((p) {
            // Derive status from diagnosis / eGFR
            String status = _deriveStatus(p);
            return {
              "name": p['patient_name'] ?? 'Unknown',
              "id": p['patientId'] ?? '-',
              "age": (p['patient_age'] ?? 0).toInt(),
              "gender": p['patient_gender'] ?? '-',
              "diagnosis": p['diagnosis'] ?? '-',
              "lastVisit": _formatDate(p['stored_at']),
              "status": status,
            };
          }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load patients (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: $e';
        _isLoading = false;
      });
    }
  }

  /// Derives a simple status string from the raw patient map.
  String _deriveStatus(Map<String, dynamic> p) {
    final egfr = (p['lab_egfr_ml_min_1_73m2'] ?? 100).toDouble();
    final diagnosis = (p['diagnosis'] ?? '').toString().toLowerCase();

    if (diagnosis.contains('end stage') || egfr < 15) return 'Critical';
    if (egfr < 45) return 'Moderate';
    return 'Stable';
  }

  /// Formats an ISO date-time string to YYYY-MM-DD.
  String _formatDate(dynamic raw) {
    if (raw == null) return '-';
    try {
      final dt = DateTime.parse(raw.toString());
      return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
    } catch (_) {
      return raw.toString().split('T').first;
    }
  }

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
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _fetchPatients,
              tooltip: 'Refresh',
            ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AiInputPage()),
          );
        },
        backgroundColor: Pallete.accentColor,
        child: const Icon(Icons.person_add_outlined, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildError()
              : Column(
                  children: [
                    // ── Search Bar ──────────────────────────────
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
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    // ── Count ───────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_filtered.length} patient${_filtered.length == 1 ? '' : 's'}",
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 13),
                        ),
                      ),
                    ),

                    // ── List ────────────────────────────────────
                    Expanded(
                      child: _filtered.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.person_search,
                                      size: 60,
                                      color: Colors.grey.shade300),
                                  const SizedBox(height: 12),
                                  Text(
                                    "No patients found",
                                    style: TextStyle(
                                        color: Colors.grey.shade400),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _fetchPatients,
                              child: ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                    16, 4, 16, 100),
                                itemCount: _filtered.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, index) {
                                  final p = _filtered[index];
                                  return PatientCard(
                                    patient: p,
                                    onTap: () {
                                      // Handle patient card tap
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined,
                size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _fetchPatients,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}