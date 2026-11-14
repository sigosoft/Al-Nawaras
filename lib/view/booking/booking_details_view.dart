import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class BookingDetailsView extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        title: Text(
          S.of(context).bookingDetails,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE30613),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).referenceLabel.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    booking['reference'] ?? S.of(context).notAvailableShort,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        context,
                        Icons.category_outlined,
                        S.of(context).membershipPackage,
                        booking['title'] ?? S.of(context).notAvailableShort,
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.directions_car_outlined,
                        S.of(context).vehicle,
                        booking['subtitle']?.toString().split(' • ').first ??
                            S.of(context).notAvailableShort,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.info_outline,
                        S.of(context).vehicleType,
                        booking['vehicle_type'] ?? S.of(context).notAvailableShort,
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.location_on_outlined,
                        S.of(context).locationLabel,
                        booking['location'] ?? S.of(context).notAvailableShort,
                      ),
                      if ((booking['slot'] ?? '').toString().isNotEmpty) ...[
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          context,
                          Icons.local_parking_outlined,
                          S.of(context).slotNumberLabel,
                          booking['slot'].toString(),
                        ),
                      ],
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.check_circle_outline,
                        S.of(context).status,
                        booking['status'] ?? S.of(context).notAvailableShort,
                        valueColor: booking['isActive'] == true
                            ? Colors.green.shade700
                            : Colors.orange.shade700,
                      ),
                      const Divider(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDetailRow(
                              context,
                              Icons.login,
                              S.of(context).startDateLabel,
                              booking['startDate'] ?? S.of(context).notAvailableShort,
                            ),
                          ),
                          Expanded(
                            child: _buildDetailRow(
                              context,
                              Icons.logout,
                              S.of(context).endDateLabel,
                              booking['endDate'] ?? S.of(context).notAvailableShort,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      _buildDetailRow(
                        context,
                        Icons.account_balance_wallet_outlined,
                        S.of(context).amountExclVat,
                        booking['amount'] ?? S.of(context).notAvailableShort,
                      ),
                      if (booking['extra_amount'] != null &&
                          (booking['extra_amount'] as num) > 0) ...[
                        const Divider(height: 32),
                        _buildDetailRow(
                          context,
                          Icons.add_circle_outline,
                          S.of(context).extraAmount,
                          'AED ${booking['extra_amount']}',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE30613).withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFE30613), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
