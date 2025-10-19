import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class IrrigationProvider extends ChangeNotifier {
  bool _isPumpActive = true;
  double _flowRate = 2.5;
  double _totalUsage = 45.0;
  final double _dailyGoal = 100.0;
  Timer? _simulationTimer;

  IrrigationProvider() {
    _startSimulation();
  }

  bool get isPumpActive => _isPumpActive;
  double get flowRate => _flowRate;
  double get totalUsage => _totalUsage;
  double get dailyGoal => _dailyGoal;
  double get usagePercentage => (_totalUsage / _dailyGoal * 100).clamp(0, 100);

  void _startSimulation() {
    _simulationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_isPumpActive) {
        final random = Random();
        _flowRate = max(1.5, min(4.0, _flowRate + (random.nextDouble() - 0.5) * 0.3));
        _totalUsage += 0.05;
      } else {
        _flowRate = 0;
      }
      notifyListeners();
    });
  }

  void togglePump() {
    _isPumpActive = !_isPumpActive;
    notifyListeners();
  }

  @override
  void dispose() {
    _simulationTimer?.cancel();
    super.dispose();
  }
}
