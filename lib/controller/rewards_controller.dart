import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import 'base_client.dart';

class RewardsController extends GetxController {
  bool isLoading = false;
  Map<String, dynamic>? rewardsData;
  Map<String, dynamic>? profileData;

  @override
  void onInit() {
    super.onInit();
    fetchRewardsData();
    fetchProfileData();
  }

  Future<void> fetchRewardsData() async {
    isLoading = true;
    update();

    try {
      final storage = GetStorage();
      final token = storage.read('token');

      if (token == null || token.toString().isEmpty || token == "null") {
        debugPrint('No token found, skipping rewards fetch.');
        isLoading = false;
        update();
        return;
      }

      final dio = BaseClient.dio;
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (rewards) ---');
      debugPrint('URL: ${ApiConstants.rewards}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.rewards,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (rewards) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          rewardsData = response.data['data'];
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching rewards: $e');
    } catch (e) {
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> fetchProfileData() async {
    try {
      final storage = GetStorage();
      final token = storage.read('token');

      if (token == null || token.toString().isEmpty || token == "null") {
        return;
      }

      final dio = BaseClient.dio;
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (profile_for_rewards) ---');
      debugPrint('URL: ${ApiConstants.profile}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.profile,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (profile_for_rewards) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          profileData = response.data['data'];
          update();
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching profile for rewards: $e');
    } catch (e) {}
  }

  /// Badge artwork for the tier; empty when there is none (only Silver has
  /// an image), so the card shows a neutral icon instead.
  String getMemberImage(String? type) {
    if (type != null && type.toLowerCase().contains('silver')) {
      return 'lib/assets/images/Silver member.png';
    }
    return '';
  }
}
