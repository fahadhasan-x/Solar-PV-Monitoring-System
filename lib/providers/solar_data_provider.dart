import 'package:flutter/foundation.dart';
import 'dart:async';
import '../models/solar_data.dart';
import '../models/dashboard_data.dart';
import '../services/solar_service.dart';
import '../config/api_config.dart';

class SolarDataProvider with ChangeNotifier {
  DashboardData? _dashboardData;
  List<SolarData> _historyData = [];
  Map<String, dynamic>? _statistics;
  
  bool _isLoading = false;
  String? _error;
  
  Timer? _refreshTimer;
  String _deviceId = ApiConfig.defaultDeviceId;

  DashboardData? get dashboardData => _dashboardData;
  List<SolarData> get historyData => _historyData;
  Map<String, dynamic>? get statistics => _statistics;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get deviceId => _deviceId;

  // Set device ID
  void setDeviceId(String deviceId) {
    _deviceId = deviceId;
    notifyListeners();
  }

  // Fetch dashboard data
  Future<void> fetchDashboardData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _dashboardData = await SolarService.getDashboardData(_deviceId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch latest data only
  Future<void> fetchLatestData() async {
    try {
      final latestData = await SolarService.getLatestData(_deviceId);
      if (_dashboardData != null) {
        _dashboardData = DashboardData(
          current: latestData,
          hourlyStats: _dashboardData!.hourlyStats,
        );
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Fetch history data
  Future<void> fetchHistoryData({
    String? startDate,
    String? endDate,
    int limit = 100,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _historyData = await SolarService.getHistoryData(
        _deviceId,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch statistics
  Future<void> fetchStatistics({String period = 'today'}) async {
    try {
      _statistics = await SolarService.getStats(_deviceId, period: period);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Start auto refresh
  void startAutoRefresh({int intervalSeconds = 30}) {
    stopAutoRefresh(); // Stop any existing timer
    
    _refreshTimer = Timer.periodic(
      Duration(seconds: intervalSeconds),
      (timer) {
        fetchLatestData();
      },
    );
  }

  // Stop auto refresh
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  // Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([
      fetchDashboardData(),
      fetchStatistics(),
    ]);
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }
}
