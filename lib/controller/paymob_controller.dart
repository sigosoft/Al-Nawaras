import 'package:al_nawaras/controller/paymob_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PaymobController extends GetxController {
  final PaymobService _paymobService = PaymobService();
  
  bool isLoading = false;

  /// Generates the WebView payment URL for a given booking
  Future<String?> generatePaymentUrl({
    required int bookingId,
    required double amount,
    required String currency,
  }) async {
    isLoading = true;
    update();

    try {
      final url = await _paymobService.createPaymentUrl(
        bookingId: bookingId,
        amount: amount,
        currency: currency,
      );
      if (url == null) {
        Get.snackbar('Error', 'Failed to generate payment URL. Please try again.');
      }
      return url;
    } catch (e) {
      debugPrint('Paymob generatePaymentUrl error: $e');
      Get.snackbar('Error', 'An unexpected error occurred.');
      return null;
    } finally {
      isLoading = false;
      update();
    }
  }

  /// Verifies the final payment status after the WebView is closed
  Future<bool> verifyPaymentStatus(int bookingId) async {
    isLoading = true;
    update();

    try {
      // Small delay to allow the backend webhook to be processed
      debugPrint('Waiting for webhook to process...');
      await Future.delayed(const Duration(seconds: 2));

      final response = await _paymobService.getPaymentStatus(bookingId: bookingId);
      
      if (response != null) {
        // Expecting { "status": true, "data": { "state": "paid" } } 
        // OR { "status": "success", "paid": true }
        final data = response['data'] ?? response;
        final state = data['state']?.toString().toLowerCase();
        final isPaid = data['paid'] == true || state == 'paid' || state == 'success';
        
        return isPaid;
      }
      return false;
    } catch (e) {
      debugPrint('Paymob verifyPaymentStatus error: $e');
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }
}
