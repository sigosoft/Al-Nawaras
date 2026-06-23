import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:get/get.dart';
import '../home/home_screen.dart';

class PaymentSuccessView extends StatefulWidget {
  final int? bookingId;
  final String? title;
  final String? subtitle;
  final String? total;
  final List<Map<String, String>>? details;

  const PaymentSuccessView({
    super.key,
    this.bookingId,
    this.title,
    this.subtitle,
    this.total,
    this.details,
  });

  @override
  State<PaymentSuccessView> createState() => _PaymentSuccessViewState();
}

class _PaymentSuccessViewState extends State<PaymentSuccessView> {
  @override
  void initState() {
    super.initState();
    // Show snackbar after the frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).bookingSuccessful,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Color(0xFF4CAF50),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _navigateToHome() {
    Get.offAll(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    // Media query for screen proportions
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.05;

    String displayTitle = widget.title ?? S.of(context).monthlyMembership;
    final isParkingFlow =
        widget.details?.any(
          (d) => d['label']?.toLowerCase().contains('parking') ?? false,
        ) ??
        false;

    if (widget.details != null) {
      final membershipDetail = widget.details!.firstWhere(
        (d) => d['label']?.toLowerCase().contains('membership') ?? false,
        orElse: () => {},
      );
      if (membershipDetail.isNotEmpty) {
        final val = membershipDetail['value'] ?? '';
        if (val.isNotEmpty && val.toLowerCase() != 'n/a') {
          displayTitle = val.endsWith('Plan') || val.endsWith('Membership')
              ? val
              : "$val Membership";
        }
      }
    }
    if (displayTitle.toLowerCase() == 'booking payment') {
      displayTitle = S.of(context).monthlyMembership;
    }

    String displaySubtitle =
        widget.subtitle ?? S.of(context).shadedParkingDetail;
    if (isParkingFlow) {
      if (displaySubtitle.toLowerCase().endsWith(' parking')) {
        displaySubtitle = displaySubtitle
            .substring(0, displaySubtitle.length - 8)
            .trim();
      }
      if (!displaySubtitle.toLowerCase().contains('parking')) {
        displaySubtitle = "$displaySubtitle Parking";
      }
    }

    final displayTotal = widget.total ?? '${S.of(context).currency} 0.00';
    final displayDetails = (widget.details != null)
        ? widget.details!.where((d) {
            final label = (d['label'] ?? '')
                .toString()
                .toLowerCase()
                .replaceAll(' ', '');
            return label != 'membershiptype' && label != 'parkingtype';
          }).toList()
        : [
            {'label': S.of(context).vehicle, 'value': 'N/A'},
            {'label': S.of(context).duration, 'value': 'N/A'},
            {'label': S.of(context).startDateLabel, 'value': 'N/A'},
            {'label': S.of(context).endDateLabel, 'value': 'N/A'},
          ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 28),
            onPressed: _navigateToHome,
          ),
          SizedBox(width: padding),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                children: [
                  SizedBox(height: height * 0.02),
                  // Success Icon
                  Container(
                    height: height * 0.12,
                    width: height * 0.12,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        height: height * 0.08,
                        width: height * 0.08,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    S.of(context).paymentSuccessful,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    S.of(context).thankYou,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Text(
                    S.of(context).paymentProcessedSuccessfully,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  // Summary Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                displaySubtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 30, thickness: 1),
                        ...displayDetails.map(
                          (d) => _buildSummaryItem(
                            context,
                            d['label'] ?? '',
                            d['value'] ?? '',
                          ),
                        ),
                        const Divider(height: 30, thickness: 1),
                        _buildSummaryItem(
                          context,
                          S.of(context).totalLabel,
                          displayTotal,
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Text(
                    S.of(context).confirmationEmailSent,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _navigateToHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE30613),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        S.of(context).close,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    S.of(context).needAssistanceCall,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: height * 0.04),
                ],
              ),
            ),
          ),
          // const DraggableHelpButton(),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value, {
    bool isHeader = false,
    bool isBold = false,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.35,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isHeader ? 16 : 14,
                fontWeight: isHeader || isBold
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: isHeader ? Colors.black : Colors.grey[600],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.4,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: isHeader ? 16 : 14,
                fontWeight: isHeader || isBold
                    ? FontWeight.bold
                    : FontWeight.w600,
                color: isHeader ? const Color(0xFFE30613) : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
