import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';
import '../controllers/home_controller.dart';

class O3DViewer extends StatelessWidget {
  const O3DViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return O3D(
      key: const ValueKey('main-o3d'),
      src: 'assets/3d_model/disney_style_character.glb',
      controller: controller.o3dController,
      xrEnvironment: true,
      ar: false,
      autoPlay:  true,
      autoRotate: false,
      cameraControls: false,

      cameraTarget: CameraTarget(-0.50, 1.5, -0.05),
      cameraOrbit: CameraOrbit(0, 90, 1),
    );
  }
}
