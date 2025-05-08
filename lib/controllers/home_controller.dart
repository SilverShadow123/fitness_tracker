import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:o3d/o3d.dart';

import '../firebase/service/fireservice.dart';
import '../routes/app_routes.dart';

class HomeController extends GetxController {
  final PageController textsPageController = PageController();
  final PageController mainPageController = PageController();
  final O3DController o3dController = O3DController();

  var page = 0.obs;
  var gender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserGender();
  }

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
        if (gender.value.toLowerCase() == 'female') {
          o3dController.cameraTarget(-0.4, 1.5, -0.30);
          o3dController.cameraOrbit(0, 90, 1);
          break;
        } else {
          o3dController.cameraTarget(-0.25, 1, -0.50);
          o3dController.cameraOrbit(0, 90, 1);
          break;
        }

      case 1:
        if (gender.value.toLowerCase() == 'female') {
          o3dController.cameraTarget(0, 1.5, -0.50);
          o3dController.cameraOrbit(-90, 90, 1.5);
          break;
        } else {
          o3dController.cameraTarget(0, 1, -0.40);
          o3dController.cameraOrbit(-90, 90, 1.5);
          break;
        }

      case 2:
        if (gender.value.toLowerCase() == 'female') {
          o3dController.cameraTarget(-0.4, 1.5, -0.20);
          o3dController.cameraOrbit(0, 90, -7);
          break;
        } else {
          o3dController.cameraTarget(-0.3, 1, -0.40);
          o3dController.cameraOrbit(0, 90, -7);
          break;
        }
    }

    page.value = pageIndex;
  }

  Future<void> fetchUserGender() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final profile = await FirestoreService().getUserProfile(uid);
        gender.value = profile?['gender'] ?? '';
      }
    } catch (e) {
      print('Error fetching gender: $e');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    textsPageController.dispose();
    mainPageController.dispose();
    super.onClose();
  }
}
