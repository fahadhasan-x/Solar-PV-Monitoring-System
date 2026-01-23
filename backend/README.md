# SCUBE Solar Monitoring API Documentation

## Base URL
```
http://localhost:5000/api
```

## Authentication
All protected endpoints require a JWT token in the Authorization header:
```
Authorization: Bearer <token>
```

---

## Authentication Endpoints

### 1. Register User
**POST** `/auth/register`

**Request Body:**
```json
{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "password123",
  "name": "John Doe"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": "60f7b3b3b3b3b3b3b3b3b3b3",
      "username": "john_doe",
      "email": "john@example.com",
      "name": "John Doe",
      "role": "user"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 2. Login
**POST** `/auth/login`

**Request Body:**
```json
{
  "username": "john_doe",
  "password": "password123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "60f7b3b3b3b3b3b3b3b3b3b3",
      "username": "john_doe",
      "email": "john@example.com",
      "name": "John Doe",
      "role": "user"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 3. Get Current User
**GET** `/auth/me`

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": "60f7b3b3b3b3b3b3b3b3b3b3",
      "username": "john_doe",
      "email": "john@example.com",
      "name": "John Doe",
      "role": "user",
      "isActive": true
    }
  }
}
```

---

## Solar Data Endpoints

### 1. Get Latest Data
**GET** `/solar/latest/:deviceId`

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "deviceId": "SOLAR_001",
    "timestamp": "2024-01-20T10:30:00.000Z",
    "solarPower": {
      "current": 5.2,
      "voltage": 240,
      "current_ampere": 21.67
    },
    "energyProduction": {
      "today": 15.5,
      "thisMonth": 450.2,
      "total": 5234.8
    },
    "battery": {
      "level": 85,
      "voltage": 48.2,
      "charging": true
    },
    "grid": {
      "status": "online",
      "voltage": 230,
      "frequency": 50
    },
    "load": {
      "power": 3.2,
      "today": 12.5
    },
    "inverter": {
      "status": "normal",
      "temperature": 45,
      "efficiency": 95.5
    },
    "weather": {
      "temperature": 28,
      "humidity": 65,
      "irradiance": 850,
      "cloudCover": 20
    },
    "system": {
      "status": "normal",
      "alerts": []
    }
  }
}
```

### 2. Get Data History
**GET** `/solar/history/:deviceId?startDate=2024-01-01&endDate=2024-01-31&limit=100`

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
- `startDate` (optional): Start date in ISO format
- `endDate` (optional): End date in ISO format
- `limit` (optional): Maximum number of records (default: 100)

**Response:**
```json
{
  "success": true,
  "count": 50,
  "data": [
    // Array of solar data objects
  ]
}
```

### 3. Add Solar Data
**POST** `/solar/data`

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "deviceId": "SOLAR_001",
  "solarPower": {
    "current": 5.2,
    "voltage": 240,
    "current_ampere": 21.67
  },
  "energyProduction": {
    "today": 15.5,
    "thisMonth": 450.2,
    "total": 5234.8
  },
  "battery": {
    "level": 85,
    "voltage": 48.2,
    "charging": true
  },
  "weather": {
    "temperature": 28,
    "humidity": 65,
    "irradiance": 850
  }
}
```

**Response:**
```json
{
  "success": true,
  "message": "Solar data added successfully",
  "data": {
    // Solar data object
  }
}
```

### 4. Get Statistics
**GET** `/solar/stats/:deviceId?period=today`

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
- `period` (optional): today | week | month (default: today)

**Response:**
```json
{
  "success": true,
  "period": "today",
  "data": {
    "avgPower": 4.8,
    "maxPower": 6.2,
    "minPower": 0.5,
    "totalEnergy": 15.5,
    "avgBatteryLevel": 78.5,
    "avgTemperature": 27.3,
    "count": 48
  }
}
```

### 5. Get Dashboard Data
**GET** `/solar/dashboard/:deviceId`

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "success": true,
  "data": {
    "current": {
      // Latest solar data object
    },
    "hourlyStats": [
      {
        "_id": 8,
        "avgPower": 2.5,
        "avgLoad": 1.8,
        "avgBattery": 75
      },
      {
        "_id": 9,
        "avgPower": 3.8,
        "avgLoad": 2.1,
        "avgBattery": 78
      }
      // More hourly data...
    ]
  }
}
```

---

## Error Responses

All endpoints return errors in the following format:

```json
{
  "success": false,
  "message": "Error message here"
}
```

### Common HTTP Status Codes:
- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `500` - Server Error

---

## Setup Instructions

### 1. Install Dependencies
```bash
cd backend
npm install
```

### 2. Configure Environment
Create a `.env` file in the backend directory:
```env
PORT=5000
NODE_ENV=development
MONGODB_URI=mongodb://localhost:27017/solar_monitoring
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRE=7d
ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8080
```

### 3. Start MongoDB
Make sure MongoDB is running on your system.

### 4. Run the Server
```bash
# Development mode with auto-reload
npm run dev

# Production mode
npm start
```

The API will be available at `http://localhost:5000`

---

## Testing with cURL

### Register a user:
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "name": "Test User"
  }'
```

### Login:
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "password123"
  }'
```

### Get latest solar data:
```bash
curl -X GET http://localhost:5000/api/solar/latest/SOLAR_001 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```
