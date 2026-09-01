import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../config/api_constants.dart';
import '../view/register/register_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/forgot_password_view.dart';

class LoginController extends GetxController {
  final emailOrMobileController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final box = GetStorage();
  final Dio dio = BaseClient.dio;

  bool isRememberMe = false;
  bool isLoading = false;
  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    if (!isClosed) update();
  }

  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials();
  }

  void _loadRememberedCredentials() {
    final savedLogin = box.read('login_email');
    final savedPassword = box.read('login_password');
    final savedRememberMe = box.read('remember_me');

    if (savedRememberMe == true) {
      isRememberMe = true;
      if (savedLogin != null) emailOrMobileController.text = savedLogin;
      if (savedPassword != null) passwordController.text = savedPassword;
    }
  }

  void toggleRememberMe() {
    isRememberMe = !isRememberMe;
    if (!isClosed) update();
  }

  Future<void> signIn() async {
    final login = emailOrMobileController.text.trim();
    final password = passwordController.text.trim();

    // Validation
    if (login.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Username or Mobile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Email or Mobile Validation
    if (login.contains('@')) {
      // Email must contain @ (already true if contains('@'))
    } else {
      // Mobile must be exactly 10 digits
      if (login.length != 10 || !GetUtils.isNumericOnly(login)) {
        Get.snackbar(
          'Error',
          'Mobile number must be exactly 10 digits or enter a valid Email',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    if (password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your Password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (isLoading) return;
    isLoading = true;
    if (!isClosed) update();

    try {
      if (kDebugMode) {
        print('\n--- API REQUEST (login) ---');
        print('URL: ${ApiConstants.login}');
        print('Payload: {"login": "$login", "password": "$password"}');
      }

      final response = await dio.post(
        ApiConstants.login,
        data: {"login": login, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (login) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        print('--------------------\n');
      }

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        final Map<String, dynamic> data = response.data;
        if (data['status'] == true) {
          if (kDebugMode) {
            print('Token Extracted & Saved: ${data['data']['token']}');
            print('Login successful: ${data['message']}');
          }
          final loginData = data['data'];

          // Save login details for further use
          box.write('token', loginData['token']);
          box.write('partner_id', loginData['partner_id']);
          box.write('name', loginData['name']);
          box.write('email', loginData['email']);
          box.write('mobile', loginData['mobile']);

          // Remember Me
          if (isRememberMe) {
            box.write('remember_me', true);
            box.write('login_email', login);
            box.write('login_password', password);
          } else {
            box.remove('remember_me');
            box.remove('login_email');
            box.remove('login_password');
          }

          final String loginMessage = data['message'] ?? 'Login successful';

          Get.offAll(() => const HomeScreen());
          Get.snackbar(
            'Success',
            loginMessage,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
        } else {
          final message =
              data['message'] ?? 'Login failed. Please check your credentials.';
          if (kDebugMode) {
            print('Login failure from API: $message');
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

  void forgotPassword() {
    Get.to(() => const ForgotPasswordView());
  }

  // Google Login

  Future<void> googleLogin() async {
    try {
      isLoading = true;
      if (!isClosed) update();

      // 🔹 Step 1: Google Sign-In
      final user = await _googleSignIn.signIn();

      if (user == null) {
        isLoading = false;
        if (!isClosed) update();
        return; // user cancelled login
      }

      // 🔹 Step 2: Get Tokens
      final auth = await user.authentication;

      final idToken = auth.idToken;

      if (idToken == null) {
        Get.snackbar(
          "Error",
          "Failed to get Google token",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      print("ID TOKEN: $idToken");

      // 🔹 Step 3: Call API
      final response = await dio.post(
        ApiConstants.socialLogin,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          "provider": "google",
          "auth_token": idToken,
          "email": user.email,
        },
      );

      final data = response.data;

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data["status"] == true) {
        // 🔹 Step 4: Save Token
        box.write("token", data["data"]["token"]);
        box.write("partner_id", data["data"]["partner_id"]);
        box.write("name", data["data"]["name"]);
        box.write("email", data["data"]["email"]);

        final String successMessage = data["message"] ?? "Login successful";

        // 🔹 Step 5: Navigate then show snackbar on destination screen
        Get.offAll(() => const HomeScreen());
        Get.snackbar(
          "Success",
          successMessage,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error",
          data["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      if (!isClosed) update();
    }
  }

  Future<void> signInWithFacebook() async {
    Get.snackbar(
      "Coming Soon",
      "Facebook login will be available in the next update",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
  }

  void signInWithX() {
    if (kDebugMode) {
      print("X Sign In");
    }
  }

  void goToRegister() {
    // Navigate to Register or replace current screen depending on flow
    Get.off(() => const RegisterScreen());
  }

  @override
  void onClose() {
    // Rely on GetX lifecycle for cleanup to avoid "used after disposed" errors
    super.onClose();
  }
}
