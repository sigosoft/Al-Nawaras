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

        if (response != null && _isConfirmedPaidResponse(response)) {
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

  /// Success screen is allowed only when every paid-booking field matches.
  bool _isConfirmedPaidResponse(Map<String, dynamic> response) {
    final topStatus = response['status'];
    final statusOk = topStatus == true ||
        topStatus == 1 ||
        topStatus.toString().toLowerCase() == 'true' ||
        topStatus.toString() == '200';

    final rawData = response['data'];
    if (rawData is! Map) return false;
    final data = Map<String, dynamic>.from(rawData);

    final paymentStatus =
        (data['paymob_payment_status'] ?? '').toString().toLowerCase().trim();
    final bookingState = (data['booking_state'] ?? data['state'] ?? '')
        .toString()
        .toLowerCase()
        .trim();
    final isPaidRaw = data['is_paid'];
    final isPaid = isPaidRaw == true ||
        isPaidRaw == 1 ||
        isPaidRaw.toString() == '1' ||
        isPaidRaw.toString().toLowerCase() == 'true';
    final statusMessage =
        (data['status_message'] ?? '').toString().toLowerCase().trim();
    final txnRef = data['transaction_ref'];
    final hasTxnRef = txnRef != null &&
        txnRef.toString().trim().isNotEmpty &&
        txnRef.toString().toLowerCase() != 'null';

    return statusOk &&
        paymentStatus == 'success' &&
        bookingState == 'booked' &&
        isPaid &&
        statusMessage.contains('payment confirmed') &&
        hasTxnRef;
  }
}
