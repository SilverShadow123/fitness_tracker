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
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: DefaultTabController(
            length: 2,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100.withAlpha(50),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        labelStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelColor: Colors.blue.shade900,
                        unselectedLabelColor: Colors.blue.shade500,
                        tabs: const [
                          Tab(text: 'Goals'),
                        ],
                      ),
                    ),

                    Flexible(
                      fit: FlexFit.tight,
                      child: TabBarView(
                        children: [
                          // Goals Tab
                          SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: controller.stepsController,
                                  label: 'Daily Steps',
                                  icon: Icons.directions_walk,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: controller.caloriesController,
                                  label: 'Daily Calories',
                                  icon: Icons.fastfood,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: controller.targetSleepController,
                                  label: 'Target Sleep (hrs)',
                                  icon: Icons.bedtime,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: controller.waterGoalController,
                                  label: 'Water Goal (L)',
                                  icon: Icons.water_drop_outlined,
                                ),
                                const SizedBox(height: 16),
                                _buildTextField(
                                  controller: controller.bmiController,
                                  label: 'BMI Goal',
                                  icon: Icons.monitor_weight_outlined,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: controller.saveGoals,
                                  icon: const Icon(Icons.check, color: Colors.white),
                                  label: const Text('Save Goals', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade700,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton.icon(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(Icons.dangerous_outlined, color: Colors.red),
                                  label: const Text('Exit', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red.shade700,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Sleep & Water Tab
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade700),
        ),
      ),
    );
  }
}
