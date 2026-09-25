import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../controller/home_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_no_data.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final ctrl = Get.find<HomeController>();
          ctrl.currentIndex = 0;
          ctrl.fetchHomeData(); // Force fetch data explicitly when screen loads
          ctrl.update();
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    // Red Curved Background
                    Container(
                      height: height * 0.32,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE30613), // Primary red color
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(30),
                          bottomEnd: Radius.circular(30),
                        ),
                      ),
                    ),

                    // Main Content
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.08),
                          if (controller.isSectionVisible('header', [
                            S.of(context).welcome,
                            controller.userName,
                          ]))
                            _buildHeader(controller, context, height, width),

                          if (controller.isSectionVisible('membership', [
                            controller.membershipStatus,
                            controller.membershipTier,
                            S.of(context).renew,
                          ])) ...[
                            SizedBox(height: height * 0.025),
                            _buildMembershipCard(
                              controller,
                              context,
                              height,
                              width,
                            ),
                          ],

                          if (controller.isSectionVisible('buttons', [
                            S.of(context).bookParking,
                            S.of(context).requestService,
                          ])) ...[
                            SizedBox(height: height * 0.015),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSquareButton(
                                    S.of(context).bookParking,
                                    const AssetImage(
                                      "lib/assets/images/book parking.png",
                                    ),
                                    controller.onBookParkingClick,
                                    height,
                                    width,
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Expanded(
                                  child: _buildSquareButton(
                                    S.of(context).requestService,
                                    const AssetImage(
                                      "lib/assets/images/request service.png",
                                    ),
                                    controller.onRequestServiceClick,
                                    height,
                                    width,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if (controller.isSectionVisible('plans', [
                            S.of(context).membershipPlans,
                            S.of(context).buy,
                          ])) ...[
                            SizedBox(height: height * 0.02),
                            _buildPlanRow(controller, context, height, width),
                          ],

                          if (controller.isSectionVisible('navigate', [
                            S.of(context).navigateToYourParking,
                            S.of(context).getDirections,
                          ])) ...[
                            SizedBox(height: height * 0.02),
                            _buildNavigateBanner(
                              controller,
                              context,
                              height,
                              width,
                            ),
                          ],

                          SizedBox(height: height * 0.02),
                          _buildSearchBar(controller, context, height, width),

                          // Search Results for Locations from API
                          if (controller.searchQuery.isNotEmpty &&
                              controller.searchLocationsResults.isNotEmpty) ...[
                            SizedBox(height: height * 0.02),
                            _buildSectionHeader(
                              S.of(context).searchResults,
                              "",
                              () {},
                              height,
                            ),
                            SizedBox(height: height * 0.01),
                            ...controller.searchLocationsResults.map((
                              location,
                            ) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _buildActivityCard(
                                  location['name'] ?? '',
                                  S.of(context).location,
                                  Icons.location_on_outlined,
                                  const Color(0xFFE30613),
                                  height,
                                  width,
                                ),
                              );
                            }).toList(),
                          ],

                          if (controller.isSectionVisible('smartParking', [
                            S.of(context).smartParking,
                            S.of(context).forAllVehicleTypes,
                            S.of(context).securedSlots,
                            S.of(context).bookNow,
                          ])) ...[
                            SizedBox(height: height * 0.02),
                            _buildSmartParkingBanner(
                              controller,
                              context,
                              height,
                              width,
                            ),
                          ],

                          if (controller.isSectionVisible('opportunity', [
                            S.of(context).opportunity,
                            S.of(context).checkRewards,
                            'Rewards',
                          ])) ...[
                            SizedBox(height: height * 0.02),
                            _buildOpportunityBanner(
                              controller,
                              context,
                              height,
                              width,
                            ),
                          ],

                          if (controller.isSectionVisible('vehicles', [
                            S.of(context).myVehicles,
                          ])) ...[
                            SizedBox(height: height * 0.02),
                            _buildSectionHeader(
                              S.of(context).myVehicles,
                              controller.searchQuery.isEmpty
                                  ? (controller.showAllVehicles
                                        ? S.of(context).viewAll
                                        : S.of(context).viewAll)
                                  : "",
                              controller.onViewAllVehiclesClick,
                              height,
                            ),
                            SizedBox(height: height * 0.02),
                            _buildRegisterButton(controller, context, height),
                            SizedBox(height: height * 0.02),
                            if (controller.filteredVehicles.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                ),
                                child: CustomNoData(
                                  message: S.of(context).noDataAvailable,
                                ),
                              )
                            else
                              ...((controller.searchQuery.isEmpty &&
                                          !controller.showAllVehicles)
                                      ? controller.filteredVehicles.take(2)
                                      : controller.filteredVehicles)
                                  .map((vehicle) {
                                    return Column(
                                      children: [
                                        _buildVehicleCard(
                                          vehicle['title'],
                                          S
                                              .of(context)
                                              .license(vehicle['license']),
                                          vehicle['isParked'],
                                          vehicle['isParked']
                                              ? S
                                                    .of(context)
                                                    .parkedAtSpot(
                                                      vehicle['spot'],
                                                    )
                                              : S.of(context).awayFromParking,
                                          vehicle['image'],
                                          height,
                                          width,
                                        ),
                                        SizedBox(height: height * 0.015),
                                      ],
                                    );
                                  })
                                  .toList(),
                          ],

                          if (controller.isSectionVisible('activity', [
                            S.of(context).recentActivity,
                          ])) ...[
                            SizedBox(height: height * 0.035),
                            _buildSectionHeader(
                              S.of(context).recentActivity,
                              controller.searchQuery.isEmpty
                                  ? S.of(context).viewAll
                                  : "",
                              controller.onViewAllActivityClick,
                              height,
                            ),
                            SizedBox(height: height * 0.02),
                            if (controller.filteredActivities.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: height * 0.01,
                                ),
                                child: CustomNoData(
                                  message: S.of(context).noDataAvailable,
                                ),
                              )
                            else
                              ...((controller.searchQuery.isEmpty &&
                                          !controller.showAllActivities)
                                      ? controller.filteredActivities.take(2)
                                      : controller.filteredActivities)
                                  .map((activity) {
                                    String title = "";
                                    String subtitle = activity['subtitle'];

                                    if (activity['titleKey'] ==
                                        'parkingPayment') {
                                      title = S.of(context).parkingPayment;
                                    } else if (activity['titleKey'] ==
                                        'parkingRenewed') {
                                      title = S.of(context).parkingRenewed;
                                      subtitle = subtitle.replaceAll(
                                        'monthlyPremium',
                                        S.of(context).monthlyPremium,
                                      );
                                    } else if (activity['titleKey'] ==
                                        'vehicleCheckIn') {
                                      title = S.of(context).vehicleCheckIn;
                                      subtitle = subtitle.replaceAll(
                                        'parkedAtSpotA12',
                                        S.of(context).parkedAtSpot('A12'),
                                      );
                                    } else {
                                      title = (activity['titleKey'] ?? "")
                                          .toString();
                                      if (title.isEmpty)
                                        title = S.of(context).recentActivity;
                                    }

                                    return Column(
                                      children: [
                                        _buildActivityCard(
                                          title,
                                          subtitle,
                                          activity['icon'],
                                          activity['color'],
                                          height,
                                          width,
                                        ),
                                        SizedBox(height: height * 0.01),
                                      ],
                                    );
                                  })
                                  .toList(),
                          ],

                          SizedBox(height: height * 0.05), // Bottom padding
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeBottomNavIndex,
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    final img = controller.profilePicture;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).welcome,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                controller.userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: controller.onNotificationClick,
              child: const Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: width * 0.03),
            GestureDetector(
              onTap: controller.onProfileClick,
              child: Container(
                height: height * 0.045,
                width: height * 0.045,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // White background
                  image: img != null &&
                          img.isNotEmpty &&
                          img !=
                              "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=="
                      ? DecorationImage(
                          image: img.startsWith('http')
                              ? NetworkImage(img)
                              : MemoryImage(base64Decode(img)) as ImageProvider,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: img == null ||
                        img.isEmpty ||
                        img ==
                            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg=="
                    ? const Icon(Icons.person, color: Colors.black54)
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMembershipCard(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.membershipStatus,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  controller.membershipTier,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133),
                  ),
                ),
                if (controller.membershipValidUntil != null &&
                    controller.membershipValidUntil!.isNotEmpty) ...[
                  SizedBox(height: height * 0.005),
                  Text(
                    S.of(context).validUntil(controller.membershipValidUntil!),
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton(
            onPressed: controller.onRenewClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCDD2), // Light red/pink
              foregroundColor: const Color(0xFFE30613), // Red text
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: 0,
              ),
              minimumSize: Size(0, height * 0.04),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              S.of(context).renew,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton(
    String title,
    AssetImage image,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.12,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: image,
              color: const Color(0xFFE30613),
              height: 35,
              width: 35,
            ),
            SizedBox(height: height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001133),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanRow(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  "lib/assets/images/membership pleans.png",
                  height: 28,
                  width: 28,
                  color: const Color(0xFFE30613),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Text(
                    S.of(context).membershipPlans,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001133),
                    ),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: controller.onBuyMembershipClick,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE30613),
              side: const BorderSide(color: Color(0xFFE30613), width: 1.2),
              minimumSize: Size(width * 0.18, height * 0.04),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              S.of(context).buy,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigateBanner(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.20,
      decoration: BoxDecoration(
        color: const Color(0xFFBFE5E5), // Light teal background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: 0,
            bottom: 0,
            top: 0,
            width: width * 0.4,
            child: Image.asset(
              'lib/assets/images/map.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.map_outlined,
                size: 80,
                color: Colors.black12,
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: width * 0.55,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: width * 0.04,
                top: height * 0.02,
                bottom: height * 0.02,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    S.of(context).navigateToYourParking,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003D3D),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  ElevatedButton(
                    onPressed: controller.onGetDirectionsClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBFE5E5), // Matches bg
                      foregroundColor: const Color(0xFF003D3D), // Dark text
                      side: const BorderSide(
                        color: Color(0xFF003D3D),
                        width: 1,
                      ),
                      elevation: 0,
                      minimumSize: Size(width * 0.35, height * 0.038),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      S.of(context).getDirections,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      height: height * 0.055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.onSearchChanged,
        onTap: () =>
            controller.searchLocations(controller.searchController.text),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: S.of(context).search,
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIcon: const Icon(Icons.search, color: Colors.black38, size: 20),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: height * 0.015),
        ),
      ),
    );
  }

  Widget _buildSmartParkingBanner(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: 0,
            bottom: 0,
            top: 0,
            width: width * 0.45,
            child: Image.asset(
              'lib/assets/images/parking slot.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.local_parking,
                size: 80,
                color: Colors.black12,
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: width * 0.5,
            child: Padding(
              padding: EdgeInsetsDirectional.all(height * 0.02),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    S.of(context).smartParking,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE30613), // Red
                    ),
                  ),
                  Text(
                    S.of(context).forAllVehicleTypes,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001133), // Dark
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    S.of(context).securedSlots,
                    style: const TextStyle(fontSize: 9, color: Colors.black87),
                  ),
                  SizedBox(height: height * 0.01),
                  OutlinedButton(
                    onPressed: controller.onBookNowClick,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFE30613),
                      side: const BorderSide(
                        color: Color(0xFFE30613),
                        width: 1,
                      ),
                      minimumSize: Size(width * 0.3, height * 0.038),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      S.of(context).bookNow,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityBanner(
    HomeController controller,
    BuildContext context,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      height: height * 0.15,
      decoration: BoxDecoration(
        color: const Color(0xFFBFE5E5), // Light teal background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: 0,
            bottom: 0,
            top: 0,
            width: width * 0.45,
            child: Image.asset(
              'lib/assets/images/opportunity.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.card_giftcard,
                size: 60,
                color: Colors.black12,
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: width * 0.5,
            child: Padding(
              padding: EdgeInsetsDirectional.all(height * 0.02),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(
                    S.of(context).opportunity,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003D3D),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  OutlinedButton(
                    onPressed: controller.onCheckRewardsClick,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF003D3D), // Dark text
                      side: const BorderSide(
                        color: Color(0xFF003D3D),
                        width: 1,
                      ),
                      minimumSize: Size(width * 0.3, height * 0.038),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      S.of(context).checkRewards,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String actionText,
    VoidCallback onAction,
    double height,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001133),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: onAction,
          child: Text(
            actionText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE30613), // Red
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCard(
    String title,
    String subtitle,
    bool isParked,
    String statusText,
    String imagePath,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.07,
            width: width * 0.2,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: imagePath.startsWith('http')
                ? Image.network(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.directions_car, color: Colors.black26),
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.directions_car, color: Colors.black26),
                  ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.005),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isParked ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(
    HomeController controller,
    BuildContext context,
    double height,
  ) {
    return OutlinedButton(
      onPressed: controller.onRegisterVehicleClick,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFE30613), // Red text
        side: const BorderSide(
          color: Color(0xFFE30613),
          width: 1.5,
        ), // Red border
        minimumSize: Size(double.infinity, height * 0.055),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        S.of(context).registerNewVehicle,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActivityCard(
    String title,
    String subtitle,
    IconData iconData,
    Color iconColor,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.045,
            width: height * 0.045,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.005),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
