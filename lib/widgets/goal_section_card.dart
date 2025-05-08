import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/daily_goal_controller.dart';
import '../controllers/step_calculation_controller.dart';
import '../controllers/cal_bmi_other_calculation_controller.dart';
import 'goal_card.dart';

class GoalSectionCards extends StatelessWidget {
  final double sleptHours;
  final int waterGlasses;

  const GoalSectionCards({
    super.key,
    required this.sleptHours,
    required this.waterGlasses,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyGoalsController>();
    final healthCalculationController = Get.find<HealthCalculationController>();
    final stepCalculationController = Get.find<StepCalculationController>();
    final double glassSize = 0.25;
    final double waterConsumed = waterGlasses * glassSize;

    return Obx(() {
      final goal = controller.goalModel.value;
      final caloriesGoal = goal?.calories ?? 1000;
      final caloriesConsumed = healthCalculationController.calories;
      final caloriesProgress = (caloriesConsumed / caloriesGoal).clamp(
        0.0,
        1.0,
      );

      final stepsGoal = goal?.steps ?? 10000;
      final stepsTaken = stepCalculationController.stepCount;
      final stepsProgress = (stepsTaken / stepsGoal).clamp(0.0, 1.0);

      final sleepGoal = goal?.sleepGoal ?? 8;
      final sleepProgress = (sleptHours / sleepGoal).clamp(0.0, 1.0);

      final waterGoal = goal?.waterGoal ?? 2.0;
      final waterProgress = (waterConsumed / waterGoal).clamp(0.0, 1.0);

      final bmiGoal = goal?.bmiGoal ?? 22.5;
      final currentBMI = double.parse(
        healthCalculationController.bmi.value.toStringAsFixed(2),
      );
      final bmiProgress = (1 - ((currentBMI - bmiGoal).abs() / bmiGoal)).clamp(
        0.0,
        1.0,
      );

      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          GoalCard(
            context: context,
            icon: Icons.local_fire_department,
            title: 'Calories',
            target: '$caloriesGoal kcal',
            progress: caloriesProgress,
            isExpanded: controller.isCaloriesExpanded.value,
            onTap: controller.toggleCalories,
            children: [
              Text('Goal: $caloriesGoal kcal'),
              Text('Consumed: $caloriesConsumed kcal'),
              Text(
                'Remaining: ${(caloriesGoal - caloriesConsumed.value).clamp(0, caloriesGoal)} kcal',
              ),
            ],
          ),
          GoalCard(
            context: context,
            icon: Icons.directions_walk,
            title: 'Steps',
            target: '$stepsGoal steps',
            progress: stepsProgress,
            isExpanded: controller.isStepsExpanded.value,
            onTap: controller.toggleSteps,
            children: [
              Text('Goal: $stepsGoal steps'),
              Text('Taken: $stepsTaken steps'),
              Text(
                'Remaining: ${(stepsGoal - stepsTaken.value).clamp(0, stepsGoal)} steps',
              ),
            ],
          ),
          GoalCard(
            context: context,
            icon: Icons.bedtime,
            title: 'Sleep',
            target: '$sleepGoal hrs',
            progress: sleepProgress,
            isExpanded: controller.isSleepExpanded.value,
            onTap: controller.toggleSleep,
            children: [
              Text('Goal: $sleepGoal hrs'),
              Text('Slept: $sleptHours hrs'),
              Text(
                'Remaining: ${(sleepGoal - sleptHours).clamp(0, sleepGoal)} hrs',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateSleepHours();
                    },
                    child: const Icon(Icons.add, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          GoalCard(
            context: context,
            icon: Icons.water_drop,
            title: 'Water Intake',
            target: '${waterGoal}L',
            progress: waterProgress,
            isExpanded: controller.isWaterIntakeExpanded.value,
            onTap: controller.toggleWaterIntake,
            children: [
              Text('Goal: ${waterGoal}L'),
              Text('Consumed: $waterGlasses glasses (${waterConsumed}L)'),
              Text(
                'Remaining: ${(waterGoal - waterConsumed).clamp(0.0, waterGoal)}L',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.updateWaterIntake();
                    },
                    child: const Icon(Icons.add, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          GoalCard(
            context: context,
            icon: Icons.monitor_weight,
            title: 'BMI',
            target: '$bmiGoal',
            progress: bmiProgress,
            isExpanded: controller.isBMIExpanded.value,
            onTap: controller.toggleBMI,
            children: [
              Text('Goal: $bmiGoal'),
              Text('Current: $currentBMI'),
              Text('Remaining: ${(bmiGoal - currentBMI).toStringAsFixed(1)}'),
              Text('Status:'),
              healthCalculationController.bmiChart(),
            ],
          ),
        ],
      );
    });
  }
}
