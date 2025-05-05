import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_goals_controller.dart';

class AddGoalsSetSleepWater extends StatelessWidget {
  const AddGoalsSetSleepWater({super.key});

  static const Color bgColor = Color(0xFFE3F2FD);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoalsController>(
      init: GoalsController(),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade100.withAlpha(80),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Set Your Goals",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1.5),
                const SizedBox(height: 12),

                // Scrollable content
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _animatedInputField(controller.stepsController, 'Daily Steps', Icons.directions_walk),
                        _animatedInputField(controller.caloriesController, 'Daily Calories', Icons.local_fire_department),
                        _animatedInputField(controller.targetSleepController, 'Target Sleep (hrs)', Icons.bedtime),
                        _animatedInputField(controller.waterGoalController, 'Water Goal (L)', Icons.water_drop),
                        _animatedInputField(controller.bmiController, 'BMI Goal', Icons.monitor_weight),

                        const SizedBox(height: 16),

                        // Save Button
                        _actionButton(
                          label: 'Save Goals',
                          icon: Icons.check_circle,
                          color: Colors.blue.shade700,
                          onPressed: controller.saveGoals,
                        ),
                        const SizedBox(height: 10),

                        // Exit Button
                        _actionButton(
                          label: 'Exit',
                          icon: Icons.close,
                          color: Colors.red.shade600,
                          onPressed: () => Get.back(),
                        ),
                        const SizedBox(height: 4), // Minimal spacing at bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _animatedInputField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 400),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(offset: Offset(0, (1 - value) * 20), child: child),
          );
        },
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(icon, color: Colors.blue.shade600),
            labelStyle: const TextStyle(color: Colors.blue),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade700),
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
