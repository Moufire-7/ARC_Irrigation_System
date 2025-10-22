import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../widgets/circular_progress.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isPumpActive = true;
  double flowRate = 2.5;
  double totalUsage = 45.0;
  final double dailyGoal = 100;
  Timer? _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          if (isPumpActive) {
            flowRate = max(1.5, min(4.0, flowRate + (_random.nextDouble() - 0.5) * 0.3));
            totalUsage += 0.05;
          } else {
            flowRate = 0;
          }
        });
      }
    });
  }

  void _togglePump() {
    setState(() {
      isPumpActive = !isPumpActive;
    });
    
    _showSnackBar(
      isPumpActive ? 'Pump activated - Irrigation started' : 'Pump deactivated - Irrigation stopped'
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
    const successColor = Color(0xFF10B981);
    final primaryBlue = theme.colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Irrigation Dashboard',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Monitor and control your smart irrigation system',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 24),

        // System Status Card with Gradient
        Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  isPumpActive 
                      ? successColor.withOpacity(0.05)
                      : Colors.grey.withOpacity(0.05),
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isPumpActive
                              ? successColor.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isPumpActive ? Icons.check_circle : Icons.circle_outlined,
                          color: isPumpActive ? successColor : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'System Status',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Irrigation Status',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isPumpActive
                                    ? successColor.withOpacity(0.1)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isPumpActive
                                      ? successColor.withOpacity(0.3)
                                      : Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: isPumpActive ? successColor : Colors.grey[600],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    isPumpActive ? 'Active' : 'Inactive',
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: isPumpActive ? successColor : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _confirmPumpToggle(),
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isPumpActive
                                  ? const Color(0xFFEF4444).withOpacity(0.1)
                                  : successColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isPumpActive
                                    ? const Color(0xFFEF4444).withOpacity(0.3)
                                    : successColor.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              isPumpActive ? Icons.pause : Icons.play_arrow,
                              color: isPumpActive ? const Color(0xFFEF4444) : successColor,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Daily Water Usage Card with Icon Badge
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.water_drop,
                            color: primaryBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Daily Water Usage',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, size: 20),
                      color: primaryBlue,
                      onPressed: () => _refreshData(),
                      tooltip: 'Refresh data',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: CircularProgress(
                    value: totalUsage,
                    max: dailyGoal,
                    size: 240,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: primaryBlue,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Target: ${dailyGoal.toInt()}L/day • Remaining: ${(dailyGoal - totalUsage).toStringAsFixed(1)}L',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: primaryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Real-time Metrics - Interactive Cards
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 768) {
              return Row(
                children: [
                  Expanded(child: _buildFlowRateCard(context, theme, primaryBlue)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTotalWaterCard(context, theme, primaryBlue, successColor)),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildFlowRateCard(context, theme, primaryBlue),
                  const SizedBox(height: 16),
                  _buildTotalWaterCard(context, theme, primaryBlue, successColor),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 24),

        // Quick Actions Card with Better Style
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.flash_on,
                        color: primaryBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Quick Actions',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth >= 768) {
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 3,
                            child: ElevatedButton.icon(
                              onPressed: () => _showIrrigationOptions(context),
                              icon: const Icon(Icons.play_arrow, size: 18),
                              label: const Text('Start Irrigation'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 3,
                            child: OutlinedButton.icon(
                              onPressed: () => _showScheduleInfo(context),
                              icon: const Icon(Icons.calendar_today, size: 18),
                              label: const Text('View Schedule'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 24) / 3,
                            child: OutlinedButton.icon(
                              onPressed: () => _showSystemHealth(context),
                              icon: const Icon(Icons.health_and_safety, size: 18),
                              label: const Text('System Health'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _showIrrigationOptions(context),
                            icon: const Icon(Icons.play_arrow, size: 18),
                            label: const Text('Start Manual Irrigation'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () => _showScheduleInfo(context),
                            icon: const Icon(Icons.calendar_today, size: 18),
                            label: const Text('View Today\'s Schedule'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton.icon(
                            onPressed: () => _showSystemHealth(context),
                            icon: const Icon(Icons.health_and_safety, size: 18),
                            label: const Text('Check System Health'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Today's Schedule Preview with Better Styling
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.schedule,
                        color: Color(0xFFF59E0B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Today\'s Schedule',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Morning Irrigation',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '08:00 AM • 15 minutes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Afternoon Irrigation',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Next run: Tomorrow at 08:00 AM',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EA5E9).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Daily',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0EA5E9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to confirm pump toggle with dialog
  void _confirmPumpToggle() {
    const errorRed = Color(0xFFEF4444);
    const successColor = Color(0xFF10B981);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isPumpActive ? Icons.pause_circle : Icons.play_circle,
              color: isPumpActive ? errorRed : successColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isPumpActive ? 'Pause Irrigation System?' : 'Start Irrigation System?',
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Text(
          isPumpActive
              ? 'This will temporarily stop all irrigation activities. You can resume anytime from the dashboard.'
              : 'This will start the irrigation system. Water will flow according to the current settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _togglePump();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isPumpActive ? errorRed : successColor,
            ),
            child: Text(isPumpActive ? 'Pause System' : 'Start System'),
          ),
        ],
      ),
    );
  }

  // Refresh data method
  void _refreshData() {
    _showSnackBar('Refreshing water usage data...');
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          // Data is already being updated by the timer
        });
        _showSnackBar('Water usage data updated: ${totalUsage.toStringAsFixed(1)}L / ${dailyGoal.toInt()}L');
      }
    });
  }

  // Build interactive Flow Rate Card
  Widget _buildFlowRateCard(BuildContext context, ThemeData theme, Color primaryBlue) {
    const successColor = Color(0xFF10B981);
    
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () => _showFlowRateDetails(context, theme, primaryBlue, successColor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.speed,
                      color: primaryBlue,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Current Flow Rate',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black38,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    flowRate.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: primaryBlue,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      'L/min',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.trending_up,
                    size: 16,
                    color: successColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isPumpActive ? 'Normal' : 'Inactive',
                    style: TextStyle(
                      color: isPumpActive ? successColor : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build interactive Total Water Card
  Widget _buildTotalWaterCard(BuildContext context, ThemeData theme, Color primaryBlue, Color successColor) {
    const accentGreen = Color(0xFF059669);
    
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () => _showWaterUsageHistory(context, theme, primaryBlue, successColor),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: accentGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.water,
                      color: accentGreen,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Total Water Used',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black38,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalUsage.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: primaryBlue,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      'liters',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Today • Updated just now',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Flow Rate Details Dialog
  void _showFlowRateDetails(BuildContext context, ThemeData theme, Color primaryBlue, Color successColor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.speed, color: primaryBlue),
            ),
            const SizedBox(width: 12),
            const Text('Flow Rate Details'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Current Rate:', '${flowRate.toStringAsFixed(1)} L/min'),
            _buildDetailRow('Average Rate:', '2.3 L/min'),
            _buildDetailRow('Peak Rate:', '3.1 L/min'),
            _buildDetailRow('Status:', isPumpActive ? 'Normal' : 'Inactive',
                color: isPumpActive ? successColor : Colors.grey[600]),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: primaryBlue, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isPumpActive
                          ? 'Flow rate is within optimal range'
                          : 'System is currently inactive',
                      style: TextStyle(
                        color: primaryBlue,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  // Show Water Usage History Dialog
  void _showWaterUsageHistory(BuildContext context, ThemeData theme, Color primaryBlue, Color successColor) {
    const accentGreen = Color(0xFF059669);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.water, color: accentGreen),
            ),
            const SizedBox(width: 12),
            const Text('Water Usage History'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Today:', '${totalUsage.toStringAsFixed(1)} L'),
            _buildDetailRow('Yesterday:', '52.3 L'),
            _buildDetailRow('This Week:', '315.8 L'),
            _buildDetailRow('This Month:', '1,234.5 L'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_down, color: successColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '12% less than last week',
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Exporting water usage report...');
            },
            child: const Text('Export Report'),
          ),
        ],
      ),
    );
  }

  // Show Irrigation Options
  void _showIrrigationOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manual Irrigation Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Start irrigation for 15 minutes'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Starting irrigation for 15 minutes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Start irrigation for 30 minutes'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Starting irrigation for 30 minutes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.timer),
              title: const Text('Start irrigation for 60 minutes'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Starting irrigation for 60 minutes');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show Schedule Info
  void _showScheduleInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Schedule View Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text('View today\'s irrigation schedule'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Showing today\'s irrigation schedule');
              },
            ),
            ListTile(
              leading: const Icon(Icons.date_range),
              title: const Text('View this week\'s schedule'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Showing this week\'s irrigation schedule');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('View next week\'s schedule'),
              onTap: () {
                Navigator.pop(context);
                _showSnackBar('Showing next week\'s irrigation schedule');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Show System Health
  void _showSystemHealth(BuildContext context) {
    const successColor = Color(0xFF10B981);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.health_and_safety, color: Color(0xFF10B981)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'System Health Check',
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Water Flow Sensors:', 'Normal', color: successColor),
            _buildDetailRow('Soil Moisture Sensors:', 'Normal', color: successColor),
            _buildDetailRow('Pump Status:', isPumpActive ? 'Active' : 'Inactive', 
                color: isPumpActive ? successColor : Colors.grey[600]),
            _buildDetailRow('System Connectivity:', 'Connected', color: successColor),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: successColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: successColor, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'All systems operational',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Running full system diagnostic...');
            },
            child: const Text('Run Diagnostic'),
          ),
        ],
      ),
    );
  }

  // Build detail row for dialogs
  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

