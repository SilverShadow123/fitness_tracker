import 'package:get/get.dart';
import '../firebase/service/fireservice.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  var name = 'Dis'.obs;
  var age = 23.obs;
  var weight = 68.5.obs;
  var height = 175.0.obs;
  var status = 'Active'.obs;
  var history = 'Latest'.obs;
  var uid = ''.obs;

  // Set the UID for the current user
  void setUid(String newUid) {
    uid.value = newUid;
  }

  // Load user profile data from Firestore
  Future<void> loadUserProfileData() async {
    if (uid.isEmpty) return;

    try {
      final data = await _firestoreService.getUserProfile(uid.value);

      if (data != null) {
        name.value = data['name'] ?? 'Dis';
        age.value = int.tryParse(data['age']?.toString() ?? '') ?? 23;
        weight.value =
            double.tryParse(data['weight']?.toString() ?? '') ?? 68.5;
        height.value = double.tryParse(data['height']?.toString() ?? '') ?? 175;
        status.value = data['status'] ?? 'Active';
        history.value = data['history'] ?? 'Latest';
      }
    } catch (e) {
      print('Error loading user profile: $e');
    }
  }

  // Update the profile in Firestore
  Future<void> updateProfileInFirestore({
    required String newName,
    required int newAge,
    required double newWeight,
    required double newHeight,
  }) async {
    if (uid.isEmpty) return;

    try {
      await _firestoreService.updateUserProfile(
        uid.value,
        name: newName,
        age: newAge.toString(),
        weight: newWeight.toString(),
        height: newHeight.toString(),
      );
      loadUserProfileData(); // Refresh the data after update
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }
}
