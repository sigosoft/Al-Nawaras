import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../additional_services/additional_services_screen.dart';
import '../booking/booking_history.dart';
import '../profile/profile_view.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'home_screen.dart';

/// Root screen that hosts the four bottom-nav tabs (Home, Bookings, Services,
/// Profile). Tabs live in an [IndexedStack] so their state and fetched data
/// survive tab switches; the newly selected tab fades/slides in.
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  /// True while a [MainShell] is mounted, so [HomeController] can switch tabs
  /// in place instead of pushing a new route.
  static bool isMounted = false;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _tabs = <Widget>[
    HomeScreen(),
    BookingHistoryView(),
    AdditionalServicesScreen(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    MainShell.isMounted = true;
  }

  @override
  void dispose() {
    MainShell.isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {
        Get.find<HomeController>().currentIndex = widget.initialIndex;
      },
      builder: (controller) {
        final index = controller.currentIndex.clamp(0, _tabs.length - 1);
        return PopScope(
          // System back on another tab returns to Home before leaving the app.
          canPop: index == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) controller.changeBottomNavIndex(0);
          },
          child: Scaffold(
            backgroundColor: const Color(0xFFF7F7F7),
            body: IndexedStack(
              index: index,
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  _TabTransition(active: i == index, child: _tabs[i]),
              ],
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: index,
              onTap: controller.changeBottomNavIndex,
            ),
          ),
        );
      },
    );
  }
}

/// Fades and slightly slides a tab in when it becomes the active one, and
/// pauses tickers of hidden tabs.
class _TabTransition extends StatelessWidget {
  const _TabTransition({required this.active, required this.child});

  final bool active;
  final Widget child;

  static const _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    return TickerMode(
      enabled: active,
      child: AnimatedOpacity(
        opacity: active ? 1 : 0,
        duration: active ? _duration : Duration.zero,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: active ? Offset.zero : const Offset(0, 0.02),
          duration: active ? _duration : Duration.zero,
          curve: Curves.easeOutCubic,
          child: child,
        ),
      ),
    );
  }
}
