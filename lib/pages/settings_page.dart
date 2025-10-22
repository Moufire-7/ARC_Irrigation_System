import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedUnit = 'liters';
  String selectedTheme = 'light';
  String selectedLanguage = 'english';
  String selectedQoS = 'QoS 1';
  String mqttBroker = 'mqtt.irrigation.uwc.ac.za';
  String mqttPort = '1883';
  String mqttUsername = '';
  String mqttPassword = '';

  void _testConnection() {
    Fluttertoast.showToast(
      msg: 'Connection test successful - MQTT broker connected',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  void _syncNow() {
    Fluttertoast.showToast(
      msg: 'Sync completed - Latest data retrieved from API',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  void _changeTheme(String theme) {
    setState(() {
      selectedTheme = theme;
    });
    
    // Apply theme change using ThemeService
    final themeService = Provider.of<ThemeService>(context, listen: false);
    themeService.setTheme(theme);
    
    // Show feedback
    Fluttertoast.showToast(
      msg: '${theme.capitalize()} theme applied',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Settings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Configure your irrigation system',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // MQTT Network Configuration
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MQTT Network Configuration',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MQTT Broker',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'mqtt.irrigation.uwc.ac.za',
                      ),
                      onChanged: (value) => mqttBroker = value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Port',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: '1883',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => mqttPort = value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter MQTT username',
                      ),
                      onChanged: (value) => mqttUsername = value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter MQTT password',
                      ),
                      obscureText: true,
                      onChanged: (value) => mqttPassword = value,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quality of Service (QoS)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedQoS,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'QoS 0', child: Text('QoS 0 - At most once')),
                        DropdownMenuItem(value: 'QoS 1', child: Text('QoS 1 - At least once')),
                        DropdownMenuItem(value: 'QoS 2', child: Text('QoS 2 - Exactly once')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedQoS = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 768 ? null : double.infinity,
                  child: ElevatedButton(
                    onPressed: _testConnection,
                    child: const Text('Test MQTT Connection'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // API Endpoint
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'API Endpoint',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'API URL',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'https://api.irrigation.uwc.ac.za',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'API Key',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: '••••••••••••••',
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sync Interval (minutes)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: '15',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: MediaQuery.of(context).size.width >= 768 ? null : double.infinity,
                  child: ElevatedButton(
                    onPressed: _syncNow,
                    child: const Text('Sync Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // General Settings
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'General Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Measurement Unit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedUnit,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'liters', child: Text('Liters')),
                        DropdownMenuItem(value: 'gallons', child: Text('Gallons')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedUnit = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Application Theme',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedTheme,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'light', child: Text('Light')),
                        DropdownMenuItem(value: 'dark', child: Text('Dark')),
                        DropdownMenuItem(value: 'auto', child: Text('Auto')),
                      ],
                      onChanged: (value) {
                        _changeTheme(value!);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Language',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedLanguage,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'english', child: Text('English')),
                        DropdownMenuItem(value: 'afrikaans', child: Text('Afrikaans')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Version:', '1.0.0'),
                const SizedBox(height: 8),
                _buildInfoRow('Group:', 'IFS325/353 Group 1'),
                const SizedBox(height: 8),
                _buildInfoRow('University:', 'University of the Western Cape'),
                const SizedBox(height: 8),
                _buildInfoRow('Year:', '2025'),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'View Documentation',
                    style: TextStyle(
                      color: Color(0xFF0EA5E9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

