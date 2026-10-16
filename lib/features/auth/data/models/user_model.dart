class UserModel {
  final String username;
  final String email;
  final String name;
  final String? role;
  final String? hospital;
  final String? phone;

  const UserModel({
    required this.username,
    required this.email,
    required this.name,
    this.role = 'Nephrologist',
    this.hospital = 'City Kidney Care Center',
    this.phone = '+91 98765 43210',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: (json['username'] ?? json['user_name'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      name: (json['name'] ?? json['full_name'] ?? json['username'] ?? 'User') as String,
      role: (json['role'] ?? 'Nephrologist') as String,
      hospital: (json['hospital'] ?? 'City Kidney Care Center') as String,
      phone: (json['phone'] ?? '+91 98765 43210') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'name': name,
      'role': role,
      'hospital': hospital,
      'phone': phone,
    };
  }
}
