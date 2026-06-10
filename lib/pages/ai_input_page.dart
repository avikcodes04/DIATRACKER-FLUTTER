import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_expansion_tile.dart';
import '../pallete.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'ai_result_page.dart';

class AiInputPage extends StatefulWidget {
  const AiInputPage({super.key});
  

  @override
  State<AiInputPage> createState() => _AiInputPageState(
  );
}

class _AiInputPageState extends State<AiInputPage> {
  bool _isLoading = false;
  final Map<String, TextEditingController> controllers = {
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

      "kt_v": TextEditingController(),
      "urr_percent": TextEditingController(),
      "interdialytic_weight_gain_kg": TextEditingController(),

      "fluid_overload": TextEditingController(),
      "pulmonary_edema": TextEditingController(),
      "pleural_effusion": TextEditingController(),
      "ascites": TextEditingController(),
      "jugular_venous_distension": TextEditingController(),

      "diabetes": TextEditingController(),
      "hypertension": TextEditingController(),
      "heart_disease": TextEditingController(),
      "heart_failure": TextEditingController(),
      "arrhythmia_history": TextEditingController(),

      "oxygen_saturation": TextEditingController(),
      "respiratory_distress": TextEditingController(),
      "mental_status": TextEditingController(),
      "confusion": TextEditingController(),

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

      "urine_albumin_creatinine_ratio_mg_g": TextEditingController(),
      "urine_proteinuria": TextEditingController(),
      "urine_output_ml_day": TextEditingController(),

      "vital_blood_pressure_mmhg": TextEditingController(),
      "vital_pulse_bpm": TextEditingController(),
      "vital_weight_kg": TextEditingController(),
      "dry_weight_kg": TextEditingController(),
      "bmi": TextEditingController(),
      "body_temperature_c": TextEditingController(),
      "respiratory_rate": TextEditingController(),

      "smoking": TextEditingController(),
      "alcohol_use": TextEditingController(),
      "physical_activity": TextEditingController(),
      "daily_water_intake_liters": TextEditingController(),
      "sleep_quality": TextEditingController(),
      "salt_intake": TextEditingController(),
      "protein_intake_g_kg_day": TextEditingController(),
      "potassium_rich_food_intake": TextEditingController(),
      "fluid_restriction_adherence": TextEditingController(),

      "dialysis_cramps": TextEditingController(),
      "post_dialysis_fatigue": TextEditingController(),
      "previous_hypotension_during_dialysis": TextEditingController(),

      "access_flow_adequate": TextEditingController(),
      "access_infection": TextEditingController(),
      "access_thrombosis_history": TextEditingController(),

      "chest_pain": TextEditingController(),

      "medications": TextEditingController(),
      "symptoms": TextEditingController(),
      "antihypertensive_medication_adherence": TextEditingController(),
    };

  @override
  void initState() {
    super.initState();

    
  }
  String? _str(String key) {
  final v = controllers[key]?.text.trim();
  return (v == null || v.isEmpty) ? null : v;
}

num? _num(String key) => num.tryParse(controllers[key]?.text.trim() ?? '');

bool? _bool(String key) {
  final v = controllers[key]?.text.trim().toLowerCase();
  if (v == 'yes' || v == 'true') return true;
  if (v == 'no' || v == 'false') return false;
  return null;
}
  Future<void> _sendToAI() async {
  const url = 'http://diatracker-1691823403.us-east-2.elb.amazonaws.com/recommend';

  // // Helper to parse a controller value, returning null if empty
  // String? _str(String key) {
  //   final v = controllers[key]?.text.trim();
  //   return (v == null || v.isEmpty) ? null : v;
  // }

  // num? _num(String key) => num.tryParse(controllers[key]?.text.trim() ?? '');

  // bool? _bool(String key) {
  //   final v = controllers[key]?.text.trim().toLowerCase();
  //   if (v == 'yes' || v == 'true') return true;
  //   if (v == 'no' || v == 'false') return false;
  //   return null;
  // }

  final body = {
    "patientId": _str("patientId"),
    "patient_name": _str("patient_name"),
    "patient_age": _num("patient_age"),
    "patient_gender": _str("patient_gender"),
    "blood_group": _str("blood_group"),
    "occupation": _str("occupation"),
    "diagnosis": _str("diagnosis"),
    "dialysis_history": _str("dialysis_history"),
    "dialysis_type": _str("dialysis_type"),
    "dialysis_access_type": _str("dialysis_access_type"),
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

    // The API expects arrays for these two
    "medications": _str("medications")
        ?.split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList() ?? [],
    "symptoms": _str("symptoms")
        ?.split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList() ?? ["No symptoms"],
  };
  setState(() {
    _isLoading = true;
  });
  try {
    debugPrint(jsonEncode(body));
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
      
    );
  if(!mounted) return;
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);

      debugPrint('Success: $result');
      Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AiResultPage(result: result),
    ),
  );
    } else {
      debugPrint('Error ${response.statusCode}: ${response.body}');
      // TODO: show a SnackBar with the error
    }
  } catch (e) {
    debugPrint('Network error: $e');
    // TODO: show a SnackBar for connectivity issues
  }finally{
    if(mounted){
      setState(() {
        _isLoading = false;
      });
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: GoogleFonts.comfortaa(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Pallete.accentColor,
          ),
          "AI Analysis",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //patient information expansion tile
            CustomExpansionTile(
              icon: Icons.person_outline,
              title: "Patient Information",
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Patient Name",
                    controller: controllers["patient_name"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Patient ID",
                    keyboardType: TextInputType.text,
                    controller: controllers["patientId"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Patient Age",
                    keyboardType: TextInputType.number,
                    controller: controllers["patient_age"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Gender",
                    keyboardType: TextInputType.text,
                    controller: controllers["patient_gender"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Blood Group",
                    controller: controllers["blood_group"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Occupation",
                    keyboardType: TextInputType.text,
                    controller: controllers["occupation"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Diagnosis",
                    controller: controllers["diagnosis"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis History",
                    keyboardType: TextInputType.text,
                    controller: controllers["dialysis_history"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis Type",
                    controller: controllers["dialysis_type"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis Access Type",
                    keyboardType: TextInputType.text,
                    controller: controllers["dialysis_access_type"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis Date",
                    controller: controllers["last_dialysis_date"],
                  ),
                ),
              ],
            ),

            //Dialysis parameters expansion tile
            CustomExpansionTile(
              title: "Dialysis Metrics",
              icon: Icons.water_drop_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Kt/V",
                    hint: "e.g. 1.2",
                    controller: controllers["kt_v"],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "URR (%)",
                    hint: "e.g. 65",
                    controller: controllers["urr_percent"],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Interdialytic Weight Gain (kg)",
                    hint: "e.g. 2.5",
                    controller: controllers["interdialytic_weight_gain_kg"],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            CustomExpansionTile(
              title: "Vital Signs",
              icon: Icons.monitor_heart_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Blood Pressure (mmHg)",
                    hint: "e.g. 120/80",
                    controller: controllers["vital_blood_pressure_mmhg"],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Pulse (bpm)",
                    hint: "e.g. 72",
                    controller: controllers["vital_pulse_bpm"],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Weight (kg)",
                    hint: "e.g. 70",
                    controller: controllers["vital_weight_kg"],
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Dry Weight (kg)",
                    controller: controllers["dry_weight_kg"],
                    hint: "Target dry weight",
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "BMI",
                    hint: "e.g. 25.0",
                    controller: controllers["bmi"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Body Temperature (°C)",
                    hint: "e.g. 37.0",
                    controller: controllers["body_temperature_c"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Respiratory Rate (breaths/min)",
                    hint: "e.g. 16",
                    controller: controllers["respiratory_rate"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Oxygen Saturation (%)",
                    controller: controllers["oxygen_saturation"],
                    hint: "e.g. 98",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Mental Status",
                    controller: controllers["mental_status"],
                    hint: "e.g. alert, confused",
                  ),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "  Fluid Status",
              icon: Icons.science_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Fluid Overload",
                    controller: controllers["fluid_overload"],
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Pulmonary Edema",
                    controller: controllers["pulmonary_edema"],
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Pleural Effusion",
                    controller: controllers["pleural_effusion"],
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Ascites",
                    controller: controllers["ascites"],
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Jugular Venous Distension",
                    controller: controllers["jugular_venous_distension"],
                    hint: "Yes/No",
                  ),
                ),
              ],
            ),

            CustomExpansionTile(
              title: " Comorbidities",
              icon: Icons.medical_services_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Diabetes",
                    hint: "Yes/No",
                    controller: controllers["diabetes"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Hypertension",
                    hint: "Yes/No",
                    controller: controllers["hypertension"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Heart Disease",
                    hint: "Yes/No",
                    controller: controllers["heart_disease"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Heart Failure",
                    hint: "Yes/No",
                    controller: controllers["heart_failure"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Arrhythmia History",
                    hint: "Yes/No",
                    controller: controllers["arrhythmia_history"],
                  ),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "Laboratory Values",
              icon: Icons.biotech_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Creatinine (mg/dL)",
                    hint: "Yes/No",
                    controller: controllers["lab_serum_creatinine_mg_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "eGFR (mL/min/1.73m²)",
                    hint: "e.g. 10.5",
                    controller: controllers["lab_egfr_ml_min_1_73m2"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "BUN (mg/dL)",
                    hint: "e.g. 9.5",
                    controller: controllers["lab_bun_mg_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Sodium (mEq/L)",
                    hint: "e.g. 3.5",
                    keyboardType: TextInputType.number,
                    controller: controllers["lab_serum_sodium_meq_l"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Potassium (mEq/L)",
                    hint: "e.g. 4.0",
                    controller: controllers["lab_serum_potassium_meq_l"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum chloride (mEq/L)",
                    hint: "e.g. 9.0",
                    controller: controllers["lab_serum_chloride_meq_l"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Calcium (mg/dL)",
                    hint: "e.g. 22",
                    controller: controllers["lab_serum_calcium_mg_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Phosphate (mg/dL)",
                    hint: "e.g. 4.5",
                    controller: controllers["lab_serum_phosphate_mg_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Bicarbonate (mEq/L)",
                    hint: "e.g. 3.5",
                    controller: controllers["lab_serum_bicarbonate_meq_l"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Hemoglobin (g/dL)",
                    hint: "e.g. 3.5",
                    controller: controllers["lab_hemoglobin_g_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Albumin (g/dL)",
                    hint: "e.g. 3.5",
                    controller: controllers["lab_albumin_g_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "PTH (pg/mL)",
                    hint: "e.g. 3.5",
                    controller: controllers["lab_pth_pg_ml"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Blood Glucose (mg/dL)",
                    hint: "e.g. 3.5",
                    controller: controllers["blood_glucose_mg_dl"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "HbA1c (%)", hint: "e.g. 3.5",controller: controllers["hba1c_percent"]),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "CRP (mg/L)", hint: "e.g. 3.5",controller: controllers["crp_mg_l"]),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "Urine Output",
              icon: Icons.local_drink_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Urine Output (mL/day)",
                    hint: "e.g. 500",
                    controller: controllers["urine_output_ml_day"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Urine ACR(mg/g)",
                    hint: "e.g. 30",
                    controller: controllers["urine_albumin_creatinine_ratio_mg_g"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Proteinuria", hint: "yes/no",controller: controllers["urine_proteinuria"]),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "Vascular Access",
              icon: Icons.accessibility_new_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Access Flow Adequete",
                    hint: "yes/no",
                    controller: controllers["access_flow_adequate"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Access Infection",
                    hint: "yes/no",
                    controller: controllers["access_infection"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Thrombosis History",
                    hint: "yes/no",
                    controller: controllers["access_thrombosis_history"],
                  ),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "Dialysis Complications",
              icon: Icons.warning_amber_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Dialysis Cramps",
                    hint: "yes/no",
                    controller: controllers["dialysis_cramps"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Post-Dialysis Fatigue",
                    hint: "yes/no",
                    controller: controllers["post_dialysis_fatigue"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Previous Hypotension During Dialysis",
                    hint: "yes/no",
                    controller: controllers["previous_hypotension_during_dialysis"],
                  ),
                ),
              ],
            ),

            CustomExpansionTile(
              title: "Lifestyle and Dietary",
              icon: Icons.medication_liquid_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Alcohol Consumption",
                    hint: "Frequency of consumption",
                    controller: controllers["alcohol_use"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Physical Activity",
                    hint: "Frequency and type of exercise",
                    controller: controllers["physical_activity"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Daily Water Intake",
                    hint: "Amount",
                    controller: controllers["daily_water_intake_liters"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Sleep Quality",
                    hint: "e.g. good, fair, poor",
                    controller: controllers["sleep_quality"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Salt Intake",
                    hint: "low/medium/high",
                    controller: controllers["salt_intake"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Protein Intake",
                    hint: "low/medium/high",
                    controller: controllers["protein_intake_g_kg_day"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Potassium-Rich Food Intake",
                    hint: "low/medium/high",
                    controller: controllers["potassium_rich_food_intake"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Fluid Restriction Adherence",
                    hint: "Not requires /good /fair/poor",
                    controller: controllers["fluid_restriction_adherence"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Smoking Status",
                    hint: "yes/no",
                    controller: controllers["smoking"],
                  ),
                ),
              ],
            ),
            CustomExpansionTile(
              title: "Symptoms and Medications",
              icon: Icons.medication_outlined,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Symptoms",
                    hint: "e.g. fatigue, nausea, shortness of breath",
                    controller: controllers["symptoms"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Medication",
                    hint: "if not any then leave blank",
                    controller: controllers["medications"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Antihypertensive Medication Adherence",
                    hint: "good/fair/poor",
                    controller: controllers["antihypertensive_medication_adherence"],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Chest Pain",
                    hint: "good/fair/poor",
                    controller: controllers["chest_pain"],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: _sendToAI,
            //     child: const Text(
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Pallete.accentColor,
            //       ),
            //       "Send to AI",
            //     ),
            //   ),
            // ),
            SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: _sendToAI,
    child: _isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Pallete.accentColor,
            ),
          )
        : Text(
            "Send to AI",
            style: GoogleFonts.lato(
              fontSize:20,
              fontWeight: FontWeight.w900,
              color: Pallete.accentColor,
            ),
          ),
  ),
),
SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
