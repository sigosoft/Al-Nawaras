import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
import '../generated/l10n.dart';

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
            // Open inside the app (Custom Tab / SFSafariViewController) so the
            // user stays in Al-Nawaras instead of switching to another browser.
            await launchUrl(url, mode: LaunchMode.inAppBrowserView);
          } catch (e) {
            if (kDebugMode) {
              print('LAUNCH ERROR: $e');
            }
            Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).couldNotOpenLink);
          }
        } else {
          Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).linkIsEmpty);
        }
      } else {
        Get.snackbar(
          S.of(Get.context!).error,
          data['message'] ?? S.of(Get.context!).failedToFetchAboutUs,
        );
      }
    } on DioException catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (kDebugMode) {
        print('DioException in fetchAboutUs: ${e.message}');
      }
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).errorServer);
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      if (kDebugMode) {
        print('Exception in fetchAboutUs: $e');
      }
      Get.snackbar(S.of(Get.context!).error, S.of(Get.context!).unexpectedError);
    } finally {
      isLoading(false);
    }
  }
}
