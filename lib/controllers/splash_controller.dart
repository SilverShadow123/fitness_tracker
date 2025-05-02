import 'package:fitness_tracker/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  @override

  void onInit() {
    super.onInit();
    // Simulate a delay for splash screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the home screen after the delay
      Get.offNamed(AppRoutes.login);
    });
  }
}