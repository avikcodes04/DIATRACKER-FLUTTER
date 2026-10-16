class LoginResponse {
  final String message;
  final String tokenType;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String username;

  const LoginResponse({
    required this.message,
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.username,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: (json["message"] ?? "") as String,
      tokenType: (json["token_type"] ?? "bearer") as String,
      accessToken: (json["access_token"] ?? "") as String,
      refreshToken: (json["refresh_token"] ?? "") as String,
      expiresIn: (json["expires_in"] ?? 0) as int,
      username: (json["username"] ?? "") as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "token_type": tokenType,
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "expires_in": expiresIn,
      "username": username,
    };
  }

  @override
  String toString() {
    return 'LoginResponse(username: $username)';
  }
}
