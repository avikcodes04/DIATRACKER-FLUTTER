import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diatrack/core/constants/app_colors.dart';
import 'package:diatrack/core/router/app_routes.dart';
import 'package:diatrack/features/ai_recommendation/presentation/controllers/ai_recommendation_controller.dart';
import 'package:diatrack/shared/widgets/custom_expansion_tile.dart';
import 'package:diatrack/shared/widgets/custom_text_field.dart';

class AiInputScreen extends ConsumerStatefulWidget {
  const AiInputScreen({super.key});

  @override
  ConsumerState<AiInputScreen> createState() => _AiInputScreenState();
}

class _AiInputScreenState extends ConsumerState<AiInputScreen> {
  final Map<String, TextEditingController> _controllers = {
    // Patient Info
    "patientId": TextEditingController(),
    "patient_name": TextEditingController(),
    "patient_age": TextEditingController(),
    "patient_gender": TextEditingController(),
    "blood_group": TextEditingController(),
    "occupation": TextEditingController(),
    "diagnosis": TextEditingController(),
    "dialysis_history": TextEditingController(),
    "dialysis_type": TextEditingController(),
    "dialysis_access_type": TextEditingController(),
    "last_dialysis_date": TextEditingController(),

    // Dialysis Metrics
    "kt_v": TextEditingController(),
    "urr_percent": TextEditingController(),
    "interdialytic_weight_gain_kg": TextEditingController(),

    // Fluid Status
    "fluid_overload": TextEditingController(),
    "pulmonary_edema": TextEditingController(),
    "pleural_effusion": TextEditingController(),
    "ascites": TextEditingController(),
    "jugular_venous_distension": TextEditingController(),

    // Comorbidities
    "diabetes": TextEditingController(),
    "hypertension": TextEditingController(),
    "heart_disease": TextEditingController(),
    "heart_failure": TextEditingController(),
    "arrhythmia_history": TextEditingController(),

    // Oxygen & Mental
    "oxygen_saturation": TextEditingController(),
    "respiratory_distress": TextEditingController(),
    "mental_status": TextEditingController(),
    "confusion": TextEditingController(),

    // Lab Values
    "lab_serum_creatinine_mg_dl": TextEditingController(),
    "lab_egfr_ml_min_1_73m2": TextEditingController(),
    "lab_bun_mg_dl": TextEditingController(),
    "lab_serum_sodium_meq_l": TextEditingController(),
    "lab_serum_potassium_meq_l": TextEditingController(),
    "lab_serum_chloride_meq_l": TextEditingController(),
    "lab_serum_calcium_mg_dl": TextEditingController(),
    "lab_serum_phosphate_mg_dl": TextEditingController(),
    "lab_serum_bicarbonate_meq_l": TextEditingController(),
    "lab_hemoglobin_g_dl": TextEditingController(),
    "lab_albumin_g_dl": TextEditingController(),
    "lab_pth_pg_ml": TextEditingController(),
    "blood_glucose_mg_dl": TextEditingController(),
    "hba1c_percent": TextEditingController(),
    "crp_mg_l": TextEditingController(),

    // Urinalysis
    "urine_albumin_creatinine_ratio_mg_g": TextEditingController(),
    "urine_proteinuria": TextEditingController(),
    "urine_output_ml_day": TextEditingController(),

    // Vitals
    "vital_blood_pressure_mmhg": TextEditingController(),
    "vital_pulse_bpm": TextEditingController(),
    "vital_weight_kg": TextEditingController(),
    "dry_weight_kg": TextEditingController(),
    "bmi": TextEditingController(),
    "body_temperature_c": TextEditingController(),
    "respiratory_rate": TextEditingController(),

    // Lifestyle
    "smoking": TextEditingController(),
    "alcohol_use": TextEditingController(),
    "physical_activity": TextEditingController(),
    "daily_water_intake_liters": TextEditingController(),
    "sleep_quality": TextEditingController(),
    "salt_intake": TextEditingController(),
    "protein_intake_g_kg_day": TextEditingController(),
    "potassium_rich_food_intake": TextEditingController(),
    "fluid_restriction_adherence": TextEditingController(),

    // Complications & Access
    "dialysis_cramps": TextEditingController(),
    "post_dialysis_fatigue": TextEditingController(),
    "previous_hypotension_during_dialysis": TextEditingController(),
    "access_flow_adequate": TextEditingController(),
    "access_infection": TextEditingController(),
    "access_thrombosis_history": TextEditingController(),
    "chest_pain": TextEditingController(),

    // Medications & Symptoms
    "medications": TextEditingController(),
    "symptoms": TextEditingController(),
    "antihypertensive_medication_adherence": TextEditingController(),
  };

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _str(String key) {
    final v = _controllers[key]?.text.trim();
    return (v == null || v.isEmpty) ? null : v;
  }

  num? _num(String key) => num.tryParse(_controllers[key]?.text.trim() ?? '');

  bool? _bool(String key) {
    final v = _controllers[key]?.text.trim().toLowerCase();
    if (v == 'yes' || v == 'true') return true;
    if (v == 'no' || v == 'false') return false;
    return null;
  }

  void _loadSampleData() {
    setState(() {
      _controllers["patient_name"]?.text = "Ramesh Sharma";
      _controllers["patientId"]?.text = "DIA-1042";
      _controllers["patient_age"]?.text = "58";
      _controllers["patient_gender"]?.text = "Male";
      _controllers["blood_group"]?.text = "B+";
      _controllers["occupation"]?.text = "Retired Teacher";
      _controllers["diagnosis"]?.text = "End-Stage Renal Disease (CKD Stage 5)";
      _controllers["dialysis_history"]?.text = "Hemodialysis for 2 years";
      _controllers["dialysis_type"]?.text = "Hemodialysis";
      _controllers["dialysis_access_type"]?.text = "AV Fistula - Left Forearm";
      _controllers["last_dialysis_date"]?.text = "2026-10-14";

      _controllers["kt_v"]?.text = "1.25";
      _controllers["urr_percent"]?.text = "68";
      _controllers["interdialytic_weight_gain_kg"]?.text = "2.8";

      _controllers["vital_blood_pressure_mmhg"]?.text = "152/94";
      _controllers["vital_pulse_bpm"]?.text = "78";
      _controllers["vital_weight_kg"]?.text = "72.4";
      _controllers["dry_weight_kg"]?.text = "69.5";
      _controllers["bmi"]?.text = "24.6";
      _controllers["body_temperature_c"]?.text = "36.8";
      _controllers["respiratory_rate"]?.text = "18";
      _controllers["oxygen_saturation"]?.text = "97";
      _controllers["mental_status"]?.text = "Alert";

      _controllers["fluid_overload"]?.text = "Yes";
      _controllers["pulmonary_edema"]?.text = "No";
      _controllers["pleural_effusion"]?.text = "No";
      _controllers["ascites"]?.text = "No";
      _controllers["jugular_venous_distension"]?.text = "No";

      _controllers["diabetes"]?.text = "Yes";
      _controllers["hypertension"]?.text = "Yes";
      _controllers["heart_disease"]?.text = "No";
      _controllers["heart_failure"]?.text = "No";
      _controllers["arrhythmia_history"]?.text = "No";

      _controllers["lab_serum_creatinine_mg_dl"]?.text = "8.2";
      _controllers["lab_egfr_ml_min_1_73m2"]?.text = "9.0";
      _controllers["lab_bun_mg_dl"]?.text = "68";
      _controllers["lab_serum_sodium_meq_l"]?.text = "138";
      _controllers["lab_serum_potassium_meq_l"]?.text = "5.6";
      _controllers["lab_serum_chloride_meq_l"]?.text = "101";
      _controllers["lab_serum_calcium_mg_dl"]?.text = "8.6";
      _controllers["lab_serum_phosphate_mg_dl"]?.text = "5.8";
      _controllers["lab_serum_bicarbonate_meq_l"]?.text = "20";
      _controllers["lab_hemoglobin_g_dl"]?.text = "10.4";
      _controllers["lab_albumin_g_dl"]?.text = "3.8";
      _controllers["lab_pth_pg_ml"]?.text = "320";
      _controllers["blood_glucose_mg_dl"]?.text = "142";
      _controllers["hba1c_percent"]?.text = "7.2";
      _controllers["crp_mg_l"]?.text = "4.2";

      _controllers["urine_output_ml_day"]?.text = "400";
      _controllers["urine_albumin_creatinine_ratio_mg_g"]?.text = "320";
      _controllers["urine_proteinuria"]?.text = "Yes";

      _controllers["access_flow_adequate"]?.text = "Yes";
      _controllers["access_infection"]?.text = "No";
      _controllers["access_thrombosis_history"]?.text = "No";

      _controllers["dialysis_cramps"]?.text = "Yes";
      _controllers["post_dialysis_fatigue"]?.text = "Yes";
      _controllers["previous_hypotension_during_dialysis"]?.text = "No";

      _controllers["alcohol_use"]?.text = "None";
      _controllers["physical_activity"]?.text = "Light walking";
      _controllers["daily_water_intake_liters"]?.text = "1.2";
      _controllers["sleep_quality"]?.text = "Fair";
      _controllers["salt_intake"]?.text = "Low";
      _controllers["protein_intake_g_kg_day"]?.text = "1.1";
      _controllers["potassium_rich_food_intake"]?.text = "Medium";
      _controllers["fluid_restriction_adherence"]?.text = "Fair";
      _controllers["smoking"]?.text = "No";

      _controllers["symptoms"]?.text = "Mild bilateral ankle swelling, fatigue after dialysis";
      _controllers["medications"]?.text = "Amlodipine 5mg, Sevelamer 800mg, Erythropoietin weekly";
      _controllers["antihypertensive_medication_adherence"]?.text = "Good";
      _controllers["chest_pain"]?.text = "None";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sample clinical data loaded!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submitClinicalData() async {
    final body = {
      "patientId": _str("patientId") ?? "DIA-DEMO",
      "patient_name": _str("patient_name") ?? "Patient",
      "patient_age": _num("patient_age") ?? 50,
      "patient_gender": _str("patient_gender") ?? "Male",
      "blood_group": _str("blood_group"),
      "occupation": _str("occupation"),
      "diagnosis": _str("diagnosis") ?? "End-Stage Renal Disease",
      "dialysis_history": _str("dialysis_history"),
      "dialysis_type": _str("dialysis_type") ?? "Hemodialysis",
      "dialysis_access_type": _str("dialysis_access_type") ?? "AV Fistula",
      "last_dialysis_date": _str("last_dialysis_date"),

      "kt_v": _num("kt_v"),
      "urr_percent": _num("urr_percent"),
      "interdialytic_weight_gain_kg": _num("interdialytic_weight_gain_kg"),

      "fluid_overload": _bool("fluid_overload"),
      "pulmonary_edema": _bool("pulmonary_edema"),
      "pleural_effusion": _bool("pleural_effusion"),
      "ascites": _bool("ascites"),
      "jugular_venous_distension": _bool("jugular_venous_distension"),

      "diabetes": _bool("diabetes"),
      "hypertension": _bool("hypertension"),
      "heart_disease": _bool("heart_disease"),
      "heart_failure": _bool("heart_failure"),
      "arrhythmia_history": _bool("arrhythmia_history"),

      "oxygen_saturation": _num("oxygen_saturation"),
      "respiratory_distress": _bool("respiratory_distress"),
      "mental_status": _str("mental_status"),
      "confusion": _bool("confusion"),

      "lab_serum_creatinine_mg_dl": _num("lab_serum_creatinine_mg_dl"),
      "lab_egfr_ml_min_1_73m2": _num("lab_egfr_ml_min_1_73m2"),
      "lab_bun_mg_dl": _num("lab_bun_mg_dl"),
      "lab_serum_sodium_meq_l": _num("lab_serum_sodium_meq_l"),
      "lab_serum_potassium_meq_l": _num("lab_serum_potassium_meq_l"),
      "lab_serum_chloride_meq_l": _num("lab_serum_chloride_meq_l"),
      "lab_serum_calcium_mg_dl": _num("lab_serum_calcium_mg_dl"),
      "lab_serum_phosphate_mg_dl": _num("lab_serum_phosphate_mg_dl"),
      "lab_serum_bicarbonate_meq_l": _num("lab_serum_bicarbonate_meq_l"),
      "lab_hemoglobin_g_dl": _num("lab_hemoglobin_g_dl"),
      "lab_albumin_g_dl": _num("lab_albumin_g_dl"),
      "lab_pth_pg_ml": _num("lab_pth_pg_ml"),
      "blood_glucose_mg_dl": _num("blood_glucose_mg_dl"),
      "hba1c_percent": _num("hba1c_percent"),
      "crp_mg_l": _num("crp_mg_l"),

      "urine_albumin_creatinine_ratio_mg_g": _num("urine_albumin_creatinine_ratio_mg_g"),
      "urine_proteinuria": _bool("urine_proteinuria"),
      "urine_output_ml_day": _num("urine_output_ml_day"),

      "vital_blood_pressure_mmhg": _str("vital_blood_pressure_mmhg"),
      "vital_pulse_bpm": _num("vital_pulse_bpm"),
      "vital_weight_kg": _num("vital_weight_kg"),
      "dry_weight_kg": _num("dry_weight_kg"),
      "bmi": _num("bmi"),
      "body_temperature_c": _num("body_temperature_c"),
      "respiratory_rate": _num("respiratory_rate"),

      "smoking": _bool("smoking"),
      "alcohol_use": _str("alcohol_use"),
      "physical_activity": _str("physical_activity"),
      "daily_water_intake_liters": _num("daily_water_intake_liters"),
      "sleep_quality": _str("sleep_quality"),
      "salt_intake": _str("salt_intake"),
      "protein_intake_g_kg_day": _num("protein_intake_g_kg_day"),
      "potassium_rich_food_intake": _str("potassium_rich_food_intake"),
      "fluid_restriction_adherence": _str("fluid_restriction_adherence"),

      "dialysis_cramps": _bool("dialysis_cramps"),
      "post_dialysis_fatigue": _bool("post_dialysis_fatigue"),
      "previous_hypotension_during_dialysis": _bool("previous_hypotension_during_dialysis"),

      "access_flow_adequate": _bool("access_flow_adequate"),
      "access_infection": _bool("access_infection"),
      "access_thrombosis_history": _bool("access_thrombosis_history"),

      "chest_pain": _str("chest_pain"),

      "medications": _str("medications")
              ?.split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],
      "symptoms": _str("symptoms")
              ?.split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList() ??
          [],
      "antihypertensive_medication_adherence":
          _str("antihypertensive_medication_adherence"),
    };

    final result = await ref
        .read(aiRecommendationControllerProvider.notifier)
        .generateRecommendation(body);

    if (!mounted) return;

    if (result != null) {
      context.push(AppRoutes.aiResult, extra: result);
    } else {
      final error = ref.read(aiRecommendationControllerProvider).errorMessage ??
          "Could not generate AI recommendation";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiState = ref.watch(aiRecommendationControllerProvider);
    final isLoading = aiState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.newAccentColor,
      appBar: AppBar(
        title: Text(
          "AI Clinical Recommendation",
          style: GoogleFonts.comfortaa(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.accentColor,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: _loadSampleData,
            icon: const Icon(Icons.auto_fix_high, size: 18, color: AppColors.accentColor),
            label: Text(
              "Sample",
              style: GoogleFonts.comfortaa(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Quick description banner
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: AppColors.assistantCircleColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.newBorderColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_outlined, color: AppColors.accentColor, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Enter patient clinical parameters or tap 'Sample' to quickly test AI recommendation engine.",
                      style: GoogleFonts.lato(fontSize: 13, color: AppColors.newTextColor),
                    ),
                  ),
                ],
              ),
            ),

            // 1. Patient Information
            CustomExpansionTile(
              icon: Icons.person_outline,
              title: "Patient Information",
              children: [
                CustomTextField(
                  label: "Patient Name",
                  controller: _controllers["patient_name"],
                ),
                CustomTextField(
                  label: "Patient ID",
                  controller: _controllers["patientId"],
                ),
                CustomTextField(
                  label: "Patient Age",
                  keyboardType: TextInputType.number,
                  controller: _controllers["patient_age"],
                ),
                CustomTextField(
                  label: "Gender",
                  controller: _controllers["patient_gender"],
                ),
                CustomTextField(
                  label: "Blood Group",
                  controller: _controllers["blood_group"],
                ),
                CustomTextField(
                  label: "Occupation",
                  controller: _controllers["occupation"],
                ),
                CustomTextField(
                  label: "Diagnosis",
                  controller: _controllers["diagnosis"],
                ),
                CustomTextField(
                  label: "Dialysis History",
                  controller: _controllers["dialysis_history"],
                ),
                CustomTextField(
                  label: "Dialysis Type",
                  controller: _controllers["dialysis_type"],
                ),
                CustomTextField(
                  label: "Dialysis Access Type",
                  controller: _controllers["dialysis_access_type"],
                ),
                CustomTextField(
                  label: "Last Dialysis Date",
                  hint: "YYYY-MM-DD",
                  controller: _controllers["last_dialysis_date"],
                ),
              ],
            ),

            // 2. Dialysis Metrics
            CustomExpansionTile(
              title: "Dialysis Metrics",
              icon: Icons.water_drop_outlined,
              children: [
                CustomTextField(
                  label: "Kt/V",
                  hint: "e.g. 1.25",
                  controller: _controllers["kt_v"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "URR (%)",
                  hint: "e.g. 65",
                  controller: _controllers["urr_percent"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Interdialytic Weight Gain (kg)",
                  hint: "e.g. 2.5",
                  controller: _controllers["interdialytic_weight_gain_kg"],
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            // 3. Vital Signs
            CustomExpansionTile(
              title: "Vital Signs",
              icon: Icons.monitor_heart_outlined,
              children: [
                CustomTextField(
                  label: "Blood Pressure (mmHg)",
                  hint: "e.g. 120/80",
                  controller: _controllers["vital_blood_pressure_mmhg"],
                ),
                CustomTextField(
                  label: "Pulse (bpm)",
                  hint: "e.g. 72",
                  controller: _controllers["vital_pulse_bpm"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Weight (kg)",
                  hint: "e.g. 70.5",
                  controller: _controllers["vital_weight_kg"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Dry Weight (kg)",
                  hint: "Target dry weight",
                  controller: _controllers["dry_weight_kg"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "BMI",
                  hint: "e.g. 24.5",
                  controller: _controllers["bmi"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Body Temperature (°C)",
                  hint: "e.g. 37.0",
                  controller: _controllers["body_temperature_c"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Respiratory Rate (breaths/min)",
                  hint: "e.g. 16",
                  controller: _controllers["respiratory_rate"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Oxygen Saturation (%)",
                  hint: "e.g. 98",
                  controller: _controllers["oxygen_saturation"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Mental Status",
                  hint: "e.g. Alert, Confused",
                  controller: _controllers["mental_status"],
                ),
              ],
            ),

            // 4. Fluid Status
            CustomExpansionTile(
              title: "Fluid Status",
              icon: Icons.science_outlined,
              children: [
                CustomTextField(
                  label: "Fluid Overload",
                  hint: "Yes/No",
                  controller: _controllers["fluid_overload"],
                ),
                CustomTextField(
                  label: "Pulmonary Edema",
                  hint: "Yes/No",
                  controller: _controllers["pulmonary_edema"],
                ),
                CustomTextField(
                  label: "Pleural Effusion",
                  hint: "Yes/No",
                  controller: _controllers["pleural_effusion"],
                ),
                CustomTextField(
                  label: "Ascites",
                  hint: "Yes/No",
                  controller: _controllers["ascites"],
                ),
                CustomTextField(
                  label: "Jugular Venous Distension",
                  hint: "Yes/No",
                  controller: _controllers["jugular_venous_distension"],
                ),
              ],
            ),

            // 5. Comorbidities
            CustomExpansionTile(
              title: "Comorbidities",
              icon: Icons.medical_services_outlined,
              children: [
                CustomTextField(
                  label: "Diabetes",
                  hint: "Yes/No",
                  controller: _controllers["diabetes"],
                ),
                CustomTextField(
                  label: "Hypertension",
                  hint: "Yes/No",
                  controller: _controllers["hypertension"],
                ),
                CustomTextField(
                  label: "Heart Disease",
                  hint: "Yes/No",
                  controller: _controllers["heart_disease"],
                ),
                CustomTextField(
                  label: "Heart Failure",
                  hint: "Yes/No",
                  controller: _controllers["heart_failure"],
                ),
                CustomTextField(
                  label: "Arrhythmia History",
                  hint: "Yes/No",
                  controller: _controllers["arrhythmia_history"],
                ),
              ],
            ),

            // 6. Laboratory Values
            CustomExpansionTile(
              title: "Laboratory Values",
              icon: Icons.biotech_outlined,
              children: [
                CustomTextField(
                  label: "Serum Creatinine (mg/dL)",
                  hint: "e.g. 7.5",
                  controller: _controllers["lab_serum_creatinine_mg_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "eGFR (mL/min/1.73m²)",
                  hint: "e.g. 10.5",
                  controller: _controllers["lab_egfr_ml_min_1_73m2"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "BUN (mg/dL)",
                  hint: "e.g. 60",
                  controller: _controllers["lab_bun_mg_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Sodium (mEq/L)",
                  hint: "e.g. 138",
                  controller: _controllers["lab_serum_sodium_meq_l"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Potassium (mEq/L)",
                  hint: "e.g. 5.2",
                  controller: _controllers["lab_serum_potassium_meq_l"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Chloride (mEq/L)",
                  hint: "e.g. 102",
                  controller: _controllers["lab_serum_chloride_meq_l"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Calcium (mg/dL)",
                  hint: "e.g. 8.8",
                  controller: _controllers["lab_serum_calcium_mg_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Phosphate (mg/dL)",
                  hint: "e.g. 5.5",
                  controller: _controllers["lab_serum_phosphate_mg_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Serum Bicarbonate (mEq/L)",
                  hint: "e.g. 21",
                  controller: _controllers["lab_serum_bicarbonate_meq_l"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Hemoglobin (g/dL)",
                  hint: "e.g. 10.2",
                  controller: _controllers["lab_hemoglobin_g_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Albumin (g/dL)",
                  hint: "e.g. 3.7",
                  controller: _controllers["lab_albumin_g_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "PTH (pg/mL)",
                  hint: "e.g. 280",
                  controller: _controllers["lab_pth_pg_ml"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Blood Glucose (mg/dL)",
                  hint: "e.g. 135",
                  controller: _controllers["blood_glucose_mg_dl"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "HbA1c (%)",
                  hint: "e.g. 7.1",
                  controller: _controllers["hba1c_percent"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "CRP (mg/L)",
                  hint: "e.g. 4.0",
                  controller: _controllers["crp_mg_l"],
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            // 7. Urine Output
            CustomExpansionTile(
              title: "Urine Output",
              icon: Icons.local_drink_outlined,
              children: [
                CustomTextField(
                  label: "Urine Output (mL/day)",
                  hint: "e.g. 450",
                  controller: _controllers["urine_output_ml_day"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Urine ACR (mg/g)",
                  hint: "e.g. 280",
                  controller: _controllers["urine_albumin_creatinine_ratio_mg_g"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Proteinuria",
                  hint: "Yes/No",
                  controller: _controllers["urine_proteinuria"],
                ),
              ],
            ),

            // 8. Vascular Access
            CustomExpansionTile(
              title: "Vascular Access",
              icon: Icons.accessibility_new_outlined,
              children: [
                CustomTextField(
                  label: "Access Flow Adequate",
                  hint: "Yes/No",
                  controller: _controllers["access_flow_adequate"],
                ),
                CustomTextField(
                  label: "Access Infection",
                  hint: "Yes/No",
                  controller: _controllers["access_infection"],
                ),
                CustomTextField(
                  label: "Thrombosis History",
                  hint: "Yes/No",
                  controller: _controllers["access_thrombosis_history"],
                ),
              ],
            ),

            // 9. Dialysis Complications
            CustomExpansionTile(
              title: "Dialysis Complications",
              icon: Icons.warning_amber_outlined,
              children: [
                CustomTextField(
                  label: "Dialysis Cramps",
                  hint: "Yes/No",
                  controller: _controllers["dialysis_cramps"],
                ),
                CustomTextField(
                  label: "Post-Dialysis Fatigue",
                  hint: "Yes/No",
                  controller: _controllers["post_dialysis_fatigue"],
                ),
                CustomTextField(
                  label: "Previous Hypotension During Dialysis",
                  hint: "Yes/No",
                  controller: _controllers["previous_hypotension_during_dialysis"],
                ),
              ],
            ),

            // 10. Lifestyle and Dietary
            CustomExpansionTile(
              title: "Lifestyle & Dietary Adherence",
              icon: Icons.medication_liquid_outlined,
              children: [
                CustomTextField(
                  label: "Alcohol Consumption",
                  hint: "None / Occasional / Frequent",
                  controller: _controllers["alcohol_use"],
                ),
                CustomTextField(
                  label: "Physical Activity",
                  hint: "Sedentary / Light / Moderate",
                  controller: _controllers["physical_activity"],
                ),
                CustomTextField(
                  label: "Daily Water Intake (L)",
                  hint: "e.g. 1.2",
                  controller: _controllers["daily_water_intake_liters"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Sleep Quality",
                  hint: "Good / Fair / Poor",
                  controller: _controllers["sleep_quality"],
                ),
                CustomTextField(
                  label: "Salt Intake",
                  hint: "Low / Medium / High",
                  controller: _controllers["salt_intake"],
                ),
                CustomTextField(
                  label: "Protein Intake (g/kg/day)",
                  hint: "e.g. 1.1",
                  controller: _controllers["protein_intake_g_kg_day"],
                  keyboardType: TextInputType.number,
                ),
                CustomTextField(
                  label: "Potassium-Rich Food Intake",
                  hint: "Low / Medium / High",
                  controller: _controllers["potassium_rich_food_intake"],
                ),
                CustomTextField(
                  label: "Fluid Restriction Adherence",
                  hint: "Good / Fair / Poor",
                  controller: _controllers["fluid_restriction_adherence"],
                ),
                CustomTextField(
                  label: "Smoking Status",
                  hint: "Yes/No",
                  controller: _controllers["smoking"],
                ),
              ],
            ),

            // 11. Symptoms & Medications
            CustomExpansionTile(
              title: "Symptoms & Medications",
              icon: Icons.medication_outlined,
              children: [
                CustomTextField(
                  label: "Symptoms",
                  hint: "Comma separated, e.g. fatigue, mild nausea",
                  controller: _controllers["symptoms"],
                ),
                CustomTextField(
                  label: "Current Medications",
                  hint: "Comma separated medications",
                  controller: _controllers["medications"],
                ),
                CustomTextField(
                  label: "Antihypertensive Adherence",
                  hint: "Good / Fair / Poor",
                  controller: _controllers["antihypertensive_medication_adherence"],
                ),
                CustomTextField(
                  label: "Chest Pain",
                  hint: "None / Exertional / At Rest",
                  controller: _controllers["chest_pain"],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                ),
                onPressed: isLoading ? null : _submitClinicalData,
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.whiteColor,
                        ),
                      )
                    : Text(
                        "Generate AI Recommendation",
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
