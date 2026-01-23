class User {
  final String id;
  final String username;
  final String email;
  final String? name;
  final String role;
  final bool isActive;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.name,
    required this.role,
    required this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      role: json['role'] ?? 'user',
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'name': name,
      'role': role,
      'isActive': isActive,
    };
  }
}
