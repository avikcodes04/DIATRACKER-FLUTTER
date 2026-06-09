import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_expansion_tile.dart';
import '../pallete.dart';
import 'package:google_fonts/google_fonts.dart';

class AiInputPage extends StatelessWidget {
  const AiInputPage({super.key});

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
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(label: "Patient Name"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Patient ID",
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Patient Age",
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Gender",
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(label: "Blood Group"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Occupation",
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(label: "Diagnosis"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis History",
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(label: "Dialysis Type"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(
                    label: "Dialysis Access Type",
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: CustomTextField(label: "Dialysis Date"),
                ),
              ],
            ),

            //Dialysis parameters expansion tile
            CustomExpansionTile(
              title: "Dialysis Metrics",
              icon: Icons.water_drop_outlined,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Kt/V"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "URR (%)"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Interdialytic Weight Gain (kg)",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Pulse (bpm)", hint: "e.g. 72"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Weight (kg)", hint: "e.g. 70"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Dry Weight (kg)",
                    hint: "Target dry weight",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "BMI", hint: "e.g. 25.0"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Body Temperature (°C)",
                    hint: "e.g. 37.0",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Respiratory Rate (breaths/min)",
                    hint: "e.g. 16",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Oxygen Saturation (%)"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Mental Status"),
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
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Pulmonary Edema",
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Pleural Effusion",
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Ascites", hint: "Yes/No"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Jugular Venous Distension",
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
                  child: CustomTextField(label: "Diabetes", hint: "Yes/No"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Hypertension", hint: "Yes/No"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Heart Disease",
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Heart Failure",
                    hint: "Yes/No",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Arrhythmia History",
                    hint: "Yes/No",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "eGFR (mL/min/1.73m²)",
                    hint: "e.g. 10.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "BUN (mg/dL)",
                    hint: "e.g. 9.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Sodium (mEq/L)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Potassium (mEq/L)",
                    hint: "e.g. 4.0",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum chloride (mEq/L)",
                    hint: "e.g. 9.0",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Calcium (mg/dL)",
                    hint: "e.g. 22",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Phosphate (mg/dL)",
                    hint: "e.g. 4.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Serum Bicarbonate (mEq/L)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Hemoglobin (g/dL)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Albumin (g/dL)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "PTH (pg/mL)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Blood Glucose (mg/dL)",
                    hint: "e.g. 3.5",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "HbA1c (%)", hint: "e.g. 3.5"),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "CRP (mg/L)", hint: "e.g. 3.5"),
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Urine ACR(mg/g)",
                    hint: "e.g. 30",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(label: "Proteinuria", hint: "yes/no"),
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Access Infection",
                    hint: "yes/no",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Thrombosis History",
                    hint: "yes/no",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Post-Dialysis Fatigue",
                    hint: "yes/no",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Previous Hypotension During Dialysis",
                    hint: "yes/no",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Physical Activity",
                    hint: "Frequency and type of exercise",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Daily Water Intake",
                    hint: "Amount",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Sleep Quality",
                    hint: "e.g. good, fair, poor",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Salt Intake",
                    hint: "low/medium/high",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Protein Intake",
                    hint: "low/medium/high",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Potassium-Rich Food Intake",
                    hint: "low/medium/high",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Fluid Restriction Adherence",
                    hint: "Not requires /good /fair/poor",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Smoking Status",
                    hint: "yes/no",
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Medication",
                    hint: "if not any then leave blank",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: CustomTextField(
                    label: "Antihypertensive Medication Adherence",
                    hint: "good/fair/poor",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Send all values to backend
                },
                child: const Text(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Pallete.accentColor,
                  ),
                  "Send to AI",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
