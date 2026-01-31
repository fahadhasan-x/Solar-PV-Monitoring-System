const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/database');

const SolarData = sequelize.define('SolarData', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  deviceId: {
    type: DataTypes.STRING(100),
    allowNull: false,
    index: true
  },
  timestamp: {
    type: DataTypes.DATE,
    defaultValue: DataTypes.NOW,
    allowNull: false,
    index: true
  },
  // Solar Panel Metrics
  solarPowerCurrent: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'solar_power_current'
  },
  solarPowerVoltage: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'solar_power_voltage'
  },
  solarPowerCurrentAmpere: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'solar_power_current_ampere'
  },
  // Energy Production
  energyProductionToday: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'energy_production_today'
  },
  energyProductionThisMonth: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'energy_production_this_month'
  },
  energyProductionTotal: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'energy_production_total'
  },
  // Battery Status
  batteryLevel: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    validate: {
      min: 0,
      max: 100
    },
    field: 'battery_level'
  },
  batteryVoltage: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'battery_voltage'
  },
  batteryCharging: {
    type: DataTypes.BOOLEAN,
    defaultValue: false,
    field: 'battery_charging'
  },
  // Grid Status
  gridStatus: {
    type: DataTypes.ENUM('online', 'offline'),
    defaultValue: 'online',
    field: 'grid_status'
  },
  gridVoltage: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'grid_voltage'
  },
  gridFrequency: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    field: 'grid_frequency'
  },
  // Load/Consumption
  loadPower: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'load_power'
  },
  loadToday: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'load_today'
  },
  // Inverter Status
  inverterStatus: {
    type: DataTypes.ENUM('normal', 'fault', 'standby'),
    defaultValue: 'normal',
    field: 'inverter_status'
  },
  inverterTemperature: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    field: 'inverter_temperature'
  },
  inverterEfficiency: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    validate: {
      min: 0,
      max: 100
    },
    field: 'inverter_efficiency'
  },
  // Weather Data
  weatherTemperature: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    field: 'weather_temperature'
  },
  weatherHumidity: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    field: 'weather_humidity'
  },
  weatherIrradiance: {
    type: DataTypes.DECIMAL(10, 2),
    defaultValue: 0,
    field: 'weather_irradiance'
  },
  weatherCloudCover: {
    type: DataTypes.DECIMAL(5, 2),
    defaultValue: 0,
    field: 'weather_cloud_cover'
  },
  // System Status
  systemStatus: {
    type: DataTypes.ENUM('normal', 'warning', 'error'),
    defaultValue: 'normal',
    field: 'system_status'
  },
  systemAlerts: {
    type: DataTypes.JSONB,
    defaultValue: [],
    field: 'system_alerts'
  }
}, {
  timestamps: true,
  tableName: 'solar_data',
  indexes: [
    {
      fields: ['deviceId', 'timestamp']
    },
    {
      fields: ['deviceId']
    },
    {
      fields: ['timestamp']
    }
  ]
});

// Helper method to convert to nested object format (for backward compatibility)
SolarData.prototype.toNestedJSON = function() {
  return {
    id: this.id,
    deviceId: this.deviceId,
    timestamp: this.timestamp,
    solarPower: {
      current: parseFloat(this.solarPowerCurrent || 0),
      voltage: parseFloat(this.solarPowerVoltage || 0),
      current_ampere: parseFloat(this.solarPowerCurrentAmpere || 0)
    },
    energyProduction: {
      today: parseFloat(this.energyProductionToday || 0),
      thisMonth: parseFloat(this.energyProductionThisMonth || 0),
      total: parseFloat(this.energyProductionTotal || 0)
    },
    battery: {
      level: parseFloat(this.batteryLevel || 0),
      voltage: parseFloat(this.batteryVoltage || 0),
      charging: this.batteryCharging
    },
    grid: {
      status: this.gridStatus,
      voltage: parseFloat(this.gridVoltage || 0),
      frequency: parseFloat(this.gridFrequency || 0)
    },
    load: {
      power: parseFloat(this.loadPower || 0),
      today: parseFloat(this.loadToday || 0)
    },
    inverter: {
      status: this.inverterStatus,
      temperature: parseFloat(this.inverterTemperature || 0),
      efficiency: parseFloat(this.inverterEfficiency || 0)
    },
    weather: {
      temperature: parseFloat(this.weatherTemperature || 0),
      humidity: parseFloat(this.weatherHumidity || 0),
      irradiance: parseFloat(this.weatherIrradiance || 0),
      cloudCover: parseFloat(this.weatherCloudCover || 0)
    },
    system: {
      status: this.systemStatus,
      alerts: this.systemAlerts || []
    },
    createdAt: this.createdAt,
    updatedAt: this.updatedAt
  };
};

module.exports = SolarData;
