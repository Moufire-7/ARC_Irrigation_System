<<<<<<< HEAD
# AquaLink - Smart Irrigation System

A Flutter-based smart irrigation system monitoring and control application for IFS325/353 project at the University of the Western Cape.

## Features

- **Dashboard**: Real-time monitoring of irrigation system status
  - Live flow rate tracking
  - Daily water usage visualization with circular progress indicator
  - Pump control with manual override
  - Today's schedule preview

- **Statistics**: Water usage analytics and trends
  - Weekly usage charts (Line and Bar charts)
  - Efficiency metrics
  - Irrigation events history

- **Schedules**: Automated irrigation management
  - Soil moisture-based automation
  - Custom irrigation schedules
  - Schedule frequency settings (Daily, Weekly, Custom)

- **Alerts**: System notifications and maintenance
  - Low flow rate alerts
  - Maintenance reminders
  - Alert history tracking

- **Settings**: System configuration
  - LoRa network configuration
  - API endpoint settings
  - General preferences (units, theme, language)

## Tech Stack

- **Flutter SDK** (>=3.0.0)
- **Dart**
- **go_router** - Navigation
- **fl_chart** - Charts and data visualization
- **provider** - State management
- **fluttertoast** - Toast notifications

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS: Xcode (for macOS users)
- Android: Android SDK

### Quick Start

**Easiest Way**: Just double-click one of these files:
- 🖥️ **`run_app_windows.bat`** - Run on Windows Desktop (fastest for testing)
- 📱 **`run_app_android.bat`** - Run on Android device
- ⚡ **`run_app.bat`** - Run on default device

### Manual Setup

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
# IMPORTANT: Make sure you're in the aqua-link-grow-smart folder!
cd "C:\Users\Sange\New Aqualink\aqua-link-grow-smart"

# Run on Windows Desktop
flutter run -d windows

# Or on Android
flutter run -d android

# Or on Chrome
flutter run -d chrome
```

### Build for Production

```bash
# Make sure you're in the project folder first!
cd "C:\Users\Sange\New Aqualink\aqua-link-grow-smart"

# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# Web
flutter build web
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── pages/                    # App pages/screens
│   ├── dashboard_page.dart
│   ├── statistics_page.dart
│   ├── schedules_page.dart
│   ├── alerts_page.dart
│   ├── settings_page.dart
│   └── not_found_page.dart
├── widgets/                  # Reusable widgets
│   ├── layout.dart
│   ├── circular_progress.dart
│   └── stat_card.dart
└── theme/                    # App theming
    └── app_theme.dart

public/                       # Static assets
├── favicon.ico
├── placeholder.svg
└── robots.txt
```

## Configuration

### LoRa Network
- Frequency: 433 MHz (configurable)
- Spreading Factor: SF7-SF10
- Network ID: Configurable in Settings

### API Integration
Configure the API endpoint in Settings:
- API URL: `https://api.irrigation.uwc.ac.za`
- API Key: Your API key
- Sync Interval: 15 minutes (default)

## Features Overview

### Real-time Monitoring
The dashboard provides real-time updates of:
- Current flow rate (L/min)
- Total water usage (liters)
- Pump status (Active/Inactive)
- System health status

### Automated Irrigation
- Soil moisture-based automation (connects to Group 2 sensor)
- Customizable irrigation schedules
- Multiple schedule support with individual controls

### Data Visualization
- Weekly water usage trends (Line chart)
- Scheduled vs Actual comparison (Bar chart)
- Circular progress indicators for daily goals
- Historical irrigation events table

## Team

**IFS325/353 Group 1**  
University of the Western Cape  
2025

## License

This project is part of an academic assignment for IFS325/353 at UWC.

## Support

For issues or questions, please contact the development team or refer to the project documentation.
=======
# ARC_Irrigation_System
>>>>>>> 97531d99476f6913d7f187cb6ce916fac814ba4e
