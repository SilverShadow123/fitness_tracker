import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/goal_history_controller.dart';

class DailyGoalsHistoryWidget extends StatelessWidget {
  final String uid; // User ID to fetch the history for

  DailyGoalsHistoryWidget({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GetX controller to manage the state
    final GoalsHistoryController controller = Get.put(GoalsHistoryController());

    // Load the history when the widget is built
    controller.loadHistory(uid);

    return Obx(() {
      // Show loading spinner while the history data is loading
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // If history list is empty
      if (controller.historyList.isEmpty) {
        return Center(child: Text('No history available.'));
      }

      // Display the history data in a list
      return ListView.builder(
        itemCount: controller.historyList.length,
        itemBuilder: (context, index) {
          final entry = controller.historyList[index];
          final savedAt = (entry['savedAt'] as Timestamp).toDate();

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text("Goal on ${savedAt.toLocal()}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Calories: ${entry['calories']}"),
                  Text("Steps: ${entry['steps']}"),
                  Text("Target Sleep: ${entry['targetsleep']} hrs"),
                  Text("Water Intake: ${entry['targetwater']} liters"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
