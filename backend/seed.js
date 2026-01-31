const User = require('./src/models/User.model');
const SolarData = require('./src/models/SolarData.model');
const { sequelize, connectDB } = require('./src/config/database');
require('dotenv').config();

// Generate random number within range
const randomBetween = (min, max) => Math.random() * (max - min) + min;

// Generate dummy users
const createUsers = async () => {
  const users = [
    {
      username: 'admin',
      email: 'admin@scube.com',
      password: 'admin123',
      name: 'Admin User',
      role: 'admin',
      isActive: true,
    },
    {
      username: 'testuser',
      email: 'test@scube.com',
      password: 'test123',
      name: 'Test User',
      role: 'user',
      isActive: true,
    },
    {
      username: 'demo',
      email: 'demo@scube.com',
      password: 'demo123',
      name: 'Demo User',
      role: 'user',
      isActive: true,
    },
  ];

  await User.destroy({ where: {}, truncate: true });
  const createdUsers = await User.bulkCreate(users);
  console.log(`Created ${createdUsers.length} users`);
  return createdUsers;
};

// Generate dummy solar data for last 24 hours
const createSolarData = async () => {
  const deviceId = 'SOLAR_001';
  const solarDataArray = [];
  const now = new Date();

  // Generate data for last 24 hours (every 30 minutes = 48 data points)
  for (let i = 48; i >= 0; i--) {
    const timestamp = new Date(now - i * 30 * 60 * 1000);
    const hour = timestamp.getHours();
    
    // Simulate solar production based on time of day
    let solarMultiplier = 0;
    if (hour >= 6 && hour < 18) {
      // Daytime - solar production
      const dayProgress = (hour - 6) / 12; // 0 to 1
      solarMultiplier = Math.sin(dayProgress * Math.PI); // Bell curve
    }

    const solarData = {
      deviceId,
      timestamp,
      solarPowerCurrent: randomBetween(0, 10) * solarMultiplier,
      solarPowerVoltage: randomBetween(230, 250),
      solarPowerCurrentAmpere: randomBetween(0, 50) * solarMultiplier,
      energyProductionToday: randomBetween(10, 30),
      energyProductionThisMonth: randomBetween(400, 600),
      energyProductionTotal: randomBetween(5000, 8000),
      batteryLevel: randomBetween(60, 95),
      batteryVoltage: randomBetween(46, 52),
      batteryCharging: solarMultiplier > 0.3,
      gridStatus: Math.random() > 0.1 ? 'online' : 'offline',
      gridVoltage: randomBetween(220, 240),
      gridFrequency: randomBetween(49.5, 50.5),
      loadPower: randomBetween(2, 8),
      loadToday: randomBetween(10, 25),
      inverterStatus: Math.random() > 0.05 ? 'normal' : 'standby',
      inverterTemperature: randomBetween(35, 55),
      inverterEfficiency: randomBetween(90, 98),
      weatherTemperature: randomBetween(20, 35),
      weatherHumidity: randomBetween(40, 80),
      weatherIrradiance: randomBetween(0, 1000) * solarMultiplier,
      weatherCloudCover: randomBetween(0, 80) * (1 - solarMultiplier),
      systemStatus: Math.random() > 0.05 ? 'normal' : 'warning',
      systemAlerts: Math.random() > 0.9 ? [
        {
          type: 'warning',
          message: 'High temperature detected',
          timestamp: new Date(),
        }
      ] : [],
    };

    solarDataArray.push(solarData);
  }

  await SolarData.destroy({ where: {}, truncate: true });
  const createdData = await SolarData.bulkCreate(solarDataArray);
  console.log(`Created ${createdData.length} solar data entries`);
  return createdData;
};

// Main seeder function
const seedDatabase = async () => {
  try {
    await connectDB();
    
    console.log('\n🌱 Starting database seeding...\n');
    
    await createUsers();
    await createSolarData();
    
    console.log('\n✅ Database seeding completed successfully!\n');
    console.log('Test credentials:');
    console.log('  Username: admin, Password: admin123');
    console.log('  Username: testuser, Password: test123');
    console.log('  Username: demo, Password: demo123');
    console.log('\nDevice ID: SOLAR_001\n');
    
    await sequelize.close();
    process.exit(0);
  } catch (error) {
    console.error('Error seeding database:', error);
    process.exit(1);
  }
};

// Run seeder
seedDatabase();
