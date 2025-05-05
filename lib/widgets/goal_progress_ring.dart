import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class GoalProgressRing extends StatelessWidget {
  final double progress;

  const GoalProgressRing({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const baseColor = Color(0xFFE3F2FD);

    return SimpleCircularProgressBar(
      size: 120,
      valueNotifier: ValueNotifier((progress * 100).clamp(0.0, 100.0)),
      maxValue: 100,
      progressColors: [const Color(0xFF2196F3)],
      backColor: baseColor.withAlpha(50),
      fullProgressColor: const Color(0xFF2196F3),
      animationDuration: 3,
      startAngle: 0,
      progressStrokeWidth: 12,
      onGetText: (double value) => Text(
        '${value.toInt()}%',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: const Color(0xFF2196F3),
        ),
      ),
    );
  }
}
