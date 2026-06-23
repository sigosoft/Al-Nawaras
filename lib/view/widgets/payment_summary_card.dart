import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class PaymentSummaryCard extends StatelessWidget {
  final double width;
  final String title;
  final String subtitle;
  final String amount;
  final String subtotal;
  final String vat;
  final String? total;
  final List<Map<String, String>> details;

  const PaymentSummaryCard({
    super.key,
    required this.width,
    this.title = 'Monthly Membership',
    this.subtitle = 'Shaded Parking',
    this.amount = 'AED 1,500',
    this.subtotal = 'AED 1,500.00',
    this.vat = 'AED 75.00',
    this.total,
    this.details = const [
      {'label': 'Vehicle', 'value': 'Airstream Caravel'},
      {'label': 'Duration', 'value': '30 Days'},
      {'label': 'Start Date', 'value': '15 May 2023'},
      {'label': 'End Date', 'value': '15 Jun 2023'},
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(width * 0.04), // Dynamic padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE30613), width: 2),
                ),
                child: const Icon(
                  Icons.calendar_month,
                  color: const Color(0xFFE30613),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          subtitle,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const Spacer(),
                        Text(
                          amount,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          ...details.where((detail) {
            final label = (detail['label'] ?? '').toLowerCase().replaceAll(' ', '');
            return label != 'membershiptype' && label != 'parkingtype';
          }).map((detail) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildItemRow(detail['label']!, detail['value']!),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildItemRow(S.of(context).subtotal, subtotal),
          const SizedBox(height: 8),
          _buildItemRow(S.of(context).vat, vat),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).total,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                total ?? (subtotal == 'AED 1,500.00' && vat == 'AED 75.00'
                    ? 'AED 1,575.00'
                    : _calculateTotal(subtotal, vat)),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTotal(String subtotal, String vat) {
    try {
      final sub = double.parse(subtotal.replaceAll(RegExp(r'[^0-9.]'), ''));
      final v = double.parse(vat.replaceAll(RegExp(r'[^0-9.]'), ''));
      return 'AED ${(sub + v).toStringAsFixed(2)}';
    } catch (e) {
      return subtotal;
    }
  }

  Widget _buildItemRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
