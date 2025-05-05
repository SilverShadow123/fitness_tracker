import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

import '../routes/app_routes.dart';

class HomeController extends GetxController {
  final PageController textsPageController = PageController();
  final PageController mainPageController = PageController();
  final O3DController o3dController = O3DController();
  var page = 0.obs;

  void onPageChanged(int pageIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mainPageController.hasClients) {
        mainPageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
      if (textsPageController.hasClients) {
        textsPageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });

    switch (pageIndex) {
      case 0:

        o3dController.cameraTarget(-0.50, 1.5, -0.05);
        o3dController.cameraOrbit(0, 90, 1);
        break;
      case 1:
        o3dController.cameraTarget(0, 1.5, -0.50);
        o3dController.cameraOrbit(-90, 90, 1.5);
        break;
      case 2:
        o3dController.cameraTarget(-0.55, 1.5, 0);
        o3dController.cameraOrbit(0, 90, -7);

        break;
    }

    page.value = pageIndex;
  }
  @override
  void onClose() {
    // TODO: implement onClose
    textsPageController.dispose();
    mainPageController.dispose();
    super.onClose();
  }
  void logout() async{
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}
