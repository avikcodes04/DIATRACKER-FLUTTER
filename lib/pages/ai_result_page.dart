// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../pallete.dart';

// class AiResultPage extends StatelessWidget {
//   final Map<String, dynamic> result;

//   const AiResultPage({super.key, required this.result});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "AI Recommendation",
//           style: GoogleFonts.comfortaa(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Pallete.accentColor,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Text(result.toString()), // temporary — replace with proper UI
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../pallete.dart';

// class AiResultPage extends StatelessWidget {
//   final Map<String, dynamic> result;

//   const AiResultPage({super.key, required this.result});

//   @override
//   Widget build(BuildContext context) {
//     final bool success = result['success'] ?? false;
//     final String message = result['message'] ?? 'No message';
//     final String requestId = result['request_id'] ?? '-';
//     final String status = result['workflow_status'] ?? '-';
//     final String generatedAt = result['generated_at'] ?? '-';
//     final Map<String, dynamic> data = result['data'] ?? {};
//     final bool dataSuccess = data['success'] ?? false;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "AI Result",
//           style: GoogleFonts.comfortaa(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Pallete.accentColor,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Status banner
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: success ? Colors.green.shade50 : Colors.red.shade50,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: success ? Colors.green : Colors.red,
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     success ? Icons.check_circle : Icons.error_outline,
//                     color: success ? Colors.green : Colors.red,
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       message,
//                       style: TextStyle(
//                         color: success ? Colors.green.shade800 : Colors.red.shade800,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Metadata card
//             Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Workflow Info",
//                         style: GoogleFonts.comfortaa(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const Divider(),
//                     _infoRow("Status", status),
//                     _infoRow("Request ID", requestId),
//                     _infoRow("Generated At", generatedAt),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Data / recommendation card
//             Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Recommendation",
//                         style: GoogleFonts.comfortaa(
//                             fontWeight: FontWeight.bold, fontSize: 16)),
//                     const Divider(),
//                     if (!dataSuccess)
//                       Row(
//                         children: [
//                           const Icon(Icons.warning_amber, color: Colors.orange),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               data['error'] ?? 'No recommendation available.',
//                               style: const TextStyle(color: Colors.orange),
//                             ),
//                           ),
//                         ],
//                       )
//                     else
//                       // When data has real content, display it here
//                       Text(data.toString()),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 110,
//             child: Text(label,
//                 style: const TextStyle(
//                     color: Colors.grey, fontWeight: FontWeight.w500)),
//           ),
//           Expanded(
//             child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pallete.dart';

class AiResultPage extends StatelessWidget {
  final Map<String, dynamic> result;

  const AiResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final data = (result['data'] as Map<String, dynamic>?) ?? {};
    final summary = (data['clinical_summary'] as Map<String, dynamic>?) ?? {};
    final patient = (summary['patient_overview'] as Map<String, dynamic>?) ?? {};
    final assessment = (summary['clinical_assessment'] as Map<String, dynamic>?) ?? {};
    final dialysisPlan = (summary['todays_dialysis_plan'] as Map<String, dynamic>?) ?? {};
    final nextSession = (summary['next_session_plan'] as Map<String, dynamic>?) ?? {};
    final severityContext = (assessment['severity_context'] as Map<String, dynamic>?) ?? {};
    final electrolyteStrategy = (dialysisPlan['electrolyte_strategy'] as Map<String, dynamic>?) ?? {};
    final cardiacProtocol = (nextSession['cardiac_protocol'] as Map<String, dynamic>?) ?? {};
    final accessProtocol = (nextSession['access_protocol'] as Map<String, dynamic>?) ?? {};

    final List monitoringPriorities = summary['monitoring_priorities'] ?? [];
    final List nurseGuidance = summary['nurse_guidance'] ?? [];
    final List identifiedRisks = summary['identified_risks'] ?? [];
    final List icuNotes = summary['icu_escalation_notes'] ?? [];
    final List careRecs = summary['care_recommendations'] ?? [];
    final String doctorSummary = data['doctor_summary'] ?? '';
    final String executionTime =
        '${result['workflow_execution_time_seconds'] ?? '-'}s';
    final String generatedAt = result['generated_at'] ?? '';

    final bool isEmergency = assessment['emergency_status'] ?? false;
    final String severity = assessment['severity_level'] ?? '-';
    final int riskScore = assessment['risk_score'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AI Recommendation",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Patient Overview ──────────────────────────────
            _sectionCard(
              icon: Icons.person_outline,
              title: "Patient Overview",
              child: Column(
                children: [
                  _infoRow("Name", patient['patient_name'] ?? '-'),
                  _infoRow("ID", patient['patient_id'] ?? '-'),
                  _infoRow("Age", '${patient['age']} yrs'),
                  _infoRow("Gender", patient['gender'] ?? '-'),
                  _infoRow("Diagnosis", patient['diagnosis'] ?? '-'),
                ],
              ),
            ),

            // ── Clinical Assessment ───────────────────────────
            _sectionCard(
              icon: Icons.monitor_heart_outlined,
              title: "Clinical Assessment",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _badge(
                        severity,
                        severity == 'Mild'
                            ? Colors.green
                            : severity == 'Moderate'
                                ? Colors.orange
                                : Colors.red,
                      ),
                      const SizedBox(width: 10),
                      if (isEmergency)
                        _badge("EMERGENCY", Colors.red)
                      else
                        _badge("Stable", Colors.green),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _infoRow("Risk Score", '$riskScore'),
                  const SizedBox(height: 10),
                  Text("Escalation Flags",
                      style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: severityContext.entries
                        .where((e) => e.value == true)
                        .map((e) => _badge(
                            e.key
                                .replaceAll('_', ' ')
                                .split(' ')
                                .map((w) =>
                                    w[0].toUpperCase() + w.substring(1))
                                .join(' '),
                            Colors.red.shade300))
                        .toList()
                      ..addAll(severityContext.entries
                          .where((e) => e.value == false)
                          .map((e) => _badge(
                              e.key
                                  .replaceAll('_', ' ')
                                  .split(' ')
                                  .map((w) =>
                                      w[0].toUpperCase() + w.substring(1))
                                  .join(' '),
                              Colors.grey.shade300))
                          .toList()),
                  ),
                ],
              ),
            ),

            // ── Today's Dialysis Plan ─────────────────────────
            _sectionCard(
              icon: Icons.water_drop_outlined,
              title: "Today's Dialysis Plan",
              child: Column(
                children: [
                  _infoRow("Modality", dialysisPlan['dialysis_modality'] ?? '-'),
                  _infoRow("Duration", dialysisPlan['recommended_duration'] ?? '-'),
                  _infoRow("Frequency", dialysisPlan['recommended_frequency'] ?? '-'),
                  _infoRow("Urgency", dialysisPlan['urgency'] ?? '-'),
                  _infoRow("UF Strategy", dialysisPlan['ultrafiltration_strategy'] ?? '-'),
                  const SizedBox(height: 8),
                  Text("Electrolyte Strategy",
                      style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  _infoRow("K⁺ Management",
                      electrolyteStrategy['potassium_management'] ?? 'N/A'),
                  _infoRow("Acid-Base",
                      electrolyteStrategy['acid_base_strategy'] ?? 'N/A'),
                  _infoRow("Correction Pacing",
                      electrolyteStrategy['electrolyte_correction_pacing'] ?? '-'),
                ],
              ),
            ),

            // ── Next Session Plan ─────────────────────────────
            _sectionCard(
              icon: Icons.event_repeat_outlined,
              title: "Next Session Plan",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _boolRow("Repeat Dialysis", nextSession['repeat_dialysis_consideration']),
                  _boolRow("Recovery Protocol", nextSession['recovery_protocol']),
                  const SizedBox(height: 8),
                  Text("Cardiac Protocol",
                      style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  _boolRow("Continuous Monitoring",
                      cardiacProtocol['continuous_cardiac_monitoring']),
                  _boolRow("Slow Fluid Removal",
                      cardiacProtocol['slow_fluid_removal']),
                  const SizedBox(height: 8),
                  Text("Access Protocol",
                      style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold)),
                  _infoRow("Access Type", accessProtocol['access_type'] ?? '-'),
                  _boolRow("Infection Monitoring", accessProtocol['infection_monitoring']),
                  _boolRow("Thrombosis Monitoring", accessProtocol['thrombosis_monitoring']),
                  _boolRow("Flow Monitoring", accessProtocol['flow_monitoring']),
                ],
              ),
            ),

            // ── Monitoring Priorities ─────────────────────────
            if (monitoringPriorities.isNotEmpty)
              _sectionCard(
                icon: Icons.checklist_outlined,
                title: "Monitoring Priorities",
                child: Column(
                  children: monitoringPriorities
                      .map((e) => _bulletRow(e.toString()))
                      .toList(),
                ),
              ),

            // ── Nurse Guidance ────────────────────────────────
            if (nurseGuidance.isNotEmpty)
              _sectionCard(
                icon: Icons.medical_services_outlined,
                title: "Nurse Guidance",
                child: Column(
                  children: nurseGuidance
                      .map((e) => _bulletRow(e.toString()))
                      .toList(),
                ),
              ),

            // ── Identified Risks ──────────────────────────────
            if (identifiedRisks.isNotEmpty)
              _sectionCard(
                icon: Icons.warning_amber_outlined,
                title: "Identified Risks",
                child: Column(
                  children: identifiedRisks
                      .map((e) => _bulletRow(e.toString(), color: Colors.red))
                      .toList(),
                ),
              ),

            // ── ICU Escalation Notes ──────────────────────────
            if (icuNotes.isNotEmpty)
              _sectionCard(
                icon: Icons.local_hospital_outlined,
                title: "ICU Escalation Notes",
                child: Column(
                  children: icuNotes
                      .map((e) => _bulletRow(e.toString(), color: Colors.red))
                      .toList(),
                ),
              ),

            // ── Care Recommendations ──────────────────────────
            if (careRecs.isNotEmpty)
              _sectionCard(
                icon: Icons.favorite_border,
                title: "Care Recommendations",
                child: Column(
                  children: careRecs
                      .map((e) => _bulletRow(e.toString()))
                      .toList(),
                ),
              ),

            // ── Doctor Summary ────────────────────────────────
            _sectionCard(
              icon: Icons.description_outlined,
              title: "Doctor Summary",
              child: Text(
                doctorSummary,
                style: const TextStyle(height: 1.6),
              ),
            ),

            // ── Meta ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 24),
              child: Text(
                "Generated at $generatedAt · Completed in $executionTime",
                style: const TextStyle(color: Colors.grey, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Pallete.accentColor, size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
            const Divider(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _boolRow(String label, bool? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(label,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500)),
          ),
          Icon(
            value == true ? Icons.check_circle : Icons.cancel,
            color: value == true ? Colors.green : Colors.grey,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget _bulletRow(String text, {Color color = Colors.black87}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right, color: color, size: 20),
          Expanded(
            child: Text(text, style: TextStyle(color: color, height: 1.5)),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}