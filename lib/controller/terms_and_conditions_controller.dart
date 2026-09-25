import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../config/api_constants.dart';

class TermsAndConditionsController extends GetxController {
  final Dio dio = BaseClient.dio;
  final box = GetStorage();

  var isLoading = false.obs;
  var title = 'Terms & Conditions'.obs;
  var contentEn = ''.obs;
  var contentAr = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTermsAndConditions();
  }

  String get localizedContent {
    final lang = Get.locale?.languageCode ??
        Get.deviceLocale?.languageCode ??
        'en';
    final isArabic = lang == 'ar';
    if (isArabic) {
      final ar = contentAr.value.trim();
      if (ar.isNotEmpty) return ar;
    }
    final en = contentEn.value.trim();
    if (en.isNotEmpty) return en;
    return contentAr.value;
  }

  Future<void> fetchTermsAndConditions() async {
    try {
      isLoading(true);
      final token = box.read('token');

      if (kDebugMode) {
        print('\n--- API REQUEST (terms_and_conditions) ---');
        print('URL: ${ApiConstants.termsAndConditions}');
      }

      final response = await dio.get(
        ApiConstants.termsAndConditions,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (terms_and_conditions) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      final data = response.data;
      final status = data?['status'];
      final ok = status == 200 ||
          status == true ||
          status == '200' ||
          response.statusCode == 200;

      if (data != null && ok) {
        final termsData = data['data'] ?? {};
        title.value =
            termsData['title']?.toString() ?? 'Terms & Conditions';
        contentEn.value = termsData['content']?.toString() ?? '';
        contentAr.value = termsData['content_ar']?.toString() ?? '';
      } else {
        Get.snackbar(
          'Error',
          data?['message'] ?? 'Failed to fetch Terms and Conditions',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFE30613),
          colorText: const Color(0xFFFFFFFF),
        );
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      if (kDebugMode) {
        print('Exception in fetchTermsAndConditions: $e');
      }
    } finally {
      isLoading(false);
    }
  }
}
