import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_no_data.dart';

class MyVehiclesView extends StatelessWidget {
  const MyVehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<HomeController>().loadMoreVehicles(reset: true);
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: S.of(context).myVehicles,
            centerTitle: false,
            onBackPressed: () => Get.back(),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  width * 0.05,
                  height * 0.02,
                  width * 0.05,
                  0,
                ),
                child: OutlinedButton(
                  onPressed: controller.onRegisterVehicleClick,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFE30613),
                    side: const BorderSide(
                      color: Color(0xFFE30613),
                      width: 1.5,
                    ),
                    minimumSize: Size(double.infinity, height * 0.055),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    S.of(context).registerNewVehicle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.loadMoreVehicles(reset: true),
                  color: const Color(0xFFE30613),
                  child: controller.filteredVehicles.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: height * 0.45,
                              child: CustomNoData(
                                message: S
                                    .of(context)
                                    .currentlyNoItemsFoundPleaseTryLater,
                              ),
                            ),
                          ],
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              controller.loadMoreVehicles();
                            }
                            return true;
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.02,
                            ),
                            itemCount: controller.filteredVehicles.length +
                                (controller.isVehicleLoading ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index ==
                                  controller.filteredVehicles.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }
                              final vehicle =
                                  controller.filteredVehicles[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: height * 0.015,
                                ),
                                child: _buildVehicleCard(
                                  vehicle['title'],
                                  S.of(context).license(vehicle['license']),
                                  vehicle['isParked'],
                                  vehicle['isParked']
                                      ? S
                                          .of(context)
                                          .parkedAtSpot(vehicle['spot'])
                                      : S.of(context).awayFromParking,
                                  vehicle['image'],
                                  height,
                                  width,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
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
}
