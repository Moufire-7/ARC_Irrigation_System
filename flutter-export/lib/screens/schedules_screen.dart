import 'package:flutter/material.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  bool _automationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Irrigation Schedules',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage automated and scheduled irrigation',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 24),

          // Soil Moisture Automation
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cloud,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Soil Moisture Automation',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Enable to automatically irrigate based on soil moisture data',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _automationEnabled,
                        onChanged: (value) {
                          setState(() => _automationEnabled = value);
                        },
                      ),
                    ],
                  ),
                  if (_automationEnabled) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✓ Connected to Group 2 soil moisture sensor',
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Current soil moisture: 45% • Threshold: 40%',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Add New Schedule
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scheduled Irrigation',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Add New'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Start Time'),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: '08:00',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Duration (minutes)'),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: '15',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Frequency'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: 'daily',
                        items: const [
                          DropdownMenuItem(value: 'daily', child: Text('Daily')),
                          DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                          DropdownMenuItem(value: 'custom', child: Text('Custom')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Active Schedules
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Active Schedules',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _ScheduleCard(
                    title: 'Morning Irrigation',
                    time: '08:00 • 15 minutes • Daily',
                    nextRun: 'Next run: Tomorrow at 08:00 AM',
                    isActive: true,
                    statusColor: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _ScheduleCard(
                    title: 'Evening Irrigation',
                    time: '18:00 • 20 minutes • Daily',
                    nextRun: '',
                    isActive: false,
                    statusColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatefulWidget {
  final String title;
  final String time;
  final String nextRun;
  final bool isActive;
  final Color statusColor;

  const _ScheduleCard({
    required this.title,
    required this.time,
    required this.nextRun,
    required this.isActive,
    required this.statusColor,
  });

  @override
  State<_ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<_ScheduleCard> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _enabled
            ? widget.statusColor.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        border: Border.all(
          color: _enabled
              ? widget.statusColor.withOpacity(0.3)
              : Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _enabled
                            ? Colors.green.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _enabled ? 'Active' : 'Disabled',
                        style: TextStyle(
                          color: _enabled ? Colors.green : Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.time,
                  style: const TextStyle(fontSize: 14),
                ),
                if (widget.nextRun.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    widget.nextRun,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: _enabled,
            onChanged: (value) {
              setState(() => _enabled = value);
            },
          ),
        ],
      ),
    );
  }
}
