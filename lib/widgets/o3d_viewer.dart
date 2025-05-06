import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';
import '../controllers/home_controller.dart';

class O3DViewer extends StatelessWidget {
  const O3DViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    // Observe the gender value
    return Obx(() {
      // If gender is not available, show a loading spinner
      if (controller.gender.value.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      // Get the gender and choose model path accordingly
      final gender = controller.gender.value;
      final modelSrc = gender.toLowerCase() != 'male'
          ? 'assets/3d_model/disney_style_character.glb'
          : 'assets/3d_model/thalapathy_vijay_3d_model.glb';

      // Define camera target based on gender
      final cameraTarget = gender.toLowerCase() != 'male'
          ? CameraTarget(-0.4, 1.5, -0.30)
          : CameraTarget(-0.25, 1, -0.50);

      // Return the O3D widget with dynamic camera and model source
      return O3D(
        key: const ValueKey('main-o3d'),
        src: modelSrc,
        controller: controller.o3dController,
        xrEnvironment: true,
        ar: false,
        autoPlay: true,
        autoRotate: false,
        cameraControls: false,
        cameraTarget: cameraTarget,
        cameraOrbit: CameraOrbit(0, 90, 1),
      );
    });
  }
}
