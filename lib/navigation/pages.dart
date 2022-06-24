import 'package:capitan_test_project/navigation/routes.dart';
import 'package:capitan_test_project/screens/login_screen.dart';
import 'package:capitan_test_project/screens/main_page.dart';
import 'package:capitan_test_project/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String,Widget Function(BuildContext)> appRoutes(BuildContext context) {
  return {
    Routes.splash : (context) => const SplashScreen(),
    Routes.login : (context) => const LoginScreen(),
    Routes.main : (context) => const MainScreen(),
  };
}