import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../generated/l10n.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
import '../view/home/main_shell.dart';

class RegisterVehicleController extends GetxController {
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController chassisController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? vehiclePhoto;
  XFile? registrationDoc;

  String selectedVehicleType = '';
  bool isLoading = false;
  bool isLoadingTypes = false;
  List<Map<String, dynamic>> vehicleTypes = [];

  @override
  void onInit() {
    super.onInit();
    _loadDraft();
    fetchVehicleTypes();
  }

  void _loadDraft() {
    final storage = GetStorage();
    final draft = storage.read('vehicle_draft');
    if (draft != null) {
      licenseController.text = draft['license_number'] ?? '';
      makeController.text = draft['make'] ?? '';
      modelController.text = draft['model'] ?? '';
      chassisController.text = draft['chassis_no'] ?? '';
      yearController.text = draft['year'] ?? '';
      colorController.text = draft['color'] ?? '';
      lengthController.text = draft['length'] ?? '';
      widthController.text = draft['width'] ?? '';
      heightController.text = draft['height'] ?? '';
      commentsController.text = draft['comments'] ?? '';
      selectedVehicleType = draft['vehicle_type'] ?? '';
      update();
    }
  }

  Future<void> fetchVehicleTypes() async {
    isLoadingTypes = true;
    update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (vehicle_types) ---');
      debugPrint('URL: ${ApiConstants.vehicleTypes}');

      final response = await dio.get(
        ApiConstants.vehicleTypes,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (vehicle_types) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List<dynamic> typesData = response.data['data'] ?? [];
        vehicleTypes = typesData.map((e) => e as Map<String, dynamic>).toList();

        if (vehicleTypes.isNotEmpty && selectedVehicleType.isEmpty) {
          selectedVehicleType = vehicleTypes.first['name'] ?? '';
        }
      }
    } catch (e) {
      debugPrint('Error fetching vehicle types: $e');
    } finally {
      isLoadingTypes = false;
      update();
    }
  }

  String getVehicleImage(String typeName) {
    final lower = typeName.toLowerCase();
    if (lower.contains('caravan')) {
      return 'lib/assets/images/caravan.png';
    } else if (lower.contains('jet ski') || lower.contains('jetski')) {
      return 'lib/assets/images/jet ski.png';
    } else if (lower.contains('truck')) {
      return 'lib/assets/images/food truck.png';
    } else if (lower.contains('boat')) {
      return 'lib/assets/images/boat.png';
    } else if (lower.contains('trailer')) {
      return 'lib/assets/images/trailer.png';
    } else if (lower.contains('trolly')) {
      return 'lib/assets/images/trolly.png';
    }
    return 'lib/assets/images/caravan.png'; // Default fallback
  }

  void setVehicleType(String type) {
    selectedVehicleType = type;
    update();
  }

  void onSkipClick() {
    Get.back();
  }

  Future<void> onRegisterClick() async {
    if (isLoading) return;

    final license = licenseController.text.trim();
    final typeId = _getVehicleTypeId(selectedVehicleType);
    final chassis = chassisController.text.trim();
    final model = modelController.text.trim();
    final year = yearController.text.trim();
    final color = colorController.text.trim();
    final make = makeController.text.trim();

    if (license.isEmpty) {
      Get.snackbar(
        S.of(Get.context!).error,
        S.of(Get.context!).pleaseEnterPlateNumber,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading = true;
    update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final Map<String, dynamic> requestData = {
        "license_number": license,
        "vehicle_type_id": typeId,
        "chassis_no": chassis,
        "model": model,
        "year": year,
        "color": color,
        // Additional fields if needed by backend (not in user example but in UI)
        "make": make,
        "length": lengthController.text,
        "width": widthController.text,
        "height": heightController.text,
        "comments": commentsController.text,
      };

      debugPrint('\n--- API REQUEST (register_vehicle) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Method: POST');
      debugPrint('Headers: {"Authorization": "Bearer $token"}');
      debugPrint('Body: $requestData');

      final response = await dio.post(
        ApiConstants.vehicles,
        data: requestData,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      debugPrint('--- API RESPONSE (register_vehicle) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      final body = response.data;
      final createdId = (body is Map && body['data'] is Map)
          ? body['data']['id']
          : null;
      // Success = status true, or (as seen earlier from this API) a created
      // vehicle id even when status is false. status:false with no id is a
      // real failure and must not be reported as success.
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          body is Map &&
          (body['status'] == true || createdId != null)) {
        storage.remove('vehicle_draft'); // Clear draft on success
        Get.snackbar(
          S.of(Get.context!).success,
          response.data['message'] ?? S.of(Get.context!).vehicleRegisteredSuccessfully,
          backgroundColor: const Color(0xFF2ECC71), // Green
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
          borderRadius: 10,
        );
        Get.offAll(() => const MainShell());
      } else {
        Get.snackbar(
          S.of(Get.context!).error,
          response.data['message'] ?? S.of(Get.context!).registrationFailed,
          backgroundColor: const Color(0xFFE30613), // Red
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint('Error registering vehicle: $e');
      Get.snackbar(
        S.of(Get.context!).error,
        S.of(Get.context!).errorDuringRegistration,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  void onRegisterLaterClick() {
    final storage = GetStorage();
    final draft = {
      'license_number': licenseController.text,
      'make': makeController.text,
      'model': modelController.text,
      'chassis_no': chassisController.text,
      'year': yearController.text,
      'color': colorController.text,
      'length': lengthController.text,
      'width': widthController.text,
      'height': heightController.text,
      'comments': commentsController.text,
      'vehicle_type': selectedVehicleType,
    };
    storage.write('vehicle_draft', draft);

    Get.snackbar(
      S.of(Get.context!).draftSaved,
      S.of(Get.context!).vehicleSavedAsDraft,
      backgroundColor: const Color(0xFF2ECC71),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    Future.delayed(const Duration(seconds: 1), () => Get.back());
  }

  int _getVehicleTypeId(String type) {
    // Dynamic lookup from fetched API data
    final match = vehicleTypes.firstWhere(
      (vt) => vt['name'] == type,
      orElse: () => {},
    );
    if (match.isNotEmpty && match.containsKey('id')) {
      return match['id'] as int;
    }

    // Fallback if not found
    final lower = type.toLowerCase();
    if (lower.contains('jetski') || lower.contains('jet ski')) return 9;
    if (lower.contains('truck')) return 10;
    if (lower.contains('boat')) return 12;
    if (lower.contains('caravan')) return 14;
    return 14;
  }

  Future<void> onUploadPhotoClick() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        vehiclePhoto = image;
        update();
      }
    } catch (e) {
      debugPrint('Error picking vehicle photo: $e');
    }
  }

  Future<void> onUploadDocClick() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        registrationDoc = image;
        update();
      }
    } catch (e) {
      debugPrint('Error picking registration doc: $e');
    }
  }

  @override
  void onClose() {
    licenseController.dispose();
    makeController.dispose();
    modelController.dispose();
    chassisController.dispose();
    yearController.dispose();
    colorController.dispose();
    lengthController.dispose();
    widthController.dispose();
    heightController.dispose();
    commentsController.dispose();
    super.onClose();
  }
}
