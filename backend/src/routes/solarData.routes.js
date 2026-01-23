const express = require('express');
const router = express.Router();
const {
  getLatestData,
  getDataHistory,
  addSolarData,
  getStatistics,
  getDashboardData
} = require('../controllers/solarData.controller');
const { protect } = require('../middleware/auth.middleware');

// All routes are protected
router.use(protect);

// Routes
router.get('/latest/:deviceId', getLatestData);
router.get('/history/:deviceId', getDataHistory);
router.post('/data', addSolarData);
router.get('/stats/:deviceId', getStatistics);
router.get('/dashboard/:deviceId', getDashboardData);

module.exports = router;
