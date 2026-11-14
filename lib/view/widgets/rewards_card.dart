import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class RewardsCard extends StatelessWidget {
  final double width;
  final String points;
  final String membershipType;
  final String memberSince;
  final double progress;
  final String membershipImage;

  const RewardsCard({
    super.key,
    required this.width,
    required this.points,
    required this.membershipType,
    required this.memberSince,
    required this.progress,
    required this.membershipImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Only the Silver tier has artwork; other tiers get a neutral
              // badge instead of a misleading "SILVER" coin.
              membershipImage.isNotEmpty
                  ? Image.asset(
                      membershipImage,
                      width: width * 0.22,
                      height: width * 0.22,
                    )
                  : Icon(
                      Icons.workspace_premium,
                      size: width * 0.2,
                      color: const Color(0xFF00B0FF),
                    ),
              SizedBox(width: width * 0.05),
              _buildPointsInfo(context),
            ],
          ),
          SizedBox(height: width * 0.045),
          _buildProgressIndicator(context),
        ],
      ),
    );
  }

  Widget _buildPointsInfo(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            membershipType,
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            points,
            style: const TextStyle(
              // fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            memberSince,
            style: const TextStyle(color: Colors.grey, fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).toGoldMember,
          style: const TextStyle(
            color: Colors.black54,
            // fontWeight: FontWeight.bold,
            fontSize: 12.5,
          ),
        ),
        SizedBox(width: width * 0.03),
        Expanded(
          child: Container(
            height: width * 0.05,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: progress, // fill progress factor
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.shade400,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
