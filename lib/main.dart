import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/dashboard_page.dart';
import 'pages/statistics_page.dart';
import 'pages/schedules_page.dart';
import 'pages/alerts_page.dart';
import 'pages/settings_page.dart';
import 'pages/not_found_page.dart';
import 'widgets/layout.dart';
import 'services/alert_service.dart';
import 'services/theme_service.dart';

void main() {
  runApp(const AquaLinkApp());
}

class AquaLinkApp extends StatelessWidget {
  const AquaLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AlertService()),
        ChangeNotifierProvider(create: (context) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp.router(
            title: 'AquaLink - Smart Irrigation',
            theme: themeService.currentThemeData,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return AppLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/statistics',
          builder: (context, state) => const StatisticsPage(),
        ),
        GoRoute(
          path: '/schedules',
          builder: (context, state) => const SchedulesPage(),
        ),
        GoRoute(
          path: '/alerts',
          builder: (context, state) => const AlertsPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);

