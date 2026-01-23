const mongoose = require('mongoose');

const solarDataSchema = new mongoose.Schema({
  deviceId: {
    type: String,
    required: true,
    index: true
  },
  timestamp: {
    type: Date,
    default: Date.now,
    index: true
  },
  // Solar Panel Metrics
  solarPower: {
    current: { type: Number, default: 0 }, // Current power in kW
    voltage: { type: Number, default: 0 }, // Voltage in V
    current_ampere: { type: Number, default: 0 }, // Current in A
  },
  // Energy Production
  energyProduction: {
    today: { type: Number, default: 0 }, // kWh
    thisMonth: { type: Number, default: 0 }, // kWh
    total: { type: Number, default: 0 } // kWh
  },
  // Battery Status
  battery: {
    level: { type: Number, default: 0, min: 0, max: 100 }, // Percentage
    voltage: { type: Number, default: 0 },
    charging: { type: Boolean, default: false }
  },
  // Grid Status
  grid: {
    status: { type: String, enum: ['online', 'offline'], default: 'online' },
    voltage: { type: Number, default: 0 },
    frequency: { type: Number, default: 0 }
  },
  // Load/Consumption
  load: {
    power: { type: Number, default: 0 }, // Current load in kW
    today: { type: Number, default: 0 }, // kWh consumed today
  },
  // Inverter Status
  inverter: {
    status: { type: String, enum: ['normal', 'fault', 'standby'], default: 'normal' },
    temperature: { type: Number, default: 0 },
    efficiency: { type: Number, default: 0, min: 0, max: 100 }
  },
  // Weather Data
  weather: {
    temperature: { type: Number, default: 0 }, // Celsius
    humidity: { type: Number, default: 0 }, // Percentage
    irradiance: { type: Number, default: 0 }, // W/m²
    cloudCover: { type: Number, default: 0 } // Percentage
  },
  // System Status
  system: {
    status: { type: String, enum: ['normal', 'warning', 'error'], default: 'normal' },
    alerts: [{ 
      type: { type: String },
      message: { type: String },
      timestamp: { type: Date, default: Date.now }
    }]
  }
}, {
  timestamps: true
});

// Index for efficient queries
solarDataSchema.index({ deviceId: 1, timestamp: -1 });

module.exports = mongoose.model('SolarData', solarDataSchema);
