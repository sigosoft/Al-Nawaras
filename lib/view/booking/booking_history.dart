import 'package:flutter/material.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_tab_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_no_data.dart';
import '../../controller/home_controller.dart';
import '../../generated/l10n.dart';
import 'package:get/get.dart';
import 'booking_details_view.dart';
import '../book_parking/book_parking_screen.dart';

class BookingHistoryView extends StatefulWidget {
  const BookingHistoryView({super.key});

  @override
  State<BookingHistoryView> createState() => _BookingHistoryViewState();
}

class _BookingHistoryViewState extends State<BookingHistoryView> {
  String _selectedTab = 'All';

  @override
  void initState() {
    super.initState();
    // Fetch parking history when tab is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeController>().fetchParkingHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: const Color(0xFFE30613),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  controller.changeBottomNavIndex(0);
                }
              },
            ),
            title: Text(
              S.of(context).bookingHistory,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: false,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab Bar
                    BookingTabBar(
                      selectedTab: _selectedTab,
                      width: width,
                      onTabChanged: (tab) {
                        setState(() {
                          _selectedTab = tab;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    // Results List
                    if (controller.isLoadingHistory)
                      const SizedBox(
                        height: 300,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFE30613),
                          ),
                        ),
                      )
                    else if (controller.bookingHistory.isEmpty)
                      SizedBox(
                        height: mediaQuery.size.height * 0.6,
                        child: Center(
                          child: CustomNoData(
                            message: S.of(context).noBookingHistoryFound,
                          ),
                        ),
                      )
                    else
                      ..._buildDynamicCategorizedHistory(controller),

                    const SizedBox(height: 80), // Space for bottom nav
                  ],
                ),
              ),

              // Help button
              const DraggableHelpButton(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 1,
            onTap: (index) {
              controller.changeBottomNavIndex(index);
            },
          ),
        );
      },
    );
  }

  List<Widget> _buildDynamicCategorizedHistory(HomeController controller) {
    final filteredHistory = controller.bookingHistory.where((item) {
      if (_selectedTab == 'All') return true;
      final bool isItemActive = item['isActive'] == true;
      if (_selectedTab == 'Active') return isItemActive;
      if (_selectedTab == 'Completed') return !isItemActive;
      return false;
    }).toList();

    if (filteredHistory.isEmpty && _selectedTab != 'All') {
      return [
        SizedBox(
          height: 300,
          child: Center(
            child: CustomNoData(
              message: S.of(context).noEntriesForTab(_selectedTab),
            ),
          ),
        ),
      ];
    }

    String displayTab = _selectedTab;
    if (_selectedTab == 'All') displayTab = S.of(context).allTab;
    if (_selectedTab == 'Active') displayTab = S.of(context).activeTab;
    if (_selectedTab == 'Completed') displayTab = S.of(context).completedTab;

    return [
      Text(
        displayTab,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 12),
      ...filteredHistory.map(
        (item) => Column(
          children: [
            BookingCard(
              title: item['title'] ?? 'Parking',
              subtitle: item['subtitle'] ?? '',
              status: item['status'] ?? 'N/A',
              startDate: item['startDate'] ?? '',
              endDate: item['endDate'] ?? '',
              amount: item['amount'] ?? 'AED 0.00',
              isActive: item['isActive'] == true,
              actions: _buildActionButtons(item),
              onTap: () => Get.to(() => BookingDetailsView(booking: item)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      if (filteredHistory.isNotEmpty && controller.hasMoreHistory)
        _buildLoadMoreButton(controller),
    ];
  }

  List<Widget> _buildActionButtons(Map<String, dynamic> booking) {
    if (booking['isActive'] == true) {
      return [
        Expanded(
          child: SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () =>
                  Get.to(() => BookingDetailsView(booking: booking)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                S.of(context).viewDetails,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 36,
            child: OutlinedButton(
              onPressed: () => Get.to(() => const BookParkingScreen()),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE30613)),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                S.of(context).extend,
                style: const TextStyle(
                  color: Color(0xFFE30613),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ];
    } else {
      return [
        Expanded(
          child: SizedBox(
            height: 36,
            child: OutlinedButton(
              onPressed: () =>
                  Get.to(() => BookingDetailsView(booking: booking)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.grey),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                S.of(context).viewDetails,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ];
    }
  }

  Widget _buildLoadMoreButton(HomeController controller) {
    return SizedBox(
      width: double.infinity,
      child: controller.isHistoryLoadingMore
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Color(0xFFE30613),
                  strokeWidth: 2,
                ),
              ),
            )
          : TextButton(
              onPressed: () => controller.loadMoreParkingHistory(),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                S.of(context).loadMore,
                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
    );
  }
}
