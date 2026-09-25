import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/book_parking_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_no_data.dart';

class BookParkingScreen extends StatelessWidget {
  final bool fromSmartParking;
  final String? preselectedSlotNumber;
  final String? preselectedSlotCode;

  const BookParkingScreen({
    super.key,
    this.fromSmartParking = false,
    this.preselectedSlotNumber,
    this.preselectedSlotCode,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<BookParkingController>(
      init: BookParkingController(),
      builder: (controller) {
        // Re-apply map slot if controller was recreated by GetBuilder.
        if (fromSmartParking &&
            preselectedSlotNumber != null &&
            preselectedSlotNumber!.isNotEmpty &&
            controller.selectedSlotName != preselectedSlotNumber) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!controller.fromSmartParking ||
                controller.selectedSlotName != preselectedSlotNumber) {
              controller.applySmartParkingSlot(
                slotNumber: preselectedSlotNumber!,
                slotCode: preselectedSlotCode,
              );
            }
          });
        } else if (!fromSmartParking && controller.fromSmartParking) {
          // Opening normal Book Parking — clear Smart Parking mode.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.fromSmartParking = false;
            controller.smartParkingSlotCode = null;
            controller.selectedSlotId = null;
            controller.selectedSlotName = null;
            controller.update();
          });
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: fromSmartParking || controller.fromSmartParking
                ? S.of(context).smartParking
                : S.of(context).bookParking,
            centerTitle: false,
            onBackPressed: () {
              Get.back();
            },
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.025),
                            _buildLabel(S.of(context).selectVehicle),
                            _buildVehicleCard(
                              context,
                              controller,
                              width,
                              height,
                            ),
                            SizedBox(height: height * 0.035),
                            _buildLabel(S.of(context).parkingType),
                            _buildParkingTypeRow(
                              context,
                              controller,
                              width,
                              height,
                            ),
                            SizedBox(height: height * 0.035),
                            _buildLabel(S.of(context).membershipPackage),
                            _buildMembershipList(
                              context,
                              controller,
                              width,
                              height,
                            ),
                            SizedBox(height: height * 0.035),
                            _buildDateTimeSection(
                              context,
                              controller,
                              width,
                              height,
                            ),
                            if (!fromSmartParking &&
                                !controller.fromSmartParking) ...[
                              SizedBox(height: height * 0.035),
                              _buildLabel(S.of(context).availableSlotTypes),
                              controller.isDateTimeSelected
                                  ? _buildAvailableSummaryList(
                                      context,
                                      controller,
                                      width,
                                      height,
                                    )
                                  : _buildDateTimePlaceholder(context, width),
                            ],
                            if (controller.selectedSlotName != null &&
                                controller.selectedSlotName!.isNotEmpty) ...[
                              SizedBox(height: height * 0.02),
                              SizedBox(height: height * 0.02),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.check_circle,
                                        color: Colors.green, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        S.of(context).selectedSlot(
                                              controller.selectedSlotName ?? '',
                                            ),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            SizedBox(height: height * 0.035),
                            _buildLabel(S.of(context).addonServicesOptional),
                            _buildAddonList(context, controller, width, height),
                            SizedBox(height: height * 0.05),
                          ], 
                        ),
                      ),
                    ),
                  ),
                  _buildBottomAction(context, controller, width, height),
                ],
              ),
              const DraggableHelpButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVehicleCard(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingVehicles) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
      );
    }

    if (controller.vehiclesList.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            S.of(context).noVehiclesFound,
            style: const TextStyle(color: Colors.black45),
          ),
        ),
      );
    }

    final v = controller.selectedVehicleData;
    if (v == null) return const SizedBox();

    return PopupMenuButton<Map<String, dynamic>>(
      onSelected: (vehicle) => controller.setSelectedVehicle(vehicle),
      offset: const Offset(0, 80),
      itemBuilder: (context) {
        return controller.vehiclesList.map((vehicle) {
          return PopupMenuItem<Map<String, dynamic>>(
            value: vehicle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vehicle['vehicle_type_name'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  vehicle['license_number'] ?? '',
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        ),
        child: Row(
          children: [
            Image.asset(
              controller.getVehicleImage(v['vehicle_type_name']),
              height: 50,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    v['vehicle_type_name'] ?? S.of(context).genericVehicle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF001133),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).license(v['license_number'] ?? 'N/A'),
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingTypeRow(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingParkingTypes) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Color(0xFFE30613)),
      );
    }

    if (controller.dynamicParkingTypes.isEmpty) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          S.of(context).noDataAvailable,
          style: const TextStyle(color: Colors.black45),
        ),
      );
    }

    final types = controller.dynamicParkingTypes;
    final rowItems = <Widget>[];

    for (int i = 0; i < types.length; i += 3) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < 3; j++) {
        if (i + j < types.length) {
          final pt = types[i + j];
          final typeKey = pt['name']?.toString() ?? 'Parking Plan';
          final image = controller.getParkingTypeImage(typeKey);
          rowChildren.add(
            _buildParkingTypeItem(
              context,
              typeKey,
              typeKey, // Use API name as display title
              image,
              controller,
              height,
              width,
            ),
          );
        } else {
          // Invisible placeholder to keep spaceBetween identical
          rowChildren.add(SizedBox(width: width * 0.28));
        }
      }
      rowItems.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowChildren,
        ),
      );

      if (i + 3 < types.length) {
        rowItems.add(SizedBox(height: height * 0.015));
      }
    }

    return Column(children: rowItems);
  }

  Widget _buildParkingTypeItem(
    BuildContext context,
    String typeKey,
    String title,
    AssetImage image,
    BookParkingController controller,
    double height,
    double width,
  ) {
    final isSelected = controller.selectedParkingType == typeKey;
    return GestureDetector(
      onTap: () => controller.setParkingType(typeKey),
      child: Container(
        width: width * 0.28,
        height: height * 0.17, // using identical media query constraint
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00B2FF)
                : Colors.black.withValues(alpha: 0.05),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 8, top: 4),
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF00B2FF)
                          : Colors.black12,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF00B2FF),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            Image(image: image, height: 40, width: 40),
            const SizedBox(height: 8),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimePlaceholder(BuildContext context, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 40,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 12),
          const Text(
            "Choose date and time for selecting the slot",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableSummaryList(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingSummary) {
      return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
      );
    }

    if (controller.availableSummaryList.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            controller.dateController.text.isEmpty
                ? S.of(context).pleaseSelectDateTimeFirst
                : S.of(context).noSlotTypesAvailable,
            style: const TextStyle(color: Colors.black45),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: controller.availableSummaryList
            .where((st) {
              // 1. Filter by Location (Shaded/Unshaded)
              final selectedTypeLower = controller.selectedParkingType.toLowerCase();
              final mappedId = controller.locationIdMap[selectedTypeLower];
              bool matchesLocation = (mappedId == null || st['location_id'] == mappedId);
              if (!matchesLocation) return false;

              // 2. Filter by Vehicle Type (e.g., JETSKI should only see JETSKI slots)
              final vehicleTypeName = controller.selectedVehicleData?['vehicle_type_name']?.toString().toLowerCase() ?? '';
              final slotTypeName = st['slot_type_name']?.toString().toLowerCase() ?? '';
              
              // Only filter if both names are available to avoid empty lists.
              // We check if the slot type name contains the vehicle type name (e.g. "Boats Type A" contains "Boat")
              if (vehicleTypeName.isNotEmpty && slotTypeName.isNotEmpty) {
                // Remove trailing 's' or 'ies' for better matching (e.g. JETSKIS vs JETSKI)
                final vPart = vehicleTypeName.replaceAll(RegExp(r's$'), '');
                if (!slotTypeName.contains(vPart)) return false;
              }

              return true;
            })
            .map((st) {
          final isSelected = controller.selectedSlotTypeId == st['slot_type_id'];
          final isAvailable = (st['available_count'] ?? 0) > 0;

          return InkWell(
            onTap: isAvailable
                ? () => controller.checkSlotAvailability(
                    st['slot_type_id'], st['slot_type_name'], st['location_id'])
                : () => controller.handleUnavailableSelection(
                    message: S.of(context).slotAlreadyBooked),
            child: Opacity(
              opacity: isAvailable ? 1.0 : 0.5,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00B2FF)
                              : Colors.black12,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00B2FF),
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            st['slot_type_name'] ?? S.of(context).slotType,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            S.of(context).availableCount(st['available_count']?.toString() ?? '0'),
                            style: TextStyle(
                              fontSize: 11,
                              color: isAvailable ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.isLoadingAvailability && isSelected)
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child:
                            CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF00B2FF)),
                      )
                    else
                      const Icon(Icons.arrow_forward_ios,
                          size: 14, color: Colors.black26),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateTimeSection(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    final isFixedPlan = !controller.selectedMembership.toLowerCase().contains('hourly');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).dateTime,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).startDate,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField(
                    'dd/mm/yyyy',
                    controller.dateController,
                    () => controller.selectDate(context),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).startTime,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField(
                    '--- -- --',
                    controller.timeController,
                    () => controller.selectTime(context),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).endDateLabel,
                    style: TextStyle(
                      fontSize: 12, 
                      color: isFixedPlan ? Colors.black26 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField(
                    'dd/mm/yyyy',
                    controller.endDateController,
                    isFixedPlan ? null : () => controller.selectEndDate(context),
                    isReadOnly: isFixedPlan,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).endTimeLabel,
                    style: TextStyle(
                      fontSize: 12, 
                      color: isFixedPlan ? Colors.black26 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField(
                    '--- -- --',
                    controller.endTimeController,
                    isFixedPlan ? null : () => controller.selectEndTime(context),
                    isReadOnly: isFixedPlan,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(
    String hint,
    TextEditingController controller,
    VoidCallback? onTap, {
    bool isReadOnly = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: isReadOnly ? Colors.grey[100] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isReadOnly 
                ? Colors.black.withValues(alpha: 0.03)
                : Colors.black.withValues(alpha: 0.08),
          ),
        ),
        child: TextField(
          controller: controller,
          enabled: false, // Prevents keyboard and ensures onTap works
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isReadOnly ? Colors.black12 : Colors.black26, 
              fontSize: 13,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          ),
          style: TextStyle(
            fontSize: 13, 
            color: isReadOnly ? Colors.black38 : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildAddonList(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingServices) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
      );
    }

    if (controller.addonServices.isEmpty) {
      return CustomNoData(message: S.of(context).noServicesAvailable);
    }

    return Column(
      children: List.generate(controller.addonServices.length, (index) {
        final addon = controller.addonServices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildCustomCheckbox(
                  addon['isSelected'],
                  () => controller.toggleAddon(index),
                ),
                const SizedBox(width: 12),
                (addon['icon'] is String && addon['icon'].isNotEmpty)
                    ? Image.asset(
                        addon['icon'],
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.miscellaneous_services,
                              size: 40,
                              color: Color(0xFF00B2FF),
                            ),
                      )
                    : const Icon(
                        Icons.miscellaneous_services,
                        size: 40,
                        color: Color(0xFF00B2FF),
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: (addon['title'] ?? '') + ' ',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B2FF),
                              ),
                            ),
                            TextSpan(
                              text: '(${addon['price']})',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B2FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        addon['subtitle'] ?? '',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMembershipList(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingMemberships) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Color(0xFFE30613)),
      );
    }

    if (controller.membershipPackages.isEmpty) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "No membership packages available",
          style: TextStyle(color: Colors.black45, fontSize: 12),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: List.generate(controller.membershipPackages.length, (index) {
          final pkg = controller.membershipPackages[index];
          final title = pkg['title'] ?? '';
          final price = pkg['price'] ?? '';
          final isSelected = controller.selectedMembership == title;
          final isLast = index == controller.membershipPackages.length - 1;

          return InkWell(
            onTap: () => controller.setSelectedMembership(title),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Row(
                    children: [
                      // Radio-style indicator
                      Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF00B2FF)
                                : Colors.black.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? Center(
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF00B2FF),
                                  ),
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 15),
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
                            ),
                            const SizedBox(height: 2),
                            Text(
                              price,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black.withValues(alpha: 0.05),
                    indent: 0,
                    endIndent: 0,
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomAction(
    BuildContext context,
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: controller.isTermsAccepted,
                    onChanged: (_) => controller.toggleTermsAccepted(),
                    activeColor: const Color(0xFFE30613),
                    side: const BorderSide(color: Colors.black38, width: 1.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.toggleTermsAccepted,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text:
                                Localizations.localeOf(context).languageCode ==
                                    'ar'
                                ? 'أوافق على '
                                : 'I agree to the ',
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: controller.openTermsAndConditions,
                              child: Text(
                                S.of(context).termsAndConditions,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFE30613),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.isCalculatedTotalAvailable)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalAmount,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        controller.calculatedTotal,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                if (!controller.isCalculatedTotalAvailable) const Spacer(),
                ElevatedButton(
                  onPressed: controller.isBooking
                      ? null
                      : controller.onNextClick,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isTermsAccepted
                        ? const Color(0xFFE30613)
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                    minimumSize: Size(width * 0.5, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isBooking
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          S.of(context).next,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox(bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
          ),
          if (isSelected)
            PositionedDirectional(
              top: -3,
              start: 2,
              child: CustomPaint(
                size: const Size(18, 18),
                painter: TickPainter(),
              ),
            ),
        ],
      ),
    );
  }
}

class TickPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Starting point of the tick
    path.moveTo(size.width * 0.1, size.height * 0.45);
    // Bottom point of the tick
    path.lineTo(size.width * 0.35, size.height * 0.75);
    // Ending point (long slanted line)
    path.lineTo(size.width * 1.0, size.height * 0.05);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
