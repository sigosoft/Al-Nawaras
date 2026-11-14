import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
import '../utils/amount_utils.dart';
import '../generated/l10n.dart';

class AdditionalServicesController extends GetxController {
  var services = <Map<String, dynamic>>[].obs;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
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

      debugPrint('\n--- API REQUEST (services) ---');
      debugPrint('URL: ${ApiConstants.services}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.services,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (services) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          // Docs: data is a list. Older responses wrapped it in
          // data.services, and an empty result comes back as {}.
          final rawData = response.data['data'];
          final List<dynamic> servicesData = rawData is List
              ? rawData
              : (rawData is Map && rawData['services'] is List
                    ? rawData['services'] as List
                    : const []);

          services.value = servicesData.map((s) {
            String title = s['service_name'] ?? S.of(Get.context!).service;
            return {
              'id': s['id']?.toString() ?? '',
              'title': title,
              'image': _getServiceImage(title),
              'description':
                  s['description'] ?? S.of(Get.context!).noDescriptionAvailable,
              'price': '${S.of(Get.context!).currency} ${AmountUtils.format(s['price'])}',
            };
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching services: $e');
    } finally {
      isLoading = false;
      update();
    }
  }

  String _getServiceImage(String title) {
    String lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('battery')) return 'lib/assets/images/battery.png';
    if (lowerTitle.contains('oil')) return 'lib/assets/images/oil charge.png';
    if (lowerTitle.contains('tire')) return 'lib/assets/images/tire change.png';
    if (lowerTitle.contains('cleaning')) {
      return 'lib/assets/images/cleaning.png';
    }
    if (lowerTitle.contains('towing')) return 'lib/assets/images/Trolly.png';
    if (lowerTitle.contains('vehicle pickup')) {
      return 'lib/assets/images/vehicle pickup.png';
    }
    if (lowerTitle.contains('customer pickup')) {
      return 'lib/assets/images/customer pickup.png';
    }
    return 'lib/assets/images/battery.png'; // Default
  }

  void onBuyNowClick(int index) {
    // There is no standalone service-purchase endpoint yet, so show the
    // service's own price. (Previously this loaded payment/summary for
    // booking_id=1, which displayed another customer's booking.)
    _navigateToDefaultPayment(services[index]);
  }

  void _navigateToDefaultPayment(Map<String, dynamic> service) {
    Get.to(
      () => PaymentView(
        title: service['title'],
        subtitle: S.of(Get.context!).additionalService,
        amount: service['price'],
        subtotal: service['price']!,
        vat: '${S.of(Get.context!).currency} 0.00',
        details: [
          {'label': S.of(Get.context!).serviceName, 'value': service['title']!},
        ],
      ),
    );
  }
}
