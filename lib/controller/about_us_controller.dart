import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'base_client.dart';
import '../config/api_constants.dart';

class AboutUsController extends GetxController {
  final Dio dio = BaseClient.dio;
  final box = GetStorage();

  var isLoading = false.obs;

  Future<void> openAboutUsLink() async {
    try {
      isLoading(true);
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
        barrierDismissible: false,
      );

      final token = box.read('token');

      if (kDebugMode) {
        print('\n--- API REQUEST (about) ---');
        print('URL: ${ApiConstants.about}');
      }

      final response = await dio.get(
        ApiConstants.about,
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      Get.back(); // close dialog

      if (kDebugMode) {
        print('--- API RESPONSE (about) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      final data = response.data;
      if (data != null && data['status'] == true) {
        final contentData = data['data'];
        final String link = contentData['about_us'] ?? "";

        if (link.isNotEmpty) {
          final Uri url = Uri.parse(link);
          try {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } catch (e) {
            if (kDebugMode) {
              print('LAUNCH ERROR: $e');
            }
            Get.snackbar("Error", "Could not open link");
          }
        } else {
          Get.snackbar("Error", "Link is empty");
        }
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Failed to fetch About Us link",
        );
      }
    } on DioException catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (kDebugMode) {
        print('DioException in fetchAboutUs: ${e.message}');
      }
      Get.snackbar("Error", "Failed to connect to server");
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (kDebugMode) {
        print('Exception in fetchAboutUs: $e');
      }
      Get.snackbar("Error", "An unexpected error occurred");
    } finally {
      isLoading(false);
    }
  }
}
