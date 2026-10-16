class PatientModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String diagnosis;
  final String lastVisit;
  final String status;
  final Map<String, dynamic>? rawData;

  const PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.diagnosis,
    required this.lastVisit,
    required this.status,
    this.rawData,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    final egfr = (json['eGFR'] ?? json['egfr'] ?? 999) as num;
    final diag = (json['diagnosis'] ?? '').toString().toLowerCase();

    String status = 'Stable';
    if (egfr < 15 || diag.contains('esrd') || diag.contains('stage 5')) {
      status = 'Critical';
    } else if (egfr < 30 || diag.contains('stage 4')) {
      status = 'Moderate';
    }

    String formattedDate = 'N/A';
    final storedAt = json['stored_at'] ?? json['last_visit'];
    if (storedAt != null) {
      try {
        final dt = DateTime.parse(storedAt.toString()).toLocal();
        const months = [
          'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        formattedDate = "${dt.day} ${months[dt.month - 1]} ${dt.year}";
      } catch (_) {
        formattedDate = storedAt.toString().split('T').first;
      }
    }

    return PatientModel(
      id: (json['patientId'] ?? json['patient_id'] ?? json['id'] ?? '-').toString(),
      name: (json['patient_name'] ?? json['name'] ?? 'Unknown').toString(),
      age: ((json['patient_age'] ?? json['age'] ?? 0) as num).toInt(),
      gender: (json['patient_gender'] ?? json['gender'] ?? '-').toString(),
      diagnosis: (json['diagnosis'] ?? '-').toString(),
      lastVisit: formattedDate,
      status: status,
      rawData: json,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'diagnosis': diagnosis,
      'lastVisit': lastVisit,
      'status': status,
    };
  }
}
