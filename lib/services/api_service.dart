import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import '../utils/secure_storage.dart';

class ApiService {
  // GET request
  static Future<Map<String, dynamic>> get(String url) async {
    try {
      final token = await SecureStorage.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  static Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  static Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await SecureStorage.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .put(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  static Future<Map<String, dynamic>> delete(String url) async {
    try {
      final token = await SecureStorage.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(ApiConfig.connectionTimeout);

      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      throw ApiException(
        statusCode: response.statusCode,
        message: body['message'] ?? 'Something went wrong',
      );
    }
  }

  // Handle errors
  static String _handleError(dynamic error) {
    if (error is ApiException) {
      return error.message;
    } else if (error.toString().contains('TimeoutException')) {
      return 'Connection timeout. Please check your internet connection.';
    } else if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network.';
    } else {
      return 'An unexpected error occurred: ${error.toString()}';
    }
  }
}

// Custom exception class
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  String toString() => message;
}
