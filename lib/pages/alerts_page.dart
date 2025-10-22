import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/alert_service.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> with AutomaticKeepAliveClientMixin {
  bool lowFlowAlerts = true;
  bool maintenanceReminders = true;
  bool systemStatusUpdates = true;

  final List<AlertItem> alerts = [
    AlertItem(
      type: AlertType.warning,
      title: 'Low flow detected at 02:00 PM',
      timestamp: '2025/10/30, 14:00:00',
      isRead: false,
    ),
    AlertItem(
      type: AlertType.info,
      title: 'Maintenance due in 3 days',
      timestamp: '2025/10/30, 09:00:00',
      isRead: false,
    ),
    AlertItem(
      type: AlertType.success,
      title: 'Irrigation completed successfully',
      timestamp: '2025/10/30, 08:15:00',
      isRead: true,
    ),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final unreadCount = alerts.where((alert) => !alert.isRead).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page Title and Actions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Alerts',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                if (unreadCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF4444),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (unreadCount > 0)
              TextButton(
                onPressed: () => _showMarkAsReadOptions(context),
                child: const Text('Mark all as read'),
              ),
          ],
        ),
        const SizedBox(height: 24),

        // Alerts List
        _buildAlertsList(context),
        const SizedBox(height: 24),

        // Notification Settings
        _buildNotificationSettings(context),
        const SizedBox(height: 24),

        // Alert History
        _buildAlertHistory(context),
      ],
    );
  }

  Widget _buildAlertsList(BuildContext context) {
    return Card(
      child: Column(
        children: alerts.map((alert) => _buildAlertItem(context, alert)).toList(),
      ),
    );
  }

  Widget _buildAlertItem(BuildContext context, AlertItem alert) {
    Color backgroundColor;
    Color iconColor;
    IconData iconData;

    switch (alert.type) {
      case AlertType.warning:
        backgroundColor = const Color(0xFFF0F9FF);
        iconColor = const Color(0xFFF59E0B);
        iconData = Icons.warning_amber_outlined;
        break;
      case AlertType.info:
        backgroundColor = const Color(0xFFF0F9FF);
        iconColor = const Color(0xFF0EA5E9);
        iconData = Icons.info_outline;
        break;
      case AlertType.success:
        backgroundColor = Colors.white;
        iconColor = const Color(0xFF10B981);
        iconData = Icons.check_circle_outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.timestamp,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          if (!alert.isRead)
            TextButton(
              onPressed: () => _markAsRead(alert),
              child: const Text('Mark as read'),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            _buildNotificationSetting(
              'Low Flow Rate Alerts',
              'Get notified when flow rate drops below threshold',
              lowFlowAlerts,
              (value) {
                setState(() {
                  lowFlowAlerts = value;
                });
              },
            ),
            const SizedBox(height: 20),

            _buildNotificationSetting(
              'Maintenance Reminders',
              'Receive periodic maintenance notifications',
              maintenanceReminders,
              (value) {
                setState(() {
                  maintenanceReminders = value;
                });
              },
            ),
            const SizedBox(height: 20),

            _buildNotificationSetting(
              'System Status Updates',
              'Get notified about system status changes',
              systemStatusUpdates,
              (value) {
                setState(() {
                  systemStatusUpdates = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSetting(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildAlertHistory(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alert History',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...[
              'System check completed - Oct 29',
              'Low battery warning cleared - Oct 28',
              'Pump activated remotely - Oct 27',
              'Schedule updated - Oct 26',
            ].map((item) => InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _markAsRead(AlertItem alert) {
    if (mounted) {
      setState(() {
        alert.isRead = true;
      });
      // Update the alert service
      Provider.of<AlertService>(context, listen: false).markAsRead();
    }
  }

  void _showMarkAsReadOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Mark Alerts as Read'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Mark all alerts as read'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    for (var alert in alerts) {
                      alert.isRead = true;
                    }
                  });
                  Provider.of<AlertService>(context, listen: false).markAllAsRead();
                  _showSnackBar(context, 'All alerts marked as read');
                },
              ),
              ListTile(
                title: const Text('Mark only warning alerts as read'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    for (var alert in alerts) {
                      if (alert.type == AlertType.warning) {
                        alert.isRead = true;
                      }
                    }
                  });
                  Provider.of<AlertService>(context, listen: false).updateUnreadCount(
                    alerts.where((alert) => !alert.isRead).length
                  );
                  _showSnackBar(context, 'Warning alerts marked as read');
                },
              ),
              ListTile(
                title: const Text('Mark only info alerts as read'),
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    for (var alert in alerts) {
                      if (alert.type == AlertType.info) {
                        alert.isRead = true;
                      }
                    }
                  });
                  Provider.of<AlertService>(context, listen: false).updateUnreadCount(
                    alerts.where((alert) => !alert.isRead).length
                  );
                  _showSnackBar(context, 'Info alerts marked as read');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF0EA5E9),
      ),
    );
  }
}

class AlertItem {
  final AlertType type;
  final String title;
  final String timestamp;
  bool isRead;

  AlertItem({
    required this.type,
    required this.title,
    required this.timestamp,
    required this.isRead,
  });
}

enum AlertType {
  warning,
  info,
  success,
}

