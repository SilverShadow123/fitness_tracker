import 'package:fitness_tracker/controllers/cal_bmi_other_calculation_controller.dart';
import 'package:fitness_tracker/controllers/step_calculation_controller.dart';
import 'package:fitness_tracker/firebase/service/fireservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../controllers/daily_goal_controller.dart';
import 'goal_card.dart';

class DailyGoalsWidget extends GetView<DailyGoalsController> {
  DailyGoalsWidget({super.key});
  final StepCalculationController stepCalculationController = Get.find<StepCalculationController>();
  final HealthCalculationController healthCalculationController = Get.find<HealthCalculationController>();
  final FirestoreService firestoreService = Get.find<FirestoreService>();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const baseColor = Color(0xFFE3F2FD);
    final controller = Get.put(DailyGoalsController());

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
          Center(
            child: SimpleCircularProgressBar(
              size: 120,
              valueNotifier: ValueNotifier(86),
              maxValue: 100,
              progressColors: [const Color(0xFF2196F3)],
              backColor: baseColor.withAlpha(50),
              fullProgressColor: const Color(0xFF2196F3),
              animationDuration: 3,
              startAngle: 0,
              progressStrokeWidth: 12,
              onGetText: (double value) =>
                  Text(
                    '${value.toInt()}%',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: const Color(0xFF2196F3),
                    ),
                  ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8.0),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Obx(() =>
                      SizedBox(
                        width: 148,
                        child: GoalCard(
                          context: context,
                          icon: Icons.local_fire_department,
                          title: 'Calories',
                          target: '1000 kcal',
                          progress: 0.75,
                          isExpanded: controller.isCaloriesExpanded.value,
                          onTap: controller.toggleCalories,
                          children: [
                            Text('Goal: ${controller.goalModel.value?.calories} kcal'),
                            Text('Consumed: ${healthCalculationController.calories} kcal'),
                            Text('Remaining: 500 kcal'),
                          ],
                        ),
                      )),
                  Obx(() =>
                      SizedBox(
                        width: 148,
                        child: GoalCard(
                          context: context,
                          icon: Icons.directions_walk,
                          title: 'Steps',
                          target: '10000 steps',
                          progress: 0.60,
                          isExpanded: controller.isStepsExpanded.value,
                          onTap: controller.toggleSteps,
                          children: [
                            Text('Goal: 10000 steps'),
                            Text('Taken: ${stepCalculationController.stepCount} steps'),
                            Text('Remaining: 4000 steps'),
                          ],
                        ),
                      )),
                  Obx(() =>
                      SizedBox(
                        width: 148,
                        child: GoalCard(
                          context: context,
                          icon: Icons.bedtime,
                          title: 'Sleep',
                          target: '8 hrs',
                          progress: 0.50,
                          isExpanded: controller.isSleepExpanded.value,
                          onTap: controller.toggleSleep,
                          children: [
                            Text('Goal: ${controller.goalModel.value?.sleepGoal} hrs'),
                            const Text('Slept: 4 hrs'),
                            const Text('Remaining: 4 hrs'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(onTap: (){},child: const Icon(Icons.add,color: Colors.blue, ),)
                              ],
                            )
                          ],
                        ),
                      )),
                  Obx(() =>
                      SizedBox(
                        width: 148,
                        child: GoalCard(
                          context: context,
                          icon: Icons.water_drop,
                          title: 'Water Intake',
                          target: '2L',
                          progress: 0.40,
                          isExpanded: controller.isWaterIntakeExpanded.value,
                          onTap: controller.toggleWaterIntake,
                          children: [
                            Text('Goal: ${controller.goalModel.value?.waterGoal}L'),
                            Text('Consumed: 2 glass'),
                            const Text('Remaining: 1.2L'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(onTap: (){},child: const Icon(Icons.add,color: Colors.blue, ),)
                              ],
                            )
                          ],
                        ),
                      )),
                  Obx(() =>
                      SizedBox(
                        width: 148,
                        child: GoalCard(
                          context: context,
                          icon: Icons.monitor_weight,
                          title: 'BMI',
                          target: '22.5',
                          progress: 0.80,
                          isExpanded: controller.isBMIExpanded.value,
                          onTap: controller.toggleBMI,
                          children: [
                            Text('Goal: ${controller.goalModel.value?.bmiGoal}'),
                            const Text('Current: 23.0'),
                            const Text('Remaining: -0.5'),

                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }}