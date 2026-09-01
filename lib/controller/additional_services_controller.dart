import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../config/api_constants.dart';
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
          final List<dynamic> servicesData =
              response.data['data']['services'] ?? [];

          services.value = servicesData.map((s) {
            String title = s['service_name'] ?? S.of(Get.context!).service;
            return {
              'id': s['id']?.toString() ?? '',
              'title': title,
              'image': _getServiceImage(title),
              'description':
                  s['description'] ?? S.of(Get.context!).noDescriptionAvailable,
              'price': '${S.of(Get.context!).currency} ${s['price'] ?? '0'}',
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

  Future<void> onBuyNowClick(int index) async {
    final service = services[index];

    // As per user request, call payment/summary with booking_id=1
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (payment/summary) ---');
      debugPrint('URL: ${ApiConstants.paymentSummary}?booking_id=1');

      final response = await dio.get(
        ApiConstants.paymentSummary,
        queryParameters: {'booking_id': 1},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (payment/summary) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final data = response.data['data'];
        final currency = data['currency'] ?? 'AED';

        Get.to(
          () => PaymentView(
            title: service['title'],
            subtitle: S.of(Get.context!).additionalService,
            amount: '$currency ${data['total']}',
            subtotal: '$currency ${data['subtotal']}',
            vat: '$currency ${data['vat']}',
            total: '$currency ${data['total']}',
            details: [
              {
                'label': S.of(Get.context!).serviceName,
                'value': service['title'],
              },
              {
                'label': S.of(Get.context!).membershipPackage,
                'value': data['membership_type']?.toString() ?? 'N/A',
              },
              {
                'label': S.of(Get.context!).vehicleLabel,
                'value': () {
                  final rawVehicle = data['vehicle']?.toString() ?? 'N/A';
                  final match = RegExp(r'\(([^)]+)\)').firstMatch(rawVehicle);
                  if (match != null) {
                    final modelStr = match.group(1)!.trim();
                    if (modelStr.toLowerCase() != 'false' && modelStr.toLowerCase() != 'null') {
                      return modelStr;
                    }
                  }
                  final cleaned = rawVehicle.replaceAll(RegExp(r'\s*\(?False\)?', caseSensitive: false), '').trim();
                  return cleaned.isEmpty ? 'N/A' : cleaned;
                }(),
              },
              {
                'label': S.of(Get.context!).startDateLabel,
                'value': data['start_date']?.toString() ?? 'N/A',
              },
              {
                'label': S.of(Get.context!).endDateLabel,
                'value': data['end_date']?.toString() ?? 'N/A',
              },
              {
                'label': S.of(Get.context!).duration,
                'value': () {
                  final rawDuration = data['duration'];
                  if (rawDuration != null &&
                      rawDuration != false &&
                      rawDuration != 'false' &&
                      rawDuration.toString().isNotEmpty &&
                      rawDuration.toString().toLowerCase() != 'n/a') {
                    return rawDuration.toString();
                  }
                  try {
                    final startStr = data['start_date']?.toString();
                    final endStr = data['end_date']?.toString();
                    if (startStr != null && endStr != null) {
                      final startDt = DateTime.tryParse(startStr);
                      final endDt = DateTime.tryParse(endStr);
                      if (startDt != null && endDt != null) {
                        final diff = endDt.difference(startDt);
                        final days = diff.inDays;
                        final hours = diff.inHours;
                        if (days > 0) {
                          return "$days ${days == 1 ? 'Day' : 'Days'}";
                        } else if (hours > 0) {
                          return "$hours ${hours == 1 ? 'Hour' : 'Hours'}";
                        } else {
                          final minutes = diff.inMinutes;
                          return "$minutes ${minutes == 1 ? 'Minute' : 'Minutes'}";
                        }
                      }
                    }
                  } catch (_) {}
                  return 'N/A';
                }(),
              },
            ],
          ),
        );
      } else {
        _navigateToDefaultPayment(service);
      }
    } catch (e) {
      debugPrint('Error fetching payment summary: $e');
      _navigateToDefaultPayment(service);
    }
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
