import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../view/payment/payment_view.dart';
import '../config/api_constants.dart';

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
                : ["Basic Membership Benefits"];

            return {
              'id': m['id'],
              'title': m['plan_type'] ?? 'Standard Plan',
              'price': 'AED ${m['plan_price']}',
              'unit': m['duration'] ?? 'month',
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

  Future<void> onSelectPlan(int index) async {
    final plan = plans[index];
    
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

      if (response.statusCode == 200 && response.data != null && response.data['status'] == true) {
        final data = response.data['data'];
        final currency = data['currency'] ?? 'AED';
        
        Get.to(() => PaymentView(
              title: plan['title'],
              subtitle: '${data['membership_type'] ?? 'Membership'} Subscription',
              amount: '$currency ${data['total']}',
              subtotal: '$currency ${data['subtotal']}',
              vat: '$currency ${data['vat']}',
              total: '$currency ${data['total']}',
              details: [
                {'label': 'Membership Type', 'value': data['membership_type']?.toString() ?? 'N/A'},
                {'label': 'Parking Type', 'value': data['parking_type']?.toString() ?? 'N/A'},
                {
                  'label': 'Vehicle',
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
                {'label': 'Start Date', 'value': data['start_date']?.toString() ?? 'N/A'},
                {'label': 'End Date', 'value': data['end_date']?.toString() ?? 'N/A'},
                {
                  'label': 'Duration',
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
            ));
      } else {
        // Fallback or error handling
        _navigateToDefaultPayment(plan);
      }
    } catch (e) {
      debugPrint('Error fetching payment summary: $e');
      _navigateToDefaultPayment(plan);
    }
  }

  void _navigateToDefaultPayment(Map<String, dynamic> plan) {
    Get.to(() => PaymentView(
          title: plan['title'],
          subtitle: 'Membership Subscription',
          amount: plan['price'],
          subtotal: plan['price'],
          vat: 'AED 0.00',
          details: [
            {'label': 'Plan Type', 'value': plan['title']},
            {'label': 'Validity', 'value': plan['unit'].replaceAll('per ', '')},
          ],
        ));
  }
}
