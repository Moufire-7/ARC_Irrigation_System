# AquaLink - Smart Irrigation Dashboard

**Tagline:** "Grow Smarter. Water Wiser." 🌿

A Flutter-based irrigation management system for the IFS325/353 Group Project 2025 at the University of the Western Cape.

## Features

- 📊 **Real-time Dashboard**: Monitor water flow, usage, and pump status
- 📅 **Smart Scheduling**: Set up automated irrigation schedules
- 📈 **Statistics & Analytics**: View detailed usage patterns and efficiency metrics
- 🔔 **Alerts & Notifications**: Get notified about system events and maintenance
- ⚙️ **Settings**: Configure LoRa network, API endpoints, and preferences
- 🌓 **Dark Mode**: Full light and dark theme support
- 📱 **Responsive Design**: Works on mobile, tablet, and desktop

## Irrigation Modes

1. **🌤️ Scheduled**: Set recurring times and durations
2. **🔁 Automated**: Responds to soil moisture and weather data (integrates with Group 2)
3. **📡 Remote**: Control irrigation instantly from anywhere

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── theme/
│   └── app_theme.dart           # Material 3 theme configuration
├── providers/
│   ├── irrigation_provider.dart # Irrigation state management
│   └── theme_provider.dart      # Theme state management
├── screens/
│   ├── home_screen.dart         # Dashboard
│   ├── statistics_screen.dart   # Statistics & charts
│   ├── schedules_screen.dart    # Schedule management
│   ├── alerts_screen.dart       # Notifications & alerts
│   └── settings_screen.dart     # System settings
└── widgets/
    ├── circular_progress.dart   # Circular progress indicator
    └── stat_card.dart           # Statistic card component
```

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. Navigate to the flutter-export directory:
```bash
cd flutter-export
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

**Desktop (Windows/Linux/macOS):**
```bash
flutter build windows --release
flutter build linux --release
flutter build macos --release
```

## Dependencies

- **provider**: State management
- **fl_chart**: Beautiful charts and graphs
- **shared_preferences**: Local data persistence
- **flutter_local_notifications**: Push notifications
- **http**: API communication

## Hardware Integration

This app is designed to work with:
- **ESP32** microcontroller
- **YF-S401** flow sensor
- **Water pump** with relay module
- **LoRa** communication module (433 MHz)

### API Integration

Replace the dummy data with real API calls to:
- Group 2's soil moisture sensor data
- Group 5's data broker API
- Your ESP32 irrigation controller

Example API integration in `irrigation_provider.dart`:

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchRealTimeData() async {
  final response = await http.get(
    Uri.parse('https://api.irrigation.uwc.ac.za/data'),
  );
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    _flowRate = data['flowRate'];
    _totalUsage = data['totalUsage'];
    notifyListeners();
  }
}
```

## Configuration

### LoRa Network

Configure in Settings screen:
- Frequency: 433 MHz (default)
- Network ID: Your network identifier
- Spreading Factor: SF7-SF10

### API Endpoint

Set your API URL and credentials in the Settings screen.

## Color Palette

- **Primary Blue**: #1E90FF
- **Accent Gold**: #FFD700
- **Success Green**: #10B981
- **Warning Orange**: #F59E0B
- **Deep Blue**: #0F172A

## Team

**IFS325/353 Group 1**  
University of the Western Cape  
2025

## License

This project is created for educational purposes as part of the IFS325/353 course.

## Support

For technical support or questions, contact your project supervisor or teaching assistant.

---

**Built with ❤️ using Flutter**
