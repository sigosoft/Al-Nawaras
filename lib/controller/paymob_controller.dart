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
        Get.snackbar(
          'Error',
          'Failed to generate payment URL. Please try again.',
        );
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

  /// Verifies payment status after WebView closes.
  /// [silent] skips the global loading flag so checkout is not blocked / overlaid.
  Future<bool> verifyPaymentStatus(
    int bookingId, {
    bool silent = false,
    int maxAttempts = 10,
  }) async {
    if (!silent) {
      isLoading = true;
      update();
    }

    try {
      debugPrint('Waiting for webhook to process...');

      for (int i = 0; i < maxAttempts; i++) {
        if (i > 0) {
          await Future.delayed(const Duration(seconds: 2));
        } else {
          await Future.delayed(const Duration(milliseconds: 400));
        }

        final response =
            await _paymobService.getPaymentStatus(bookingId: bookingId);

        if (response != null && _isPaidResponse(response)) {
          return true;
        }
        debugPrint(
          'Payment status not updated yet. Retrying (${i + 1}/$maxAttempts)...',
        );
      }

      return false;
    } catch (e) {
      debugPrint('Paymob verifyPaymentStatus error: $e');
      return false;
    } finally {
      if (!silent) {
        isLoading = false;
        update();
      }
    }
  }

  bool _isPaidResponse(Map<String, dynamic> response) {
    final data = response['data'] is Map
        ? Map<String, dynamic>.from(response['data'] as Map)
        : response;

    final state = (data['state'] ??
            data['paymob_payment_status'] ??
            data['booking_state'] ??
            data['payment_status'] ??
            data['status'] ??
            '')
        .toString()
        .toLowerCase()
        .trim();

    final txn = (data['txn_response_code'] ??
            data['data.message'] ??
            data['message'] ??
            '')
        .toString()
        .toUpperCase()
        .trim();

    final isPaidRaw = data['paid'] ?? data['is_paid'];

    return isPaidRaw == true ||
        isPaidRaw == 1 ||
        isPaidRaw == '1' ||
        isPaidRaw.toString().toLowerCase() == 'true' ||
        isPaidRaw.toString().toLowerCase() == 'paid' ||
        state == 'paid' ||
        state == 'success' ||
        state == 'successful' ||
        state == 'completed' ||
        state == 'approved' ||
        txn == 'APPROVED' ||
        txn == 'SUCCESS' ||
        txn == '00';
  }
}
