import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../config/api_constants.dart';
import 'base_client.dart';
import '../view/login/login_screen.dart';

class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final emiratesIdController = TextEditingController();
  final drivingLicenseController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Dio dio = BaseClient.dio;

  bool isTermsAccepted = false;
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isLoading = false;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    if (!isClosed) update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    if (!isClosed) update();
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    if (!isClosed) update();
  }

  void createAccount() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Full Name',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Email Address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!emailController.text.trim().contains('@')) {
      Get.snackbar(
        'Error',
        'Email Address must contain @ symbol',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (mobileController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Mobile Number',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (mobileController.text.trim().length != 10 ||
        !GetUtils.isNumericOnly(mobileController.text.trim())) {
      Get.snackbar(
        'Error',
        'Mobile Number must be exactly 10 digits',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (drivingLicenseController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Driving License',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!isTermsAccepted) {
      Get.snackbar(
        'Error',
        'Please accept the Terms and Conditions',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    _checkUserExists();
  }

  Future<void> _checkUserExists() async {
    if (isLoading) return;
    isLoading = true;
    if (!isClosed) update();

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST (check_user) ---');
        print('URL: ${ApiConstants.checkUser}');
        print('Payload: {"login": "${emailController.text.trim()}"}');
      }

      final response = await dio.post(
        ApiConstants.checkUser,
        data: {"login": emailController.text.trim()},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (check_user) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final Map<String, dynamic> data = response.data;
        final exists = data['data']?['exists'] == true;

        if (exists) {
          // User already exists — stop and notify
          Get.snackbar(
            'Error',
            'User already exists. Please login or use a different email.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          isLoading = false;
          if (!isClosed) update();
          return;
        }

        // User does not exist — proceed with registration
        isLoading = false;
        if (!isClosed) update();
        await _callRegisterApi();
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      isLoading = false;
      if (!isClosed) update();
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught (check_user): $e');
      }
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
      if (!isClosed) update();
    }
  }

  Future<void> _callRegisterApi() async {
    if (isLoading) return;
    isLoading = true;
    if (!isClosed) update();

    final requestBody = {
      "full_name": fullNameController.text.trim(),
      "email": emailController.text.trim(),
      "mobile": mobileController.text.trim(),
      "emirates_id": emiratesIdController.text.trim(),
      "driving_license": drivingLicenseController.text.trim(),
      "password": passwordController.text.trim(),
    };

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST ---');
        print('URL: ${ApiConstants.register}');
        print('Payload: $requestBody');
      }

      final response = await dio.post(
        ApiConstants.register,
        data: requestBody,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final Map<String, dynamic> data = response.data;
        final bool isSuccess = data['status'] == true;
        final String message =
            data['message'] ??
            (isSuccess ? 'Registration successful' : 'Registration failed');

        if (kDebugMode) {
          print('Registration message: $message');
          if (data['data'] != null && data['data']['token'] != null) {
            print('Token: ${data['data']['token']}');
          }
        }

        if (isSuccess) {
          Get.off(() => const LoginScreen());
          Get.snackbar(
            'Success',
            message,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        } else {
          Get.snackbar(
            'Error',
            message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      if (kDebugMode) {
        print('Exception caught: $e');
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

  void goToSignIn() {
    if (kDebugMode) {
      print("Navigate to Sign In");
    }
    Get.off(() => const LoginScreen());
  }

  @override
  void onClose() {
    // Rely on GetX lifecycle for cleanup to avoid "used after disposed" errors
    super.onClose();
  }
}
