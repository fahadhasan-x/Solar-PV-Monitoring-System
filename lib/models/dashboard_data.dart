import 'solar_data.dart';

class HourlyStats {
  final int hour;
  final double avgPower;
  final double avgLoad;
  final double avgBattery;

  HourlyStats({
    required this.hour,
    required this.avgPower,
    required this.avgLoad,
    required this.avgBattery,
  });

  factory HourlyStats.fromJson(Map<String, dynamic> json) {
    return HourlyStats(
      hour: json['_id'] ?? 0,
      avgPower: (json['avgPower'] ?? 0).toDouble(),
      avgLoad: (json['avgLoad'] ?? 0).toDouble(),
      avgBattery: (json['avgBattery'] ?? 0).toDouble(),
    );
  }
}

class DashboardData {
  final SolarData current;
  final List<HourlyStats> hourlyStats;

  DashboardData({
    required this.current,
    required this.hourlyStats,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      current: SolarData.fromJson(json['current'] ?? {}),
      hourlyStats: json['hourlyStats'] != null
          ? (json['hourlyStats'] as List)
              .map((stat) => HourlyStats.fromJson(stat))
              .toList()
          : [],
    );
  }
}
