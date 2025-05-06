import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker/controllers/daily_goal_controller.dart';
import 'package:fitness_tracker/controllers/step_calculation_controller.dart';
import 'package:fitness_tracker/widgets/add_goals_set_sleep_water.dart';
import 'package:fitness_tracker/widgets/custom_bottom_nav_bar.dart';
import 'package:fitness_tracker/widgets/daily_goals_widget.dart';
import 'package:fitness_tracker/widgets/journal_widget.dart';
import 'package:fitness_tracker/widgets/o3d_viewer.dart';
import 'package:fitness_tracker/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  // Grab the current Firebase user ID once
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  final StepCalculationController stepCalculationController =
      Get.find<StepCalculationController>();
  final DailyGoalsController dailyGoalsController =
      Get.find<DailyGoalsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Stack(
          children: [
            const O3DViewer(),

            // Our PageView with three pages
            Container(
              width: 188,
              margin: const EdgeInsets.all(12),
              child: PageView(
                controller: controller.textsPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  DailyGoalsWidget(),
                  JournalWidget(uid: uid), // ← Pass real UID here
                  ProfileWidget(),
                ],
              ),
            ),

            // Top‑right actions for page 0 (Daily Goals)
            Obx(() {
              if (controller.page.value == 0) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            dailyGoalsController.resetGoals();
                            dailyGoalsController.resetWaterAndSleep();
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
                              builder: (_) => const AddGoalsSetSleepWater(),
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
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            // Top‑right logout for page 2 (Profile)
            Obx(() {
              if (controller.page.value == 2) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 48.0,
                      horizontal: 16.0,
                    ),
                    child: GestureDetector(
                      onTap: controller.logout,
                      child: Icon(
                        Icons.logout,
                        color: Colors.red[800],
                        size: 28,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
