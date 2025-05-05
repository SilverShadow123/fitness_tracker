import 'package:fitness_tracker/controllers/goal_history_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoalsHistoryController>(
      () => GoalsHistoryController(),
    );
  }
}