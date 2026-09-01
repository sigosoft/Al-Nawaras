import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
import '../view/welcome/welcome_screen.dart';

class LogoutController extends GetxController {
  final Dio dio = BaseClient.dio;

  Future<void> logOut() async {
    try {
      final storage = GetStorage();
      final token = storage.read('token');

      if (kDebugMode) {
        print('\n--- API REQUEST (logout) ---');
        print('URL: ${ApiConstants.logout}');
        print('Headers: Authorization: Bearer $token');
      }

      final response = await dio.post(
        ApiConstants.logout,
        options: Options(
          headers: {'Authorization': 'Bearer $token', 'Accept': '*/*'},
        ),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (logout) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
    } finally {
      final storage = GetStorage();
      await storage.erase();
      Get.offAll(() => const WelcomeScreen());
    }
  }
}
