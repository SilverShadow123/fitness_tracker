import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = 'Dis'.obs;
  var age = 23.obs;
  var weight = 68.5.obs; // kg
  var height = 175.0.obs;  // cm
  var status = 'Active'.obs;
  var history = 'Latest'.obs;

  // Function to update profile
  void updateProfile(String newName, int newAge, double newWeight, double newHeight, String newStatus) {
    name.value = newName;
    age.value = newAge;
    weight.value = newWeight;
    height.value = newHeight;
    status.value = newStatus;
  }
}
