import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import '../controller/base_client.dart';

class PaymobService {
  final Dio _dio = BaseClient.dio;

  /// Step 1: Create Payment URL via Backend
  /// This triggers the backend to handle Paymob handshake and return a WebView URL
  Future<String?> createPaymentUrl({
    required int bookingId,
    required double amount,
    required String currency,
  }) async {
    try {
      final storage = GetStorage();
      final token = storage.read('token');
      
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('Creating Paymob payment URL for booking: $bookingId, Amount: $amount $currency');
      
      final response = await _dio.post(
        ApiConstants.paymobCreatePayment,
        data: {
          'booking_id': bookingId,
          'amount': amount,
          'currency': currency,
        },
        options: Options(headers: headers),
      );

      debugPrint('Paymob Create Payment Response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Expecting { "status": true, "data": { "payment_url": "..." } } 
        // OR { "status": "success", "payment_url": "..." }
        final data = response.data;
        if (data['status'] == true || data['status'] == 'success') {
          final realData = data['data'];
          if (realData != null && realData is Map && realData.containsKey('payment_url')) {
            return realData['payment_url'];
          }
          return data['payment_url'];
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Paymob Create Payment Error: $e');
      if (e.response != null) {
        debugPrint('Response: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Paymob Create Payment Error: $e');
      return null;
    }
  }

  /// Step 2: Verify Payment Status via Backend
  /// Backend checks its local database (updated by webhook) to confirm status
  Future<Map<String, dynamic>?> getPaymentStatus({
    required int bookingId,
  }) async {
    try {
      final storage = GetStorage();
      final token = storage.read('token');
      
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('Checking Paymob payment status for booking: $bookingId');
      
      final response = await _dio.get(
        ApiConstants.paymobPaymentStatus,
        queryParameters: {'booking_id': bookingId},
        options: Options(headers: headers),
      );

      debugPrint('Paymob Status Response: ${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('Paymob Status Check Error: $e');
      return null;
    } catch (e) {
      debugPrint('Paymob Status Check Error: $e');
      return null;
    }
  }
}
