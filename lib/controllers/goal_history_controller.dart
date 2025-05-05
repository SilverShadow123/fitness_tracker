import 'package:get/get.dart';
import 'package:fitness_tracker/firebase/service/fireservice.dart';

class GoalsHistoryController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  var historyList = <Map<String, dynamic>>[].obs; // List to hold history data
  var isLoading = true.obs; // Observable to show loading state

  // Method to load history from Firestore
  Future<void> loadHistory(String uid) async {
    try {
      isLoading(true); // Show loading indicator
      final history = await _firestoreService.getDailyGoalsHistory(uid);
      historyList.assignAll(history); // Update the list with fetched data
    } catch (e) {
      Get.snackbar("Error", "Failed to load goals history");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}
