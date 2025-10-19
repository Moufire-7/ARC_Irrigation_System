import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/irrigation_provider.dart';
import '../widgets/circular_progress.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IrrigationProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Irrigation Dashboard',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Monitor and control your smart irrigation system',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
              ),
              const SizedBox(height: 24),

              // System Status Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'System Status',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Irrigation Status',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: provider.isPumpActive
                              ? Colors.green.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          provider.isPumpActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: provider.isPumpActive ? Colors.green : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Daily Water Usage
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: CircularProgressWidget(
                      value: provider.totalUsage,
                      maxValue: provider.dailyGoal,
                      size: 240,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Real-time Metrics
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return isWide
                      ? Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Current Flow Rate',
                                value: provider.flowRate.toStringAsFixed(1),
                                unit: 'L/min',
                                icon: Icons.water_drop,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: StatCard(
                                title: 'Total Water Used',
                                value: provider.totalUsage.toStringAsFixed(1),
                                unit: 'liters',
                                icon: Icons.analytics,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            StatCard(
                              title: 'Current Flow Rate',
                              value: provider.flowRate.toStringAsFixed(1),
                              unit: 'L/min',
                              icon: Icons.water_drop,
                            ),
                            const SizedBox(height: 16),
                            StatCard(
                              title: 'Total Water Used',
                              value: provider.totalUsage.toStringAsFixed(1),
                              unit: 'liters',
                              icon: Icons.analytics,
                            ),
                          ],
                        );
                },
              ),
              const SizedBox(height: 24),

              // Pump Control
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: provider.isPumpActive
                                ? Colors.green
                                : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Manual Control',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'Toggle pump on/off',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Switch(
                        value: provider.isPumpActive,
                        onChanged: (_) => provider.togglePump(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _QuickActionButton(
                            icon: Icons.power_settings_new,
                            label: 'Start Manual Irrigation',
                            onPressed: () {},
                          ),
                          _QuickActionButton(
                            icon: Icons.calendar_today,
                            label: "View Today's Schedule",
                            onPressed: () {},
                          ),
                          _QuickActionButton(
                            icon: Icons.health_and_safety,
                            label: 'Check System Health',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Today's Schedule Preview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      _ScheduleItem(
                        title: 'Morning Irrigation',
                        time: '08:00 AM • 15 minutes',
                        status: 'Completed',
                        statusColor: Colors.green,
                      ),
                      const SizedBox(height: 12),
                      _ScheduleItem(
                        title: 'Afternoon Irrigation',
                        time: 'Next run: Tomorrow at 08:00 AM',
                        status: 'Daily',
                        statusColor: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final Color statusColor;

  const _ScheduleItem({
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
