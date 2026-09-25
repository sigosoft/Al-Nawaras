import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Result returned when the Paymob WebView closes.
enum PaymobPaymentResult {
  /// Gateway callback clearly indicates a successful payment.
  success,

  /// Gateway callback clearly indicates decline / failure.
  failed,

  /// User closed the WebView or result could not be determined from the URL.
  unknown,
}

class PaymobWebView extends StatefulWidget {
  final String paymentUrl;

  const PaymobWebView({
    super.key,
    required this.paymentUrl,
  });

  @override
  State<PaymobWebView> createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
            _evaluatePaymentUrl(url);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
            _evaluatePaymentUrl(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebResourceError: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_evaluatePaymentUrl(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  /// Returns true when this URL is a final Paymob callback.
  bool _evaluatePaymentUrl(String url) {
    debugPrint('Paymob WebView Navigating to: $url');
    if (_isFinished) return true;

    try {
      final result = _parsePaymentResult(url);
      if (result == null) return false;

      _finish(result);
      return true;
    } catch (e) {
      debugPrint('Error parsing payment URL: $e');
    }
    return false;
  }

  /// `null` = not a final callback URL yet.
  PaymobPaymentResult? _parsePaymentResult(String url) {
    final uri = Uri.parse(url);
    final params = {
      for (final e in uri.queryParameters.entries)
        e.key.toLowerCase(): e.value,
    };

    final successRaw = (params['success'] ??
            params['is_success'] ??
            params['payment_success'] ??
            '')
        .toLowerCase()
        .trim();
    final txnCode = (params['txn_response_code'] ??
            params['data.message'] ??
            params['message'] ??
            params['acq_response_code'] ??
            '')
        .toUpperCase()
        .trim();
    final hasHmac = params.containsKey('hmac');
    final hasTxnId =
        params.containsKey('id') || params.containsKey('transaction_id');
    final path = uri.path.toLowerCase();
    final full = url.toLowerCase();

    final looksLikeCallback = successRaw.isNotEmpty ||
        txnCode.isNotEmpty ||
        hasHmac ||
        path.contains('callback') ||
        path.contains('payment-complete') ||
        path.contains('payment_complete') ||
        path.contains('payment/success') ||
        path.contains('payment_success') ||
        full.contains('success=') ||
        full.contains('txn_response_code=');

    if (!looksLikeCallback) return null;

    if (successRaw == 'true' ||
        successRaw == '1' ||
        successRaw == 'yes' ||
        successRaw == 'approved' ||
        successRaw == 'success') {
      return PaymobPaymentResult.success;
    }

    if (txnCode == 'APPROVED' ||
        txnCode == 'SUCCESS' ||
        txnCode == 'SUCCESSFUL' ||
        txnCode == 'OK' ||
        txnCode == '00') {
      return PaymobPaymentResult.success;
    }

    if (successRaw == 'false' ||
        successRaw == '0' ||
        successRaw == 'no' ||
        successRaw == 'failed' ||
        txnCode == 'DECLINED' ||
        txnCode == 'FAILED' ||
        txnCode == 'ERROR' ||
        txnCode == 'CANCELLED' ||
        txnCode == 'CANCELED') {
      return PaymobPaymentResult.failed;
    }

    // Paymob callback present but flags ambiguous — prefer success so webhook
    // lag does not strand the user on checkout with a false failure.
    if (hasHmac || hasTxnId) {
      return PaymobPaymentResult.success;
    }

    return PaymobPaymentResult.unknown;
  }

  void _finish(PaymobPaymentResult result) {
    if (_isFinished) return;
    _isFinished = true;
    debugPrint('Paymob WebView finishing with $result');
    if (!mounted) return;
    Navigator.of(context).pop(result);
  }

  Future<void> _onClosePressed() async {
    if (_isFinished) return;

    try {
      final currentUrl = await _controller.currentUrl();
      if (currentUrl != null) {
        final parsed = _parsePaymentResult(currentUrl);
        if (parsed != null) {
          _finish(parsed);
          return;
        }
      }
    } catch (e) {
      debugPrint('Error reading WebView URL on close: $e');
    }

    _finish(PaymobPaymentResult.unknown);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Payment'),
        backgroundColor: const Color(0xFFE30613),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: _onClosePressed,
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;
          await _onClosePressed();
        },
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE30613),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
