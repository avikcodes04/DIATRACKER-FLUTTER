class Secrets {
  // Base URL
  static const String baseUrl = "http://diatracker-1691823403.us-east-2.elb.amazonaws.com";

  // Endpoints
  static const String login = "$baseUrl/auth/login";
  static const String signup = "$baseUrl/auth/signup";
  static const String confirm = "$baseUrl/auth/confirm";
  static const String me = "$baseUrl/auth/me";
  static const String refresh = "$baseUrl/auth/refresh";

}