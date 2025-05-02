
import 'package:fitness_tracker/widgets/add_goals_set_sleep_water.dart';
import 'package:fitness_tracker/widgets/o3d_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/step_calculation_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/daily_goals_widget.dart';
import '../widgets/journal_widget.dart';
import '../widgets/profile_widget.dart';

class HomeScreen extends GetView<HomeController> {
   HomeScreen({super.key});
final StepCalculationController stepCalculationController = Get.find<StepCalculationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            const O3DViewer(),
            Container(
              width: 188,
              height: double.infinity,
              margin: const EdgeInsets.all(12),
              child: PageView(
                controller: controller.textsPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DailyGoalsWidget(),
                  JournalWidget(),
                  ProfileWidget(),
                ],
              ),
            ),
            Obx(() {
              if (controller.page.value == 0) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Fitnessify',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),

                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                               stepCalculationController.resetStepCount();
                              },

                              child: Icon(
                                Icons.replay,
                                color: Colors.blue[800],
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const AddGoalsSetSleepWater(),
                                );
                              },

                              child: Icon(
                                Icons.add,
                                color: Colors.blue[800],
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            Obx((){
              if (controller.page.value == 2) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap:(){},
                      child: Icon(
                        Icons.logout,
                        color: Colors.red[800],
                        size: 28,
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
