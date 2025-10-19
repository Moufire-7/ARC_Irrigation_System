import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/stat_card.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Water Usage Statistics',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Analyze your irrigation efficiency and patterns',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 24),

          // Summary Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              return isWide
                  ? Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Average Flow Rate',
                            value: '2.3',
                            unit: 'L/min',
                            icon: Icons.water_drop,
                            trend: 8,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Total This Week',
                            value: '155',
                            unit: 'liters',
                            icon: Icons.trending_up,
                            trend: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Efficiency',
                            value: '94',
                            unit: '%',
                            icon: Icons.analytics,
                            trend: 3,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        StatCard(
                          title: 'Average Flow Rate',
                          value: '2.3',
                          unit: 'L/min',
                          icon: Icons.water_drop,
                          trend: 8,
                        ),
                        const SizedBox(height: 16),
                        StatCard(
                          title: 'Total This Week',
                          value: '155',
                          unit: 'liters',
                          icon: Icons.trending_up,
                          trend: 12,
                        ),
                        const SizedBox(height: 16),
                        StatCard(
                          title: 'Efficiency',
                          value: '94',
                          unit: '%',
                          icon: Icons.analytics,
                          trend: 3,
                        ),
                      ],
                    );
            },
          ),
          const SizedBox(height: 24),

          // Water Usage Trend
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Water Usage Trend',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                if (value.toInt() >= 0 && value.toInt() < days.length) {
                                  return Text(days[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 10),
                              FlSpot(1, 15),
                              FlSpot(2, 20),
                              FlSpot(3, 18),
                              FlSpot(4, 22),
                              FlSpot(5, 25),
                              FlSpot(6, 45),
                            ],
                            isCurved: true,
                            color: Theme.of(context).colorScheme.primary,
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Scheduled vs Actual
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scheduled vs Actual Irrigation',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                if (value.toInt() >= 0 && value.toInt() < days.length) {
                                  return Text(days[value.toInt()]);
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          _buildBarGroup(0, 12, 10, context),
                          _buildBarGroup(1, 14, 15, context),
                          _buildBarGroup(2, 18, 20, context),
                          _buildBarGroup(3, 16, 18, context),
                          _buildBarGroup(4, 20, 22, context),
                          _buildBarGroup(5, 22, 25, context),
                          _buildBarGroup(6, 40, 45, context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Irrigation Events Table
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Irrigation Events',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Duration')),
                        DataColumn(label: Text('Volume')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('2025-10-30')),
                          DataCell(Text('08:00')),
                          DataCell(Text('15 min')),
                          DataCell(Text('25 liters', style: TextStyle(fontWeight: FontWeight.bold))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2025-10-29')),
                          DataCell(Text('08:00')),
                          DataCell(Text('15 min')),
                          DataCell(Text('22 liters', style: TextStyle(fontWeight: FontWeight.bold))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2025-10-28')),
                          DataCell(Text('08:00')),
                          DataCell(Text('15 min')),
                          DataCell(Text('18 liters', style: TextStyle(fontWeight: FontWeight.bold))),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2025-10-27')),
                          DataCell(Text('08:00')),
                          DataCell(Text('15 min')),
                          DataCell(Text('20 liters', style: TextStyle(fontWeight: FontWeight.bold))),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double scheduled, double actual, BuildContext context) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: scheduled,
          color: Colors.grey.shade400,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        BarChartRodData(
          toY: actual,
          color: Theme.of(context).colorScheme.primary,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}
