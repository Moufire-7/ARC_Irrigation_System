import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'System Settings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure your irrigation system',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 24),

          // LoRa Network Configuration
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LoRa Network Configuration',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _SettingField(
                    label: 'Frequency (MHz)',
                    initialValue: '433',
                  ),
                  const SizedBox(height: 16),
                  _SettingField(
                    label: 'Network ID',
                    initialValue: '1234567890',
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Spreading Factor'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: 'SF7',
                        items: const [
                          DropdownMenuItem(value: 'SF7', child: Text('SF7')),
                          DropdownMenuItem(value: 'SF8', child: Text('SF8')),
                          DropdownMenuItem(value: 'SF9', child: Text('SF9')),
                          DropdownMenuItem(value: 'SF10', child: Text('SF10')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Connection test successful')),
                      );
                    },
                    child: const Text('Test Connection'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // API Endpoint
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'API Endpoint',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _SettingField(
                    label: 'API URL',
                    initialValue: 'https://api.irrigation.uwc.ac.za',
                  ),
                  const SizedBox(height: 16),
                  _SettingField(
                    label: 'API Key',
                    initialValue: '••••••••••••••',
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  _SettingField(
                    label: 'Sync Interval (minutes)',
                    initialValue: '15',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sync completed')),
                      );
                    },
                    child: const Text('Sync Now'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // General Settings
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Settings',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Measurement Unit'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: 'liters',
                        items: const [
                          DropdownMenuItem(value: 'liters', child: Text('Liters')),
                          DropdownMenuItem(value: 'gallons', child: Text('Gallons')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dark Mode',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Toggle between light and dark theme',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (_) => themeProvider.toggleTheme(),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Language'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: 'english',
                        items: const [
                          DropdownMenuItem(value: 'english', child: Text('English')),
                          DropdownMenuItem(value: 'afrikaans', child: Text('Afrikaans')),
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

          // About
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const _AboutRow(label: 'Version', value: '1.0.0'),
                  const _AboutRow(label: 'Group', value: 'IFS325/353 Group 1'),
                  const _AboutRow(label: 'University', value: 'University of the Western Cape'),
                  const _AboutRow(label: 'Year', value: '2025'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('View Documentation'),
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

class _SettingField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool obscure;

  const _SettingField({
    required this.label,
    required this.initialValue,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscure,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class _AboutRow extends StatelessWidget {
  final String label;
  final String value;

  const _AboutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
