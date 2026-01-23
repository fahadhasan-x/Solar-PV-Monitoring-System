import 'user.dart';

class AuthResponse {
  final bool success;
  final String message;
  final User? user;
  final String? token;

  AuthResponse({
    required this.success,
    required this.message,
    this.user,
    this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['data'] != null && json['data']['user'] != null
          ? User.fromJson(json['data']['user'])
          : null,
      token: json['data'] != null ? json['data']['token'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {
        'user': user?.toJson(),
        'token': token,
      },
    };
  }
}
