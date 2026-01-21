# Solar Monitoring App - Quick Start

## Run the App (Fastest Way for VS Code Users)

### Method 1: Web Browser Preview (Recommended for Quick Testing)

```bash
# 1. Open terminal in VS Code (Ctrl+`)
cd "C:\Users\fahad\Solar Monitoring Apps"

# 2. Enable web support (one-time)
flutter config --enable-web

# 3. Get dependencies
flutter pub get

# 4. Run in Chrome
flutter run -d chrome
```

### Method 2: VS Code UI

1. Open folder: `C:\Users\fahad\Solar Monitoring Apps`
2. Open `lib/main.dart`
3. Press `F5`
4. Select device (Chrome/Edge/Android Emulator)
5. Wait for build to complete

## Key Commands

```bash
# Install dependencies
flutter pub get

# Run app
flutter run

# Hot reload (while running) - press 'r' in terminal
r

# Stop app
Ctrl+C
```

## What You Get

1. **Login Screen** - SCUBE branding with username/password
2. **Dashboard 1** - Solar metrics, weather, energy data
3. **Dashboard 2** - Electricity charts with tabs

## File Structure

- `lib/main.dart` - App entry point
- `lib/screens/` - All screens (login, dashboards)
- `lib/widgets/` - Reusable UI components
- `lib/theme/` - Colors and styling
- `assets/images/` - Your PNG files

## Need Help?

See full `SETUP_GUIDE.md` for detailed Flutter installation and VS Code setup instructions.
