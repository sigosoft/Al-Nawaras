import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../generated/l10n.dart';
import 'base_client.dart';
import '../view/payment/payment_view.dart';
import '../config/api_constants.dart';
import '../utils/amount_utils.dart';

class MembershipPlansController extends GetxController {
  List<Map<String, dynamic>> plans = [];
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchMembershipPlans();
  }

  Future<void> fetchMembershipPlans() async {
    isLoading = true;
    update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (memberships) ---');
      debugPrint('URL: ${ApiConstants.memberships}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.memberships,
        queryParameters: {'limit': 50, 'offset': 0},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (memberships) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List<dynamic> memberships = response.data['data']['memberships'];
          plans = memberships.map((m) {
            String featuresStr = m['list_of_features']?.toString() ?? "";
            List<String> features = featuresStr.isNotEmpty
                ? featuresStr.split(',').map((f) => f.trim()).toList()
                : [S.of(Get.context!).basicMembershipBenefits];

            return {
              'id': m['id'],
              'title': m['plan_type'] ?? S.of(Get.context!).standardPlan,
              // Kept as "AED": the payment screen parses this string back.
              'price': 'AED ${AmountUtils.format(m['plan_price'])}',
              'unit': m['duration'] ?? S.of(Get.context!).month,
              'period': m['duration']?.toString().toLowerCase() ?? 'month',
              'features': features,
              'description': m['short_description'] ?? "",
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching memberships: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  void onSelectPlan(int index) {
    // There is no membership-purchase endpoint yet, so show the plan's own
    // price and details. (Previously this loaded payment/summary for
    // booking_id=1, which displayed another customer's booking.)
    _navigateToDefaultPayment(plans[index]);
  }

  void _navigateToDefaultPayment(Map<String, dynamic> plan) {
    Get.to(() => PaymentView(
          title: plan['title'],
          subtitle: S.of(Get.context!).membershipSubscription,
          amount: plan['price'],
          subtotal: plan['price'],
          vat: 'AED 0.00',
          details: [
            {'label': S.of(Get.context!).planType, 'value': plan['title']},
            {'label': S.of(Get.context!).validity, 'value': plan['unit'].replaceAll('per ', '')},
          ],
        ));
  }
}
