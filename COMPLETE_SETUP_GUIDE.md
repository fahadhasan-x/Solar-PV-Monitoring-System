# SCUBE Solar Monitoring - Setup Guide

## Project Complete! 

Tumhar full-stack Solar Monitoring application tayar hai with complete backend-frontend integration.

---

## What's Been Created

### Backend (Node.js + Express + MongoDB)
- ✅ RESTful API with authentication (JWT)
- ✅ MongoDB database models
- ✅ Complete CRUD operations
- ✅ Database seeder with dummy data
- ✅ Full API documentation

### Frontend (Flutter)
- ✅ API integration with HTTP client
- ✅ State management (Provider)
- ✅ Secure token storage
- ✅ Login with backend API
- ✅ Real-time dashboard data
- ✅ Auto-refresh functionality
- ✅ Pull-to-refresh
- ✅ Loading states
- ✅ Error handling

---

## Setup Instructions

### 1. Backend Setup

#### Install MongoDB
Make sure MongoDB is installed and running on your system.

#### Install Dependencies
```bash
cd backend
npm install
```

#### Seed Database with Dummy Data
```bash
npm run seed
```

This will create:
- 3 test users
- 48 hours of solar data for device "SOLAR_001"

**Test Credentials:**
- Username: `admin`, Password: `admin123`
- Username: `testuser`, Password: `test123`
- Username: `demo`, Password: `demo123`

#### Start Backend Server
```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

Backend will run on `http://localhost:5000`

---

### 2. Frontend Setup

#### Install Flutter Dependencies
```bash
flutter pub get
```

#### Update API URL (if needed)
If running on Android emulator or physical device, update the API URL in:
`lib/config/api_config.dart`

```dart
// For Android Emulator
static const String baseUrl = 'http://10.0.2.2:5000';

// For physical device (use your computer's IP)
static const String baseUrl = 'http://192.168.1.100:5000';

// For web/desktop
static const String baseUrl = 'http://localhost:5000';
```

#### Run the Flutter App
```bash
# For web
flutter run -d chrome

# For Android
flutter run -d android

# For Windows
flutter run -d windows
```

---

## Test the Application

### 1. Login
- Open the app
- Use credentials: `testuser` / `test123`
- Click Login

### 2. View Dashboard
- See real-time solar data
- Auto-refreshes every 30 seconds
- Pull down to manually refresh

### 3. Backend API Testing

#### Test Login API (using curl)
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "testuser", "password": "test123"}'
```

#### Test Solar Data API
```bash
# Get latest data (replace YOUR_TOKEN with token from login)
curl -X GET http://localhost:5000/api/solar/latest/SOLAR_001 \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## Project Structure

```
Solar Monitoring Apps/
├── backend/
│   ├── src/
│   │   ├── config/
│   │   │   └── database.js
│   │   ├── controllers/
│   │   │   ├── auth.controller.js
│   │   │   └── solarData.controller.js
│   │   ├── models/
│   │   │   ├── User.model.js
│   │   │   └── SolarData.model.js
│   │   ├── routes/
│   │   │   ├── auth.routes.js
│   │   │   └── solarData.routes.js
│   │   ├── middleware/
│   │   │   └── auth.middleware.js
│   │   ├── utils/
│   │   │   └── jwtHelper.js
│   │   └── server.js
│   ├── seed.js
│   ├── package.json
│   ├── .env
│   └── README.md
│
├── lib/
│   ├── config/
│   │   ├── api_config.dart
│   │   └── app_config.dart
│   ├── models/
│   │   ├── user.dart
│   │   ├── auth_response.dart
│   │   ├── solar_data.dart
│   │   └── dashboard_data.dart
│   ├── services/
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   └── solar_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   └── solar_data_provider.dart
│   ├── utils/
│   │   └── secure_storage.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── dashboard_1_screen.dart
│   │   └── dashboard_2_screen.dart
│   ├── widgets/
│   ├── theme/
│   └── main.dart
│
└── pubspec.yaml
```

---

## API Endpoints

### Authentication
- `POST /api/auth/login` - Login
- `POST /api/auth/register` - Register new user
- `GET /api/auth/me` - Get current user (protected)

### Solar Data (All protected with JWT)
- `GET /api/solar/latest/:deviceId` - Get latest data
- `GET /api/solar/dashboard/:deviceId` - Get dashboard data
- `GET /api/solar/history/:deviceId` - Get historical data
- `GET /api/solar/stats/:deviceId` - Get statistics
- `POST /api/solar/data` - Add new data

Default Device ID: `SOLAR_001`

---

## Features

### Backend Features
- JWT-based authentication
- Password hashing with bcrypt
- MongoDB database with Mongoose
- CORS enabled
- Error handling middleware
- Request logging (Morgan)
- Environment variables (.env)

### Frontend Features
- Provider state management
- Secure token storage (flutter_secure_storage)
- HTTP API client
- Auto-refresh dashboard (30s interval)
- Pull-to-refresh
- Loading indicators
- Error handling with retry
- Logout functionality
- Session management

---

## Troubleshooting

### Backend Issues

**MongoDB connection error:**
```
Error: MongoDB not running
Solution: Start MongoDB service
```

**Port 5000 already in use:**
```
Solution: Change PORT in backend/.env file
```

### Frontend Issues

**API connection error:**
```
Error: No internet connection
Solution: 
1. Make sure backend is running
2. Check API URL in api_config.dart
3. For Android emulator, use 10.0.2.2 instead of localhost
```

**Token error / 401 Unauthorized:**
```
Solution: Login again to get new token
```

---

## Database Schema

### User Collection
```javascript
{
  username: String (unique),
  email: String (unique),
  password: String (hashed),
  name: String,
  role: String (user/admin),
  isActive: Boolean,
  createdAt: Date,
  updatedAt: Date
}
```

### SolarData Collection
```javascript
{
  deviceId: String,
  timestamp: Date,
  solarPower: { current, voltage, current_ampere },
  energyProduction: { today, thisMonth, total },
  battery: { level, voltage, charging },
  grid: { status, voltage, frequency },
  load: { power, today },
  inverter: { status, temperature, efficiency },
  weather: { temperature, humidity, irradiance, cloudCover },
  system: { status, alerts: [] },
  createdAt: Date,
  updatedAt: Date
}
```

---

## Next Steps (Optional Enhancements)

1. **Add More Features:**
   - Historical charts
   - Notifications
   - Multiple device support
   - Export data to CSV/PDF
   - User settings

2. **Improve Security:**
   - Refresh token implementation
   - Rate limiting
   - Input validation
   - HTTPS/SSL

3. **Deploy:**
   - Backend to Heroku/Railway/DigitalOcean
   - Frontend to Play Store/App Store
   - Database to MongoDB Atlas

4. **Testing:**
   - Unit tests
   - Integration tests
   - E2E tests

---

## Support

For complete API documentation, see:
- `backend/README.md`

For any issues or questions, check:
- Backend logs in terminal
- Flutter debug console
- MongoDB logs

---

## Credits

**Technology Stack:**
- Backend: Node.js, Express, MongoDB, JWT
- Frontend: Flutter, Provider, HTTP
- Database: MongoDB

**Created for:** SCUBE Solar Control & Monitoring System

---

**Everything is ready! Backend + Frontend fully integrated!** 🎉
