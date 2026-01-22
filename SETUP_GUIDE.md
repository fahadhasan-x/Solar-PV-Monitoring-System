# SCUBE Solar Monitoring App - Setup Guide

## Flutter Installation & VS Code Setup

### 1. Flutter Installation (Windows)

1. Download Flutter SDK:
   - Visit: https://docs.flutter.dev/get-started/install/windows
   - Download the Flutter SDK ZIP file
   - Extract to `C:\src\flutter` (or your preferred location)

2. Add Flutter to PATH:
   - Search for "Environment Variables" in Windows
   - Edit System Environment Variables
   - Add `C:\src\flutter\bin` to PATH

3. Install Required Tools:
   ```bash
   # Run Flutter doctor to check requirements
   flutter doctor
   ```

4. Install Android Studio (for Android development):
   - Download from: https://developer.android.com/studio
   - Install Android SDK and Android Emulator

### 2. VS Code Setup for Flutter

1. Install VS Code Extensions:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X)
   - Install:
     - "Flutter" (by Dart Code)
     - "Dart" (automatically installed with Flutter)

2. Configure VS Code:
   - Press `Ctrl+Shift+P`
   - Type "Flutter: New Project" to verify Flutter is working

### 3. Running the App in VS Code

#### Option A: Using Android Emulator

1. Start Android Emulator:
   ```bash
   # Open AVD Manager from Android Studio or run:
   flutter emulators
   flutter emulators --launch <emulator_id>
   ```

2. In VS Code:
   - Open project folder: `C:\Users\fahad\Solar Monitoring Apps`
   - Press `F5` or click "Run and Debug" (Ctrl+Shift+D)
   - Select "Dart & Flutter" from dropdown
   - App will build and run on emulator

#### Option B: Using Chrome (Web Preview)

1. Enable Flutter Web:
   ```bash
   flutter config --enable-web
   ```

2. In VS Code:
   - Open Command Palette (Ctrl+Shift+P)
   - Type "Flutter: Select Device"
   - Choose "Chrome" or "Edge"
   - Press `F5` to run

3. Or from Terminal:
   ```bash
   flutter run -d chrome
   ```

#### Option C: Using Physical Device

1. Enable USB Debugging on your phone:
   - Go to Settings > About Phone
   - Tap "Build Number" 7 times
   - Go to Developer Options
   - Enable "USB Debugging"

2. Connect phone via USB

3. In VS Code:
   - Your device will appear in device selector
   - Press `F5` to run

### 4. Project Setup Commands

```bash
# Navigate to project directory
cd "C:\Users\fahad\Solar Monitoring Apps"

# Get Flutter dependencies
flutter pub get

# Run the app
flutter run

# Build for release (Android)
flutter build apk --release

# Build for release (Web)
flutter build web
```

### 5. VS Code Shortcuts for Flutter Development

- `F5` - Start Debugging
- `Ctrl+F5` - Run Without Debugging
- `Shift+F5` - Stop Debugging
- `r` (in terminal) - Hot Reload
- `R` (in terminal) - Hot Restart
- `p` - Show performance overlay
- `Ctrl+Shift+P` → "Flutter: Hot Reload" - Manual hot reload

### 6. Live Preview in VS Code

1. Install "Flutter Widget Snippets" extension for faster coding

2. Use Flutter DevTools:
   - When app is running, click "Dart DevTools" in terminal
   - Opens browser with:
     - Widget Inspector (view widget tree)
     - Performance monitoring
     - Network inspector

3. Hot Reload:
   - Make changes to code
   - Save file (Ctrl+S)
   - App automatically updates (Hot Reload)
   - See changes instantly without restarting

### 7. Viewing Design on Multiple Devices

In VS Code Terminal (while app is running):
```bash
# To see available devices
flutter devices

# To run on specific device
flutter run -d <device-id>

# To run on all connected devices
flutter run -d all
```

### 8. Troubleshooting

If you get errors:
```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Check Flutter setup
flutter doctor -v
```

### 9. Project Structure

```
Solar Monitoring Apps/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── screens/
│   │   ├── login_screen.dart     # Login page
│   │   ├── dashboard_1_screen.dart  # 1st dashboard
│   │   └── dashboard_2_screen.dart  # 2nd dashboard
│   ├── widgets/                  # Reusable components
│   ├── theme/                    # App theme/colors
│   └── utils/                    # Helper functions
├── assets/
│   └── images/                   # Your PNG images
├── pubspec.yaml                  # Dependencies
└── SETUP_GUIDE.md               # This file
```

### 10. Development Workflow

1. Open project in VS Code
2. Run `flutter pub get`
3. Select device (Chrome for quick testing)
4. Press F5 to run
5. Make code changes
6. Save file (Ctrl+S)
7. See instant preview with Hot Reload

### Live Preview Features:
- Changes reflect within 1-2 seconds
- No need to restart app
- Preserves app state
- Works for UI changes, colors, text, layouts
- For logic changes, use Hot Restart (Shift+F5 then F5)
