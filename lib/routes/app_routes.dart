import 'package:fitness_tracker/bindings/home_binding.dart';
import 'package:fitness_tracker/bindings/register_binding.dart';
import 'package:get/get.dart';

import '../bindings/login_bindings.dart';
import '../bindings/splash_binding.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes  {
   static final String initial = '/';
   static const String login = '/login';
   static const String register = '/register';
   static final String home = '/home';



  // static const String profile = '/profile';
  // static const String settings = '/settings';


 static final routes = [
    GetPage(name: initial, page: () => SplashScreen(),binding: SplashBinding()),
    GetPage(name: home, page: () => HomeScreen(),binding: HomeBinding()),
    GetPage(name: login, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(name: register, page: () => RegisterScreen(), binding: RegisterBindings()),
    // GetPage(name: profile, page: () => ProfileScreen()),
    // GetPage(name: settings, page: () => SettingsScreen()),
  ];
}