class SolarPower {
  final double current;
  final double voltage;
  final double currentAmpere;

  SolarPower({
    required this.current,
    required this.voltage,
    required this.currentAmpere,
  });

  factory SolarPower.fromJson(Map<String, dynamic> json) {
    return SolarPower(
      current: (json['current'] ?? 0).toDouble(),
      voltage: (json['voltage'] ?? 0).toDouble(),
      currentAmpere: (json['current_ampere'] ?? 0).toDouble(),
    );
  }
}

class EnergyProduction {
  final double today;
  final double thisMonth;
  final double total;

  EnergyProduction({
    required this.today,
    required this.thisMonth,
    required this.total,
  });

  factory EnergyProduction.fromJson(Map<String, dynamic> json) {
    return EnergyProduction(
      today: (json['today'] ?? 0).toDouble(),
      thisMonth: (json['thisMonth'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }
}

class Battery {
  final double level;
  final double voltage;
  final bool charging;

  Battery({
    required this.level,
    required this.voltage,
    required this.charging,
  });

  factory Battery.fromJson(Map<String, dynamic> json) {
    return Battery(
      level: (json['level'] ?? 0).toDouble(),
      voltage: (json['voltage'] ?? 0).toDouble(),
      charging: json['charging'] ?? false,
    );
  }
}

class Grid {
  final String status;
  final double voltage;
  final double frequency;

  Grid({
    required this.status,
    required this.voltage,
    required this.frequency,
  });

  factory Grid.fromJson(Map<String, dynamic> json) {
    return Grid(
      status: json['status'] ?? 'offline',
      voltage: (json['voltage'] ?? 0).toDouble(),
      frequency: (json['frequency'] ?? 0).toDouble(),
    );
  }
}

class Load {
  final double power;
  final double today;

  Load({
    required this.power,
    required this.today,
  });

  factory Load.fromJson(Map<String, dynamic> json) {
    return Load(
      power: (json['power'] ?? 0).toDouble(),
      today: (json['today'] ?? 0).toDouble(),
    );
  }
}

class Inverter {
  final String status;
  final double temperature;
  final double efficiency;

  Inverter({
    required this.status,
    required this.temperature,
    required this.efficiency,
  });

  factory Inverter.fromJson(Map<String, dynamic> json) {
    return Inverter(
      status: json['status'] ?? 'standby',
      temperature: (json['temperature'] ?? 0).toDouble(),
      efficiency: (json['efficiency'] ?? 0).toDouble(),
    );
  }
}

class Weather {
  final double temperature;
  final double humidity;
  final double irradiance;
  final double cloudCover;

  Weather({
    required this.temperature,
    required this.humidity,
    required this.irradiance,
    required this.cloudCover,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: (json['temperature'] ?? 0).toDouble(),
      humidity: (json['humidity'] ?? 0).toDouble(),
      irradiance: (json['irradiance'] ?? 0).toDouble(),
      cloudCover: (json['cloudCover'] ?? 0).toDouble(),
    );
  }
}

class SystemStatus {
  final String status;
  final List<Alert> alerts;

  SystemStatus({
    required this.status,
    required this.alerts,
  });

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    return SystemStatus(
      status: json['status'] ?? 'normal',
      alerts: json['alerts'] != null
          ? (json['alerts'] as List).map((a) => Alert.fromJson(a)).toList()
          : [],
    );
  }
}

class Alert {
  final String type;
  final String message;
  final DateTime timestamp;

  Alert({
    required this.type,
    required this.message,
    required this.timestamp,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class SolarData {
  final String deviceId;
  final DateTime timestamp;
  final SolarPower solarPower;
  final EnergyProduction energyProduction;
  final Battery battery;
  final Grid grid;
  final Load load;
  final Inverter inverter;
  final Weather weather;
  final SystemStatus system;

  SolarData({
    required this.deviceId,
    required this.timestamp,
    required this.solarPower,
    required this.energyProduction,
    required this.battery,
    required this.grid,
    required this.load,
    required this.inverter,
    required this.weather,
    required this.system,
  });

  factory SolarData.fromJson(Map<String, dynamic> json) {
    return SolarData(
      deviceId: json['deviceId'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      solarPower: SolarPower.fromJson(json['solarPower'] ?? {}),
      energyProduction: EnergyProduction.fromJson(json['energyProduction'] ?? {}),
      battery: Battery.fromJson(json['battery'] ?? {}),
      grid: Grid.fromJson(json['grid'] ?? {}),
      load: Load.fromJson(json['load'] ?? {}),
      inverter: Inverter.fromJson(json['inverter'] ?? {}),
      weather: Weather.fromJson(json['weather'] ?? {}),
      system: SystemStatus.fromJson(json['system'] ?? {}),
    );
  }
}
