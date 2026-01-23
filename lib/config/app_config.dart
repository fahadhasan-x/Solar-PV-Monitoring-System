class AppConfig {
  // App information
  static const String appName = 'SCUBE Solar Monitoring';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String deviceIdKey = 'device_id';
  static const String rememberMeKey = 'remember_me';
  
  // Refresh intervals (in seconds)
  static const int dashboardRefreshInterval = 30; // 30 seconds
  static const int chartRefreshInterval = 60; // 1 minute
  
  // Pagination
  static const int defaultPageSize = 100;
  
  // Date formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'hh:mm a';
}
