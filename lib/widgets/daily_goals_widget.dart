import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/daily_goal_controller.dart';
import 'goal_progress_ring.dart';
import 'goal_section_card.dart';

class DailyGoalsWidget extends StatelessWidget {
  DailyGoalsWidget({super.key});

  final controller = Get.put(DailyGoalsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Daily Goals',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            final totalProgress = controller.calculateTotalProgress(
              controller.healthController.calories.value,
              controller.healthController.stepController.stepCount.value,
              controller.sleepHours.value.toDouble(),
              controller.waterIntake.value * 0.25,
              controller.healthController.bmi.value,
            );
            return Center(child: GoalProgressRing(progress: totalProgress));
          }),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Obx(()=>GoalSectionCards(
                sleptHours: controller.sleepHours.value.toDouble(),
                waterGlasses: controller.waterIntake.value,
              ),)
            ),
          ),
        ],
      ),
    );
  }
}
