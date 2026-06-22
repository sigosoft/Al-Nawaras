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
      debugPrint('Waiting for webhook to process...');
      
      // Poll up to 5 times (every 2 seconds) to give the webhook time to arrive
      for (int i = 0; i < 5; i++) {
        await Future.delayed(const Duration(seconds: 2));

        final response = await _paymobService.getPaymentStatus(bookingId: bookingId);
        
        if (response != null) {
          final data = response['data'] ?? response;
          
          // The backend returns keys like 'is_paid', 'paymob_payment_status', or 'booking_state'
          final state = data['state']?.toString().toLowerCase() ?? 
                        data['paymob_payment_status']?.toString().toLowerCase() ?? 
                        data['booking_state']?.toString().toLowerCase();
                        
          final isPaid = data['paid'] == true || 
                         data['is_paid'] == true || 
                         state == 'paid' || 
                         state == 'success';
          
          if (isPaid) {
            return true; // Webhook processed successfully!
          }
        }
        debugPrint('Payment status not updated yet. Retrying (${i + 1}/5)...');
      }
      
      // If we reach here, we polled 5 times and the backend still hasn't confirmed the payment.
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
