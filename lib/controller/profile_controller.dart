import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../config/api_constants.dart';
import '../model/profile_model.dart';
import '../utils/phone_utils.dart';
import 'base_client.dart';
import 'home_controller.dart';
import 'rewards_controller.dart';

class ProfileController extends GetxController {
  final dio_lib.Dio dio = BaseClient.dio;
  final box = GetStorage();

  var isLoading = false.obs;
  var profile = Rxn<ProfileModel>();
  var profileImageBytes = Rxn<Uint8List>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  String base64Image = "";
  var isImageRemoved = false.obs;

  // 🔹 GET TOKEN
  String? get token => box.read('token');

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ============================================================
  // 🔹 1. FETCH PROFILE
  // ============================================================
  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      if (token == null || token!.isEmpty) {
        Get.snackbar(
          "Error", 
          "Token not found", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (kDebugMode) {
        print('\n--- API REQUEST (profile) ---');
        print('URL: ${ApiConstants.profile}');
        print('Headers: {"Authorization": "Bearer $token"}');
      }

      final response = await dio.get(
        ApiConstants.profile, // /api/profile
        options: dio_lib.Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (isClosed) return; // Guard against disposal during async call

      if (kDebugMode) {
        print('--- API RESPONSE (profile) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('--------------------------\n');
      }

      final data = response.data;

      if (data['status'] == true) {
        final profileData = data['data'];
        profile.value = ProfileModel.fromJson(profileData);
        
        // Ensure partner_id is always persisted for subsequent updates
        if (profileData['partner_id'] != null) {
          box.write('partner_id', profileData['partner_id']);
        }
        
        // Optimistically decode base64 image once to prevent UI jank
        final img = profile.value?.profileImage;
        const transparentPlaceholder =
            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==";

        if (img != null &&
            img.isNotEmpty &&
            img != transparentPlaceholder &&
            !img.startsWith('http')) {
          try {
            profileImageBytes.value = base64Decode(img);
          } catch (e) {
            debugPrint('Error decoding profile image: $e');
            profileImageBytes.value = null;
          }
        } else {
          profileImageBytes.value = null;
        }

        // Persist profile image so other controllers (e.g. ChatController) can read it
        box.write('profile_image', img ?? '');

        // Prefill fields
        if (!isClosed) {
          nameController.text = profile.value?.name ?? "";
          emailController.text = profile.value?.email ?? "";
          phoneController.text =
              PhoneUtils.formatForDisplay(profile.value?.mobile);
          isImageRemoved.value = false; // Reset removal flag after fetch
        }
      }
    } on dio_lib.DioException catch (e) {
      BaseClient.handleDioError(e);
    } finally {
      isLoading(false);
    }
  }

  // ============================================================
  // 🔹 RESET CONTROLLERS
  // ============================================================
  void resetControllers() {
    nameController.text = profile.value?.name ?? "";
    emailController.text = profile.value?.email ?? "";
    phoneController.text = PhoneUtils.formatForDisplay(profile.value?.mobile);
    selectedImage.value = null;
    base64Image = "";
    isImageRemoved.value = false;
    base64Image = "";
  }

  // ============================================================
  // 🔹 2. PICK IMAGE
  // ============================================================
  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 40, // Compress to avoid massive base64 payloads
      maxWidth: 800,
    );

    if (picked != null) {
      selectedImage.value = File(picked.path);

      List<int> bytes = await selectedImage.value!.readAsBytes();
      base64Image = base64Encode(bytes);
      isImageRemoved.value = false;
    }
  }

  void removeImage() {
    selectedImage.value = null;
    isImageRemoved.value = true;
    base64Image = "";
    update();
  }

  // ============================================================
  // 🔹 3. UPDATE PROFILE
  // ============================================================
  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
      );
      return;
    }
    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Email cannot be empty",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        "Error",
        "Invalid email format",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final phoneError = PhoneUtils.validationError(phoneController.text);
    if (phoneError != null) {
      Get.snackbar(
        "Error",
        phoneError,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final normalizedPhone =
        PhoneUtils.toInternationalFormat(phoneController.text)!;

    try {
      isLoading(true);

      // Use FormData (multipart/form-data) for better reliability with Base64 payloads.
      // This prevents character corruption (like '+') that can occur with x-www-form-urlencoded.
      final pId = box.read('partner_id');
      if (kDebugMode) {
        print('\n--- API REQUEST (update_profile) ---');
        print('URL: ${ApiConstants.updateprofile}');
        print('Partner ID: $pId');
        print('Name: ${nameController.text}');
        print('Email: ${emailController.text}');
        print('Phone: $normalizedPhone');
        print('Base64 Length: ${base64Image.length}');
        if (base64Image.isNotEmpty) {
          print('Base64 Start: ${base64Image.substring(0, 30)}...');
        }
        print('----------------------------------\n');
      }

      final formData = dio_lib.FormData.fromMap({
        "partner_id": pId,
        "name": nameController.text,
        "email": emailController.text,
        "phone_number": normalizedPhone,
        
        if (base64Image.isNotEmpty) "profile_picture": base64Image,
        if (base64Image.isNotEmpty) "profile_image": base64Image, 
        if (base64Image.isNotEmpty) "image_1920": base64Image, // Common Odoo high-res field
        if (base64Image.isNotEmpty) "image": base64Image,      // Basic Odoo binary field
        
        // Visual Deletion fallback
        if (isImageRemoved.value) "profile_picture": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
        if (isImageRemoved.value) "profile_image": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
        if (isImageRemoved.value) "image_1920": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
        if (isImageRemoved.value) "image": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==",
      });

      final response = await dio.post(
        ApiConstants.updateprofile,
        data: formData,
        options: dio_lib.Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      if (isClosed) return; // Guard against disposal during async call

      if (kDebugMode) {
        print('--- API RESPONSE (update_profile) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('-----------------------------------\n');
      }

      final data = response.data;

      if (data['status'] == true) {
        Get.snackbar(
          "Success",
          data['message'] ?? "Update successful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );

        await fetchProfile(); // refresh data
        
        if (isClosed) return; // Guard check after another await
        
        // Reset local selection so the UI doesn't keep showing the picked file
        selectedImage.value = null;
        base64Image = "";
        // Directly sync fresh profile data to HomeController to avoid redundant network calls and "blinking"
        if (Get.isRegistered<HomeController>()) {
          final homeCtrl = Get.find<HomeController>();
          homeCtrl.profilePicture = profile.value?.profileImage;
          homeCtrl.userName = profile.value?.name ?? homeCtrl.userName;
          homeCtrl.update();
        }

        if (Get.isRegistered<RewardsController>()) {
          Get.find<RewardsController>().fetchRewardsData();
          Get.find<RewardsController>().fetchProfileData();
        }

        Future.delayed(const Duration(seconds: 1), () {
          Get.back();
        });
      } else {
        Get.snackbar(
          "Error",
          data['message'] ?? "Update failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
        );
      }
    } on dio_lib.DioException catch (e) {
      BaseClient.handleDioError(e);
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
