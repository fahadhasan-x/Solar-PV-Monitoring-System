class ApiConfig {
  // Base URL - Change this based on your environment
  static const String baseUrl = 'http://localhost:5000';
  static const String apiPrefix = '/api';
  
  // Full API URL
  static String get apiUrl => '$baseUrl$apiPrefix';
  
  // Auth endpoints
  static String get login => '$apiUrl/auth/login';
  static String get register => '$apiUrl/auth/register';
  static String get getMe => '$apiUrl/auth/me';
  
  // Solar endpoints
  static String getLatest(String deviceId) => '$apiUrl/solar/latest/$deviceId';
  static String getDashboard(String deviceId) => '$apiUrl/solar/dashboard/$deviceId';
  static String getHistory(String deviceId) => '$apiUrl/solar/history/$deviceId';
  static String getStats(String deviceId) => '$apiUrl/solar/stats/$deviceId';
  static String get addSolarData => '$apiUrl/solar/data';
  
  // Default device ID (can be configured per user)
  static const String defaultDeviceId = 'SOLAR_001';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
