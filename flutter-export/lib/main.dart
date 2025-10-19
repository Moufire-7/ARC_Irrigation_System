import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/schedules_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';
import 'providers/irrigation_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IrrigationProvider()),
      ],
      child: const AquaLinkApp(),
    ),
  );
}

class AquaLinkApp extends StatelessWidget {
  const AquaLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'AquaLink',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          home: const MainLayout(),
        );
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const StatisticsScreen(),
    const SchedulesScreen(),
    const AlertsScreen(),
    const SettingsScreen(),
  ];

  final List<NavigationItem> _navItems = [
    NavigationItem(icon: Icons.dashboard, label: 'Dashboard'),
    NavigationItem(icon: Icons.bar_chart, label: 'Statistics'),
    NavigationItem(icon: Icons.calendar_today, label: 'Schedules'),
    NavigationItem(icon: Icons.notifications, label: 'Alerts'),
    NavigationItem(icon: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.water_drop, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            const Text('AquaLink'),
            const Spacer(),
            const Text(
              'University of the Western Cape',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              setState(() => _selectedIndex = 3);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              labelType: NavigationRailLabelType.all,
              backgroundColor: Theme.of(context).colorScheme.surface,
              destinations: _navItems
                  .map((item) => NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(item.label),
                      ))
                  .toList(),
            ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
              destinations: _navItems
                  .map((item) => NavigationDestination(
                        icon: Icon(item.icon),
                        label: item.label,
                      ))
                  .toList(),
            ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}
