import 'package:al_nawaras/controller/profile_controller.dart';
import 'package:al_nawaras/controller/about_us_controller.dart';
import 'package:al_nawaras/view/booking/booking_history.dart';
import 'package:al_nawaras/view/privacy_policy/privacy_policy.dart';
import 'package:al_nawaras/view/security/security_view.dart';
import 'package:al_nawaras/view/help_support/help_support_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../widgets/profile_header.dart';
import '../widgets/membership_status_card.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/draggable_help_button.dart';
import '../../controller/home_controller.dart';
import '../../controller/logout_controller.dart';
import '../../controller/additional_services_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'Profile_update_view.dart';
import '../../controller/welcome_controller.dart';

class ProfileView extends StatelessWidget {
  final Function(int)? onTabChanged;
  const ProfileView({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.06;

    final profileController = Get.put(ProfileController());
    final additionalServicesController = Get.put(
      AdditionalServicesController(),
    );

    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      initState: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final homeController = Get.find<HomeController>();
          homeController.currentIndex = 3;
          homeController.update();
        });
      },
      builder: (homeController) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Obx(() {
            if (profileController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFE30613)),
              );
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header + overlapping card share one hit-test area so
                      // My Vehicles / Bookings / Services taps work.
                      SizedBox(
                        height: height * 0.45,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ProfileHeader(width: width, height: height),
                            PositionedDirectional(
                              top: height * 0.25,
                              start: padding,
                              end: padding,
                              child: MembershipStatusCard(
                                width: width,
                                status:
                                    homeController.membershipStatus !=
                                        "Loading..."
                                    ? homeController.membershipStatus
                                    : (profileController
                                              .profile
                                              .value
                                              ?.membershipStatus ??
                                          S.of(context).noStatus),
                                vehicles: homeController.allVehicles,
                                bookings: homeController.bookingHistory,
                                services:
                                    additionalServicesController.services,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        child: Column(
                          children: [
                            _buildMenuList(context, width),
                            SizedBox(height: height * 0.03),
                            _buildSignOutButton(context, width),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const DraggableHelpButton(),
              ],
            );
          }),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: homeController.currentIndex,
            onTap: homeController.changeBottomNavIndex,
          ),
        );
      },
    );
  }

  Widget _buildMenuList(BuildContext context, double width) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.find<ProfileController>().resetControllers();
            Get.to(() => const ProfileUpdateView());
          },
          child: ProfileMenuItem(
            icon: Icons.person_outline,
            title: S.of(context).personalInformation,
            subtitle: S.of(context).updatePersonalDetails,
            width: width,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const SecurityView());
          },
          child: ProfileMenuItem(
            icon: Icons.security_outlined,
            title: S.of(context).security,
            subtitle: S.of(context).manageSecurity,
            width: width,
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     Get.to(() => const PaymentView());
        //   },
        //   child: ProfileMenuItem(
        //     icon: Icons.credit_card_outlined,
        //     title: S.of(context).paymentMethods,
        //     subtitle: S.of(context).managePaymentOptions,
        //     width: width,
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            Get.to(() => const BookingHistoryView());
          },
          child: ProfileMenuItem(
            icon: Icons.assignment_outlined,
            title: S.of(context).bookings,
            subtitle: S.of(context).viewPastBookings,
            width: width,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const HelpSupportView());
          },
          child: ProfileMenuItem(
            icon: Icons.help_outline,
            title: S.of(context).helpSupport,
            subtitle: S.of(context).getHelpAccount,
            width: width,
            circleBorderWidth: 2.0,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const PrivacyPolicyView());
          },
          child: ProfileMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: S.of(context).privacyPolicy,
            subtitle: S.of(context).privacyPolicySubtitle,
            width: width,
            circleBorderWidth: 2.0,
          ),
        ),
        GestureDetector(
          onTap: () {
            final wc = Get.put(WelcomeController());
            final currentLang = wc.getCurrentLocale();
            Get.dialog(
              AlertDialog(
                title: Text(S.of(context).language),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String>(
                      title: Text(S.of(context).english),
                      value: 'en',
                      groupValue: currentLang,
                      activeColor: const Color(0xFFE30613),
                      onChanged: (val) {
                        wc.changeLanguage('en');
                        Get.back();
                      },
                    ),
                    RadioListTile<String>(
                      title: Text(S.of(context).arabic),
                      value: 'ar',
                      groupValue: currentLang,
                      activeColor: const Color(0xFFE30613),
                      onChanged: (val) {
                        wc.changeLanguage('ar');
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: ProfileMenuItem(
            icon: Icons.language,
            title: S.of(context).language,
            subtitle: S.of(context).languageSubtitle,
            width: width,
            circleBorderWidth: 2.0,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.put(AboutUsController()).openAboutUsLink();
          },
          child: ProfileMenuItem(
            icon: Icons.error_outline,
            title: S.of(context).aboutAlNawaras,
            subtitle: S.of(context).learnMoreServices,
            width: width,
            circleBorderWidth: 2.0,
          ),
        ),
      ],
    );
  }

  Widget _buildSignOutButton(BuildContext context, double width) {
    final logoutController = Get.put(LogoutController());
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: Text(S.of(context).logout),
              content: Text(S.of(context).logoutConfirm),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    logoutController.logOut();
                  },
                  child: Text(
                    S.of(context).yes,
                    style: const TextStyle(color: Color(0xFFE30613)),
                  ),
                ),
              ],
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFE30613), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          S.of(context).signOut,
          style: const TextStyle(
            color: Color(0xFFE30613),
            // fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
