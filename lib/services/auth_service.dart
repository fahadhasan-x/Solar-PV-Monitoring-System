import '../services/api_service.dart';
import '../config/api_config.dart';
import '../models/auth_response.dart';
import '../models/user.dart';
import '../utils/secure_storage.dart';

class AuthService {
  // Login
  static Future<AuthResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await ApiService.post(
        ApiConfig.login,
        {
          'username': username,
          'password': password,
        },
      );

      final authResponse = AuthResponse.fromJson(response);

      // Save token and user data
      if (authResponse.success && authResponse.token != null) {
        await SecureStorage.saveToken(authResponse.token!);
        if (authResponse.user != null) {
          await SecureStorage.saveUser(authResponse.user!);
        }
      }

      return authResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  // Register
  static Future<AuthResponse> register({
    required String username,
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final response = await ApiService.post(
        ApiConfig.register,
        {
          'username': username,
          'email': email,
          'password': password,
          if (name != null) 'name': name,
        },
      );

      final authResponse = AuthResponse.fromJson(response);

      // Save token and user data
      if (authResponse.success && authResponse.token != null) {
        await SecureStorage.saveToken(authResponse.token!);
        if (authResponse.user != null) {
          await SecureStorage.saveUser(authResponse.user!);
        }
      }

      return authResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  // Get current user
  static Future<User> getCurrentUser() async {
    try {
      final response = await ApiService.get(ApiConfig.getMe);

      if (response['success'] && response['data'] != null) {
        return User.fromJson(response['data']['user']);
      } else {
        throw response['message'] ?? 'Failed to get user data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Logout
  static Future<void> logout() async {
    await SecureStorage.clearAll();
  }

  // Check if logged in
  static Future<bool> isLoggedIn() async {
    return await SecureStorage.isLoggedIn();
  }
}
