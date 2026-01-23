import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import '../config/app_config.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  // Save auth token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: AppConfig.tokenKey, value: token);
  }

  // Get auth token
  static Future<String?> getToken() async {
    return await _storage.read(key: AppConfig.tokenKey);
  }

  // Delete auth token
  static Future<void> deleteToken() async {
    await _storage.delete(key: AppConfig.tokenKey);
  }

  // Save user data
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.userKey, jsonEncode(user.toJson()));
  }

  // Get user data
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(AppConfig.userKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // Delete user data
  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.userKey);
  }

  // Save device ID
  static Future<void> saveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.deviceIdKey, deviceId);
  }

  // Get device ID
  static Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConfig.deviceIdKey);
  }

  // Clear all data (logout)
  static Future<void> clearAll() async {
    await deleteToken();
    await deleteUser();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
