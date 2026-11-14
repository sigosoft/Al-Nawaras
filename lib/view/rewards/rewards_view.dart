import 'package:al_nawaras/view/widgets/rewards_card.dart';
import 'package:flutter/material.dart';
import '../widgets/rewards_header.dart';
import '../widgets/rewards_action_item.dart';
import '../widgets/draggable_help_button.dart';
import 'package:get/get.dart';
import '../../controller/rewards_controller.dart';
import '../widgets/custom_no_data.dart';
import '../../generated/l10n.dart';
import '../../utils/api_labels.dart';
import '../terms_and_conditions/terms_and_conditions_view.dart';
import 'package:share_plus/share_plus.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.05;

    return GetBuilder<RewardsController>(
      init: RewardsController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFE30613)),
            ),
          );
        }

        if (controller.rewardsData == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF00B0FF),
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Center(
              child: CustomNoData(
                message: S.of(context).unableToLoadRewards,
                onRetry: () => controller.fetchRewardsData(),
              ),
            ),
          );
        }

        final data = controller.rewardsData!;

        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        RewardsHeader(
                          width: width,
                          height: height,
                          userName:
                              controller.profileData?['name'] ??
                              data['name'] ??
                              S.of(context).userFallback,
                          phoneNumber:
                              controller.profileData?['mobile'] ??
                              data['phone_number'] ??
                              '',
                          email:
                              controller.profileData?['email'] ??
                              data['email'] ??
                              '',
                          profilePicture:
                              controller.profileData?['profile_picture'] ??
                              controller.profileData?['profile_image'] ??
                              data['profile_picture'],
                        ),
                        PositionedDirectional(
                          top:
                              height *
                              0.25, // Adjusted to match original overlap
                          start: padding,
                          end: padding,
                          child: RewardsCard(
                            width: width,
                            points: S
                                .of(context)
                                .pointsCount(data['points']?.toString() ?? '0'),
                            membershipType:
                                data['membership_type'] != null
                                    ? ApiLabels.translate(S.of(context), data['membership_type'])
                                    : S.of(context).silverMember,
                            memberSince: S
                                .of(context)
                                .memberSince(
                                  data['member_since']?.toString() ?? '2023',
                                ),
                            progress:
                                (data['progress_bar_data']?['percentage'] ??
                                    0) /
                                100.0,
                            membershipImage: controller.getMemberImage(
                              data['membership_type'],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Buffer space for the overlapping card
                    SizedBox(height: height * 0.2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).howToEarnPoints,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildEarnPointsList(
                            data['earn_points_rules'] as List? ?? [],
                          ),
                          const SizedBox(height: 24),
                          Text(
                            S.of(context).redeemYourRewards,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildRedeemPointsSection(
                            width,
                            data['redeemable_rewards'] as List? ?? [],
                          ),
                          const SizedBox(height: 24),
                          _buildShareAndEarnSection(context, width),
                          const SizedBox(height: 24),
                          _buildTermsAndConditionsButton(context, width),
                          const SizedBox(height: 32), // Space for bottom
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEarnPointsList(List rules) {
    if (rules.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Center(child: Text(S.of(Get.context!).noRulesFound)),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: rules.map((r) {
            String title = r['title'] ?? S.of(Get.context!).titleFallback;
            return RewardsActionItem(
              icon: _getEarnIcon(title),
              title: title,
              points: '+${r['points'] ?? 0} ${S.of(Get.context!).pts}',
            );
          }).toList(),
        ),
      ),
    );
  }

  AssetImage _getEarnIcon(String title) {
    String t = title.toLowerCase();
    if (t.contains('slot'))
      return const AssetImage("lib/assets/images/book slot.png");
    if (t.contains('add-ons'))
      return const AssetImage("lib/assets/images/purchase addon.png");
    if (t.contains('refer'))
      return const AssetImage("lib/assets/images/refere frnd.png");
    if (t.contains('review'))
      return const AssetImage("lib/assets/images/Write review.png");
    return const AssetImage("lib/assets/images/book slot.png");
  }

  Widget _buildRedeemPointsSection(double width, List rewards) {
    if (rewards.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(child: Text(S.of(Get.context!).noRedeemableRewards)),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: rewards.map((r) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 12.0),
            child: _buildRedeemCard(
              r['title']?.toString().replaceAll(' ', '\n') ?? S.of(Get.context!).rewardFallback,
              '${r['points'] ?? 0} ${S.of(Get.context!).pts}',
              width,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRedeemCard(String title, String points, double width) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(points, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            SizedBox(
              height: width * 0.085,
              width: width * 0.22,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF5252), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  S.of(Get.context!).redeem,
                  style: const TextStyle(
                    color: Color(0xFFE30613),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareAndEarnSection(BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).shareEarn,
                  style: const TextStyle(fontSize: 17, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  S.of(context).inviteFriendsPoints,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: width * 0.20,
            height: width * 0.09,
            child: OutlinedButton(
              onPressed: () {
                Share.share(
                  S.of(context).shareMessage,
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE30613), width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                S.of(context).share,
                style: const TextStyle(color: Color(0xFFE30613), fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditionsButton(BuildContext context, double width) {
    return SizedBox(
      width: double.infinity,
      height: width * 0.12,
      child: OutlinedButton(
        onPressed: () => Get.to(() => const TermsAndConditionsView()),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFFCDD2), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          S.of(context).viewTerms,
          style: const TextStyle(color: Color(0xFFE30613), fontSize: 15),
        ),
      ),
    );
  }
}
