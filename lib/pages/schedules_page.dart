import 'package:flutter/material.dart';

class SchedulesPage extends StatefulWidget {
  const SchedulesPage({super.key});

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {
  bool automationEnabled = false;
  String selectedFrequency = 'daily';
  bool morningScheduleActive = true;
  bool eveningScheduleActive = false;
  int maxDuration = 60;
  String defaultFrequency = 'Daily';

  void _toggleAutomation() {
    setState(() {
      automationEnabled = !automationEnabled;
    });
    
    _showSnackBar(
      automationEnabled
          ? 'Automation enabled - System will respond to soil moisture data'
          : 'Automation disabled - Switched to manual scheduling'
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with Add Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Irrigation Schedules',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Handle add new schedule
                _showSnackBar('Add new schedule feature coming soon');
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add New'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Manage automated and scheduled irrigation',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),

        // Soil Moisture Automation Card
        _buildSoilMoistureCard(context, theme),
        const SizedBox(height: 24),

        // Scheduled Irrigation Card
        _buildScheduledIrrigationCard(context, theme),
        const SizedBox(height: 24),

        // Schedule Settings Card
        _buildScheduleSettingsCard(context, theme),
        const SizedBox(height: 24),

        // Active Schedules Card
        _buildActiveSchedulesCard(context, theme),
      ],
    );
  }

  // Build Soil Moisture Automation Card
  Widget _buildSoilMoistureCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Soil Moisture Automation',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enable to automatically irrigate based on soil moisture data',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: automationEnabled,
                  onChanged: (value) => _toggleAutomation(),
                ),
              ],
            ),
            if (automationEnabled) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity, // This makes it fill the full width
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✓ Connected to Group 2 soil moisture sensor',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Current soil moisture: 45% • Threshold: 40%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Build Scheduled Irrigation Card
  Widget _buildScheduledIrrigationCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Scheduled Irrigation',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Switch(
                      value: morningScheduleActive,
                      onChanged: (value) {
                        setState(() {
                          morningScheduleActive = value;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () {
                        _showSnackBar('Delete schedule feature coming soon');
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    '08:00',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '15 minutes',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'daily',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Next run: Tomorrow at 08:00',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Schedule Settings Card
  Widget _buildScheduleSettingsCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Schedule Settings',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // Maximum Duration
            _buildSettingField(
              'Maximum Duration (minutes)',
              maxDuration.toString(),
              (value) {
                setState(() {
                  maxDuration = int.tryParse(value) ?? 60;
                });
              },
            ),
            const SizedBox(height: 24),

            // Default Frequency
            _buildDropdownField(
              'Default Frequency',
              defaultFrequency,
              ['Daily', 'Weekly', 'Monthly'],
              (value) {
                setState(() {
                  defaultFrequency = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Build Setting Field
  Widget _buildSettingField(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          ),
        ),
      ],
    );
  }

  // Build Dropdown Field
  Widget _buildDropdownField(
    String label,
    String value,
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              onChanged: onChanged,
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Build Active Schedules Card
  Widget _buildActiveSchedulesCard(BuildContext context, ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Active Schedules',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Morning Irrigation Schedule
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9).withOpacity(0.05),
                border: Border.all(
                  color: const Color(0xFF0EA5E9).withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Morning Irrigation',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'Active',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF10B981),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '08:00 • 15 minutes • Daily',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Next run: Tomorrow at 08:00 AM',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: morningScheduleActive,
                    onChanged: (value) {
                      setState(() {
                        morningScheduleActive = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            
            // Evening Irrigation Schedule
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Opacity(
                opacity: 0.6,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Evening Irrigation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Disabled',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '18:00 • 20 minutes • Daily',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: eveningScheduleActive,
                      onChanged: (value) {
                        setState(() {
                          eveningScheduleActive = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

