import 'package:fitness_tracker/bindings/home_binding.dart';
import 'package:fitness_tracker/bindings/register_binding.dart';
import 'package:get/get.dart';

import '../bindings/login_bindings.dart';
import '../bindings/splash_binding.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/history_screens.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static final String initial = '/';
  static const String login = '/login';
  static const String register = '/register';
  static final String home = '/home';
  static final String history = '/history';
  static final String editProfile = '/edit-profile';

  static final routes = [
    GetPage(
      name: initial,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
      name: register,
      page: () => RegisterScreen(),
      binding: RegisterBindings(),
    ),

    // Here we read the UID from Get.arguments
    GetPage(name: history, page: () => HistoryScreen(uid: Get.arguments)),
    GetPage(name: editProfile, page:()=>EditProfileScreen()),
  ];
}
