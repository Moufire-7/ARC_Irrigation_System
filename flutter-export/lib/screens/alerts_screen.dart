import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alerts',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'System notifications and maintenance reminders',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Mark all as read'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notification Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notification Settings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  _NotificationSetting(
                    title: 'Low Flow Rate Alerts',
                    description: 'Get notified when flow rate drops below threshold',
                    initialValue: true,
                  ),
                  const SizedBox(height: 16),
                  _NotificationSetting(
                    title: 'Maintenance Reminders',
                    description: 'Receive periodic maintenance notifications',
                    initialValue: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Alerts List
          const _AlertCard(
            type: AlertType.warning,
            title: 'Low flow detected at 2:00 PM',
            description: 'Flow rate dropped below 1.5 L/min',
            time: '2 hours ago',
            isRead: false,
          ),
          const SizedBox(height: 12),
          const _AlertCard(
            type: AlertType.info,
            title: 'Maintenance due in 3 days',
            description: 'Scheduled pump maintenance reminder',
            time: '5 hours ago',
            isRead: false,
          ),
          const SizedBox(height: 12),
          const _AlertCard(
            type: AlertType.success,
            title: 'Irrigation completed successfully',
            description: 'Morning schedule finished. 25L used.',
            time: 'Today at 08:15 AM',
            isRead: true,
          ),
          const SizedBox(height: 24),

          // Alert History
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alert History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ...[
                    'System check completed - Oct 29',
                    'Low battery warning cleared - Oct 28',
                    'Pump activated remotely - Oct 27',
                    'Schedule updated - Oct 26',
                  ].map((item) => _HistoryItem(text: item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationSetting extends StatefulWidget {
  final String title;
  final String description;
  final bool initialValue;

  const _NotificationSetting({
    required this.title,
    required this.description,
    required this.initialValue,
  });

  @override
  State<_NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<_NotificationSetting> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 14),
              ),
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
    );
  }
}

enum AlertType { warning, info, success }

class _AlertCard extends StatelessWidget {
  final AlertType type;
  final String title;
  final String description;
  final String time;
  final bool isRead;

  const _AlertCard({
    required this.type,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
  });

  IconData get _icon {
    switch (type) {
      case AlertType.warning:
        return Icons.water_drop;
      case AlertType.info:
        return Icons.build;
      case AlertType.success:
        return Icons.check_circle;
    }
  }

  Color get _iconColor {
    switch (type) {
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      case AlertType.success:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          border: isRead
              ? null
              : Border(
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 4,
                  ),
                ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(_icon, color: _iconColor, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                description,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          time,
                          style: const TextStyle(fontSize: 12),
                        ),
                        if (!isRead) ...[
                          const SizedBox(width: 16),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Mark as read',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String text;

  const _HistoryItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.grey),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
