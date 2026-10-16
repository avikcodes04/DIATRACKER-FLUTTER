class ApiEndpoints {
  ApiEndpoints._();

  // Auth Backend Base URL
  static const String authBaseUrl = "http://diatracker-1691823403.us-east-2.elb.amazonaws.com";

  // Auth Endpoints
  static const String login = "$authBaseUrl/auth/login";
  static const String signup = "$authBaseUrl/auth/signup";
  static const String confirm = "$authBaseUrl/auth/confirm";
  static const String me = "$authBaseUrl/auth/me";
  static const String refresh = "$authBaseUrl/auth/refresh";

  // Clinical & AI Backend Base URL
  static const String clinicalBaseUrl = "http://3.138.173.84:8000";

  // Patients & Recommendation Endpoints
  static const String patients = "$clinicalBaseUrl/patients";
  static const String recommend = "$clinicalBaseUrl/recommend";
}
