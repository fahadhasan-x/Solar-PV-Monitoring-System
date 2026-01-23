import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  // Check if user is already logged in
  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final loggedIn = await AuthService.isLoggedIn();
      if (loggedIn) {
        _user = await AuthService.getCurrentUser();
        _isAuthenticated = true;
      }
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await AuthService.login(
        username: username,
        password: password,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Register
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    String? name,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await AuthService.register(
        username: username,
        email: email,
        password: password,
        name: name,
      );

      if (response.success && response.user != null) {
        _user = response.user;
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isAuthenticated = false;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await AuthService.logout();
    _user = null;
    _isAuthenticated = false;
    _error = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
