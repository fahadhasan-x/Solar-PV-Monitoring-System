const SolarData = require('../models/SolarData.model');

// @desc    Get latest solar data
// @route   GET /api/solar/latest/:deviceId
// @access  Private
const getLatestData = async (req, res) => {
  try {
    const { deviceId } = req.params;

    const data = await SolarData.findOne({ deviceId })
      .sort({ timestamp: -1 })
      .limit(1);

    if (!data) {
      return res.status(404).json({
        success: false,
        message: 'No data found for this device'
      });
    }

    res.status(200).json({
      success: true,
      data
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

    let query = { deviceId };

    // Add date range if provided
    if (startDate || endDate) {
      query.timestamp = {};
      if (startDate) query.timestamp.$gte = new Date(startDate);
      if (endDate) query.timestamp.$lte = new Date(endDate);
    }

    const data = await SolarData.find(query)
      .sort({ timestamp: -1 })
      .limit(parseInt(limit));

    res.status(200).json({
      success: true,
      count: data.length,
      data
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
    const solarData = await SolarData.create(req.body);

    res.status(201).json({
      success: true,
      message: 'Solar data added successfully',
      data: solarData
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

    const stats = await SolarData.aggregate([
      {
        $match: {
          deviceId,
          timestamp: { $gte: startDate }
        }
      },
      {
        $group: {
          _id: null,
          avgPower: { $avg: '$solarPower.current' },
          maxPower: { $max: '$solarPower.current' },
          minPower: { $min: '$solarPower.current' },
          totalEnergy: { $sum: '$energyProduction.today' },
          avgBatteryLevel: { $avg: '$battery.level' },
          avgTemperature: { $avg: '$weather.temperature' },
          count: { $sum: 1 }
        }
      }
    ]);

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
    const latestData = await SolarData.findOne({ deviceId })
      .sort({ timestamp: -1 })
      .limit(1);

    if (!latestData) {
      return res.status(404).json({
        success: false,
        message: 'No data found for this device'
      });
    }

    // Get today's hourly data for charts
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const hourlyData = await SolarData.aggregate([
      {
        $match: {
          deviceId,
          timestamp: { $gte: today }
        }
      },
      {
        $group: {
          _id: { $hour: '$timestamp' },
          avgPower: { $avg: '$solarPower.current' },
          avgLoad: { $avg: '$load.power' },
          avgBattery: { $avg: '$battery.level' }
        }
      },
      {
        $sort: { _id: 1 }
      }
    ]);

    res.status(200).json({
      success: true,
      data: {
        current: latestData,
        hourlyStats: hourlyData
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
