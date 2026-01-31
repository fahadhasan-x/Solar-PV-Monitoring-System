const SolarData = require('../models/SolarData.model');
const { Op, fn, col, literal } = require('sequelize');
const { sequelize } = require('../config/database');

// @desc    Get latest solar data
// @route   GET /api/solar/latest/:deviceId
// @access  Private
const getLatestData = async (req, res) => {
  try {
    const { deviceId } = req.params;

    const data = await SolarData.findOne({
      where: { deviceId },
      order: [['timestamp', 'DESC']]
    });

    if (!data) {
      return res.status(404).json({
        success: false,
        message: 'No data found for this device'
      });
    }

    res.status(200).json({
      success: true,
      data: data.toNestedJSON()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message || 'Server Error'
    });
  }
};

// @desc    Get solar data history
// @route   GET /api/solar/history/:deviceId
// @access  Private
const getDataHistory = async (req, res) => {
  try {
    const { deviceId } = req.params;
    const { startDate, endDate, limit = 100 } = req.query;

    let where = { deviceId };

    // Add date range if provided
    if (startDate || endDate) {
      where.timestamp = {};
      if (startDate) where.timestamp[Op.gte] = new Date(startDate);
      if (endDate) where.timestamp[Op.lte] = new Date(endDate);
    }

    const data = await SolarData.findAll({
      where,
      order: [['timestamp', 'DESC']],
      limit: parseInt(limit)
    });

    res.status(200).json({
      success: true,
      count: data.length,
      data: data.map(d => d.toNestedJSON())
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message || 'Server Error'
    });
  }
};

// @desc    Add new solar data
// @route   POST /api/solar/data
// @access  Private
const addSolarData = async (req, res) => {
  try {
    // Convert nested object to flat structure
    const flatData = {
      deviceId: req.body.deviceId,
      timestamp: req.body.timestamp || new Date(),
      solarPowerCurrent: req.body.solarPower?.current || 0,
      solarPowerVoltage: req.body.solarPower?.voltage || 0,
      solarPowerCurrentAmpere: req.body.solarPower?.current_ampere || 0,
      energyProductionToday: req.body.energyProduction?.today || 0,
      energyProductionThisMonth: req.body.energyProduction?.thisMonth || 0,
      energyProductionTotal: req.body.energyProduction?.total || 0,
      batteryLevel: req.body.battery?.level || 0,
      batteryVoltage: req.body.battery?.voltage || 0,
      batteryCharging: req.body.battery?.charging || false,
      gridStatus: req.body.grid?.status || 'online',
      gridVoltage: req.body.grid?.voltage || 0,
      gridFrequency: req.body.grid?.frequency || 0,
      loadPower: req.body.load?.power || 0,
      loadToday: req.body.load?.today || 0,
      inverterStatus: req.body.inverter?.status || 'normal',
      inverterTemperature: req.body.inverter?.temperature || 0,
      inverterEfficiency: req.body.inverter?.efficiency || 0,
      weatherTemperature: req.body.weather?.temperature || 0,
      weatherHumidity: req.body.weather?.humidity || 0,
      weatherIrradiance: req.body.weather?.irradiance || 0,
      weatherCloudCover: req.body.weather?.cloudCover || 0,
      systemStatus: req.body.system?.status || 'normal',
      systemAlerts: req.body.system?.alerts || []
    };

    const solarData = await SolarData.create(flatData);

    res.status(201).json({
      success: true,
      message: 'Solar data added successfully',
      data: solarData.toNestedJSON()
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message || 'Server Error'
    });
  }
};

// @desc    Get statistics for a device
// @route   GET /api/solar/stats/:deviceId
// @access  Private
const getStatistics = async (req, res) => {
  try {
    const { deviceId } = req.params;
    const { period = 'today' } = req.query;

    let startDate;
    const now = new Date();

    // Determine date range based on period
    switch (period) {
      case 'today':
        startDate = new Date(now.setHours(0, 0, 0, 0));
        break;
      case 'week':
        startDate = new Date(now.setDate(now.getDate() - 7));
        break;
      case 'month':
        startDate = new Date(now.setMonth(now.getMonth() - 1));
        break;
      default:
        startDate = new Date(now.setHours(0, 0, 0, 0));
    }

    const stats = await SolarData.findAll({
      where: {
        deviceId,
        timestamp: { [Op.gte]: startDate }
      },
      attributes: [
        [fn('AVG', col('solar_power_current')), 'avgPower'],
        [fn('MAX', col('solar_power_current')), 'maxPower'],
        [fn('MIN', col('solar_power_current')), 'minPower'],
        [fn('SUM', col('energy_production_today')), 'totalEnergy'],
        [fn('AVG', col('battery_level')), 'avgBatteryLevel'],
        [fn('AVG', col('weather_temperature')), 'avgTemperature'],
        [fn('COUNT', col('id')), 'count']
      ],
      raw: true
    });

    res.status(200).json({
      success: true,
      period,
      data: stats.length > 0 ? stats[0] : {}
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message || 'Server Error'
    });
  }
};

// @desc    Get real-time dashboard data
// @route   GET /api/solar/dashboard/:deviceId
// @access  Private
const getDashboardData = async (req, res) => {
  try {
    const { deviceId } = req.params;

    // Get latest data
    const latestData = await SolarData.findOne({
      where: { deviceId },
      order: [['timestamp', 'DESC']]
    });

    if (!latestData) {
      return res.status(404).json({
        success: false,
        message: 'No data found for this device'
      });
    }

    // Get today's hourly data for charts
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const hourlyData = await sequelize.query(
      `SELECT 
        EXTRACT(HOUR FROM timestamp) as hour,
        AVG(solar_power_current) as "avgPower",
        AVG(load_power) as "avgLoad",
        AVG(battery_level) as "avgBattery"
      FROM solar_data
      WHERE "deviceId" = :deviceId AND timestamp >= :today
      GROUP BY EXTRACT(HOUR FROM timestamp)
      ORDER BY hour ASC`,
      {
        replacements: { deviceId, today },
        type: sequelize.QueryTypes.SELECT
      }
    );

    res.status(200).json({
      success: true,
      data: {
        current: latestData.toNestedJSON(),
        hourlyStats: hourlyData.map(h => ({
          _id: parseInt(h.hour),
          avgPower: parseFloat(h.avgPower || 0),
          avgLoad: parseFloat(h.avgLoad || 0),
          avgBattery: parseFloat(h.avgBattery || 0)
        }))
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message || 'Server Error'
    });
  }
};

module.exports = {
  getLatestData,
  getDataHistory,
  addSolarData,
  getStatistics,
  getDashboardData
};
