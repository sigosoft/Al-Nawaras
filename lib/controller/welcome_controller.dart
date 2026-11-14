import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../view/register/register_screen.dart';
import '../view/login/login_screen.dart';
import 'home_controller.dart';

class WelcomeController extends GetxController {
  final _storage = GetStorage();

  void goToLogin() {
    // Navigate to Login Screen
    if (kDebugMode) {
      print("Navigate to Login");
    }
    Get.to(() => const LoginScreen());
  }

  void goToRegister() {
    // Navigate to Register Screen
    if (kDebugMode) {
      print("Navigate to Register");
    }
    Get.to(() => const RegisterScreen());
  }

  Future<void> changeLanguage(String langCode) async {
    if (Get.locale?.languageCode == langCode) return;
    Locale locale = Locale(langCode);
    _storage.write('lang', langCode);
    await Get.updateLocale(locale);
    update();

    // Home and Bookings translate API values (booking state, plan type,
    // membership status/tier) and format dates when their data is loaded,
    // and the tabs stay alive across language changes, so reload them once
    // the new locale is in place.
    await WidgetsBinding.instance.endOfFrame;
    if (Get.isRegistered<HomeController>()) {
      final home = Get.find<HomeController>();
      home.fetchHomeData();
      home.fetchParkingHistory(reset: true);
    }
  }

  String getCurrentLocale() {
    return _storage.read('lang') ?? 'en';
  }
}
