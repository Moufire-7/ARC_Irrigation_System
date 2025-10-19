import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressWidget extends StatelessWidget {
  final double value;
  final double maxValue;
  final double size;

  const CircularProgressWidget({
    super.key,
    required this.value,
    required this.maxValue,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (value / maxValue * 100).clamp(0, 100);
    final progressValue = (value / maxValue).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 16,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
          // Progress circle
          SizedBox(
            width: size,
            height: size,
            child: Transform.rotate(
              angle: -math.pi / 2,
              child: CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 16,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          // Center text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: size * 0.15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                'liters',
                style: TextStyle(
                  fontSize: size * 0.06,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${percentage.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: size * 0.08,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                'of daily goal',
                style: TextStyle(
                  fontSize: size * 0.05,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
