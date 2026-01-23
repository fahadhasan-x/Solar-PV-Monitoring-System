import '../services/api_service.dart';
import '../config/api_config.dart';
import '../models/solar_data.dart';
import '../models/dashboard_data.dart';

class SolarService {
  // Get latest solar data
  static Future<SolarData> getLatestData(String deviceId) async {
    try {
      final response = await ApiService.get(ApiConfig.getLatest(deviceId));

      if (response['success'] && response['data'] != null) {
        return SolarData.fromJson(response['data']);
      } else {
        throw response['message'] ?? 'Failed to get solar data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Get dashboard data
  static Future<DashboardData> getDashboardData(String deviceId) async {
    try {
      final response = await ApiService.get(ApiConfig.getDashboard(deviceId));

      if (response['success'] && response['data'] != null) {
        return DashboardData.fromJson(response['data']);
      } else {
        throw response['message'] ?? 'Failed to get dashboard data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Get historical data
  static Future<List<SolarData>> getHistoryData(
    String deviceId, {
    String? startDate,
    String? endDate,
    int limit = 100,
  }) async {
    try {
      String url = '${ApiConfig.getHistory(deviceId)}?limit=$limit';
      if (startDate != null) url += '&startDate=$startDate';
      if (endDate != null) url += '&endDate=$endDate';

      final response = await ApiService.get(url);

      if (response['success'] && response['data'] != null) {
        final List<dynamic> dataList = response['data'];
        return dataList.map((json) => SolarData.fromJson(json)).toList();
      } else {
        throw response['message'] ?? 'Failed to get history data';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Get statistics
  static Future<Map<String, dynamic>> getStats(
    String deviceId, {
    String period = 'today',
  }) async {
    try {
      final url = '${ApiConfig.getStats(deviceId)}?period=$period';
      final response = await ApiService.get(url);

      if (response['success'] && response['data'] != null) {
        return response['data'];
      } else {
        throw response['message'] ?? 'Failed to get statistics';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Add solar data (for testing/simulation)
  static Future<SolarData> addSolarData(Map<String, dynamic> data) async {
    try {
      final response = await ApiService.post(ApiConfig.addSolarData, data);

      if (response['success'] && response['data'] != null) {
        return SolarData.fromJson(response['data']);
      } else {
        throw response['message'] ?? 'Failed to add solar data';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
