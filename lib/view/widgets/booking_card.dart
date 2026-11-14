import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class BookingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final String startDate;
  final String endDate;
  final String amount;
  final bool isActive;
  final List<Widget> actions;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.amount,
    required this.isActive,
    required this.actions,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header Row
            Row(
              children: [
                _buildIcon(width),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          _buildStatusBadge(),
                        ],
                      ),
                      SizedBox(height: width * 0.01),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
            SizedBox(height: width * 0.04),
            // Details Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _DetailItem(
                      label: S.of(context).startDateLabel, value: startDate),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  flex: 4,
                  child: _DetailItem(
                      label: S.of(context).endDateLabel, value: endDate),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  flex: 3,
                  child: _DetailItem(
                      label: S.of(context).amountExclVat, value: amount),
                ),
              ],
            ),
            SizedBox(height: width * 0.04),
            // Actions Row
            Row(children: actions),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(double width) {
    if (isActive) {
      return Container(
        padding: EdgeInsets.all(width * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE30613), width: 2),
        ),
        child: Icon(
          Icons.calendar_month,
          color: const Color(0xFFE30613),
          size: width * 0.06,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(width * 0.025),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.calendar_month,
          color: Colors.grey[600],
          size: width * 0.06,
        ),
      );
    }
  }

  Widget _buildStatusBadge() {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: Colors.green[700],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      );
    }
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const _DetailItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
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
        SizedBox(height: width * 0.015),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
