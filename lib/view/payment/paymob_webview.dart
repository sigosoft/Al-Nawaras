import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String paymentUrl;
  final void Function(bool) onPaymentComplete;

  const PaymobWebView({
    super.key,
    required this.paymentUrl,
    required this.onPaymentComplete,
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
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebResourceError: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_checkUrl(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  bool _checkUrl(String url) {
    debugPrint('Paymob WebView Navigating to: $url');
    
    // The actual payment verification is handled by the backend webhook/status API.
    // We only need to detect the final Paymob callback redirect to close the WebView.
    // Paymob appends query parameters like 'success', 'id', and 'hmac' to the callback URL.
    try {
      final uri = Uri.parse(url);
      final hasPaymobParams = uri.queryParameters.containsKey('success') &&
          uri.queryParameters.containsKey('id') &&
          (uri.queryParameters.containsKey('hmac') || uri.queryParameters.containsKey('txn_response_code'));

      if (hasPaymobParams) {
        if (!_isFinished) {
          _isFinished = true;
          debugPrint('Paymob final callback detected, closing WebView...');
          final isSuccess = uri.queryParameters['success'] == 'true';
          widget.onPaymentComplete(isSuccess);
        }
        return true;
      }
    } catch (e) {
      debugPrint('Error parsing URL: $e');
    }
    
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secure Payment'),
        backgroundColor: const Color(0xFFE30613),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            if (!_isFinished) {
              _isFinished = true;
              widget.onPaymentComplete(false);
            }
          },
        ),
      ),
      body: Stack(
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
    );
  }
}
