import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
import '../view/login/login_screen.dart';

class ForgotPasswordController extends GetxController {
  final userOrMobileController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // 6 individual OTP digit controllers and focus nodes
  final List<TextEditingController> otpDigitControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  final Dio dio = BaseClient.dio;

  bool isOtpSent = false;
  bool isLoading = false;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  void toggleNewPasswordVisibility() {
    obscureNewPassword = !obscureNewPassword;
    if (!isClosed) update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    if (!isClosed) update();
  }

  // Returns the concatenated OTP string from all 6 digit fields
  String get otpValue => otpDigitControllers.map((c) => c.text).join();

  void sendOtp() {
    if (userOrMobileController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Email or Mobile Number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPasswordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your New Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPasswordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (confirmPasswordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please confirm your Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _callSendOtpApi();
  }

  Future<void> _callSendOtpApi() async {
    if (isLoading) return;
    isLoading = true;
    if (!isClosed) update();

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST (send_otp) ---');
        print('URL: ${ApiConstants.sendOtp}');
        print('Payload: {"username": "${userOrMobileController.text.trim()}"}');
      }

      final response = await dio.post(
        ApiConstants.sendOtp,
        data: {"username": userOrMobileController.text.trim()},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (send_otp) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data;
        final message = data['message'] ?? 'OTP sent successfully';

        if (data['status'] == true) {
          if (kDebugMode) {
            print('OTP sent: $message');
          }
          isOtpSent = true;
          if (!isClosed) update();
          Get.snackbar(
            'Success',
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          if (kDebugMode) {
            print('Send OTP failed: $message');
          }
          Get.snackbar(
            'Error',
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('API Error (send_otp DioException): ${e.message}');
        if (e.response != null) {
          print('Response Error Data: ${e.response?.data}');
        }
      }
      String errorMessage = 'A network error occurred. Please try again.';
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught (send_otp): $e');
      }
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      if (!isClosed) update();
    }
  }

  void verifyOtp() {
    if (otpValue.length < 6) {
      Get.snackbar(
        'Error',
        'Please enter the complete 6-digit OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _callVerifyOtpApi();
  }

  Future<void> _callVerifyOtpApi() async {
    if (isLoading) return;
    isLoading = true;
    if (!isClosed) update();

    final requestBody = {
      "username": userOrMobileController.text.trim(),
      "otp": otpValue,
      "new_password": newPasswordController.text.trim(),
      "confirm_password": confirmPasswordController.text.trim(),
    };

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST (verify_otp) ---');
        print('URL: ${ApiConstants.verifyOtp}');
        print('Payload: $requestBody');
      }

      final response = await dio.post(
        ApiConstants.verifyOtp,
        data: requestBody,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (verify_otp) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> data = response.data;
        final message = data['message'] ?? 'Password reset successful';

        if (data['status'] == true) {
          if (kDebugMode) {
            print('OTP verified: $message');
          }
          Get.snackbar(
            'Success',
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            Get.offAll(() => const LoginScreen()); // Navigate to Login screen
          });
        } else {
          if (kDebugMode) {
            print('Verify OTP failed: $message');
          }
          Get.snackbar(
            'Error',
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('API Error (verify_otp DioException): ${e.message}');
        if (e.response != null) {
          print('Response Error Data: ${e.response?.data}');
        }
      }
      String errorMessage = 'A network error occurred. Please try again.';
      if (e.response != null &&
          e.response?.data != null &&
          e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught (verify_otp): $e');
      }
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      if (!isClosed) update();
    }
  }

  @override
  void onClose() {
    // Rely on GetX lifecycle for cleanup to avoid "used after disposed" errors
    super.onClose();
  }
}
