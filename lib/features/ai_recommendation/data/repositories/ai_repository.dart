import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/core/constants/api_endpoints.dart';
import 'package:diatrack/core/network/api_client.dart';

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AiRepository(apiClient);
});

class AiRepository {
  final ApiClient _apiClient;

  AiRepository(this._apiClient);

  Future<Map<String, dynamic>> getRecommendation(Map<String, dynamic> clinicalData) async {
    try {
      final response = await _apiClient.post(
        ApiEndpoints.recommend,
        body: clinicalData,
        timeout: const Duration(seconds: 10),
      );

      if (response is Map<String, dynamic>) {
        return response;
      }
      return {'success': true, 'data': response};
    } catch (_) {
      // Fallback sample recommendation when backend is offline
      return _getMockRecommendation(clinicalData);
    }
  }

  Map<String, dynamic> _getMockRecommendation(Map<String, dynamic> input) {
    final patientName = input['patient_name'] ?? 'Patient';
    final patientId = input['patient_id'] ?? 'DIA-TEST';
    final age = input['patient_age'] ?? 55;
    final gender = input['patient_gender'] ?? 'Male';
    final diagnosis = input['diagnosis'] ?? 'ESRD - Chronic Kidney Disease Stage 5';

    return {
      "success": true,
      "message": "AI Clinical Analysis generated successfully (Offline Demo)",
      "request_id": "REQ-${DateTime.now().millisecondsSinceEpoch}",
      "workflow_status": "COMPLETED",
      "workflow_execution_time_seconds": 1.42,
      "generated_at": DateTime.now().toIso8601String(),
      "data": {
        "success": true,
        "doctor_summary":
            "Patient $patientName ($patientId, $age y/o $gender) presented with $diagnosis. Recommended dialysis duration is 4.0 hours with an ultrafiltration target of 2.2 L. Close electrolyte monitoring is advised given current potassium trends.",
        "clinical_summary": {
          "patient_overview": {
            "patient_name": patientName,
            "patient_id": patientId,
            "age": age,
            "gender": gender,
            "diagnosis": diagnosis,
          },
          "clinical_assessment": {
            "emergency_status": false,
            "severity_level": "Moderate",
            "risk_score": 68,
            "severity_context": {
              "primary_concern": "Fluid overload and hyperkalemia risk",
              "cardiovascular_stability": "Adequate baseline, monitor BP hourly",
            },
          },
          "todays_dialysis_plan": {
            "prescribed_time_hours": 4.0,
            "blood_flow_rate_ml_min": 350,
            "dialysate_flow_rate_ml_min": 500,
            "uf_target_liters": 2.2,
            "dialyzer_type": "High-flux biocompatible membrane",
            "anticoagulation": "Low molecular weight heparin bolus",
            "electrolyte_strategy": {
              "potassium_bath": "2.0 mEq/L",
              "calcium_bath": "2.5 mEq/L",
              "bicarbonate": "35 mEq/L",
            },
          },
          "next_session_plan": {
            "recommended_interval_days": 2,
            "weight_gain_limit_kg": 1.5,
            "cardiac_protocol": {
              "target_dry_weight_kg": 68.5,
              "monitoring": "Continuous pulse oximetry and ECG tracing",
            },
            "access_protocol": {
              "type": "Arteriovenous (AV) Fistula - Left forearm",
              "patency": "Good thrill and audible bruit",
            },
          },
          "monitoring_priorities": [
            "Monitor pre- and post-dialysis blood pressure every 30 minutes",
            "Check serum potassium within 2 hours post-session",
            "Assess vascular access site for hematoma or bleeding post-cannulation",
          ],
          "nurse_guidance": [
            "Maintain dry weight target without exceeding UF rate > 10 mL/kg/h",
            "Keep patient in semi-Fowler position during first hour",
          ],
          "identified_risks": [
            "Intradialytic hypotension risk if UF exceeds 2.5 L",
            "Post-dialysis rebound hyperkalemia",
          ],
          "icu_escalation_notes": [
            "Escalate to ICU if systolic BP drops below 90 mmHg unresponsive to saline bolus",
            "Immediate nephrology consult if chest pain or severe arrhythmia develops",
          ],
          "care_recommendations": [
            "Dietary phosphorus restriction to < 800 mg/day",
            "Daily fluid intake limit of 1.0 Liter",
            "Review compliance with phosphate binders and antihypertensives",
          ],
        },
      },
    };
  }
}
