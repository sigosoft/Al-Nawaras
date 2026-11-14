import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/book_parking_controller.dart';
import '../../generated/l10n.dart';
import '../../utils/slot_size_utils.dart';
import '../widgets/custom_app_bar.dart';

class SlotSelectionScreen extends GetView<BookParkingController> {
  const SlotSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: S.of(context).selectYourSlot,
        centerTitle: false,
        onBackPressed: () => Get.back(),
      ),
      body: Column(
        children: [
          _buildInfoSection(context),
          Expanded(
            child: GetBuilder<BookParkingController>(
              builder: (controller) {
                if (controller.availableSlotsList.isEmpty) {
                  return Center(
                    child: Text(S.of(context).noSlotsForType),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: controller.availableSlotsList.length,
                  itemBuilder: (context, index) {
                    final slot = controller.availableSlotsList[index];
                    final isFree = slot['state'] == 'free';
                    final isSelected = controller.selectedSlotId == slot['id'];
                    final slotSize = SlotSizeUtils.read(slot);

                    return GestureDetector(
                      onTap: isFree
                          ? (isSelected
                                ? null
                                : () => controller.selectSlot(
                                    slot['id'],
                                    slot['name'],
                                    size: slotSize,
                                  ))
                          : () => controller.handleUnavailableSelection(
                              message: S.of(context).slotAlreadyBooked,
                            ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(
                                  0xFFE30613,
                                ) // Branded Red for your choice
                              : (isFree
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.grey.withValues(
                                        alpha: 0.2,
                                      )), // Grey for booked
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE30613)
                                : (isFree ? Colors.green : Colors.grey),
                            width: isSelected ? 2.5 : 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : (isFree
                                        ? Icons.door_front_door
                                        : Icons.block),
                              color: isSelected
                                  ? Colors.white
                                  : (isFree ? Colors.green : Colors.grey),
                              size: 24,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              slot['name'] ?? S.of(context).notAvailableShort,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            if (slotSize.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 2,
                                ),
                                // Scale down instead of truncating: the
                                // selected tile's thicker border leaves less room.
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    '${S.of(context).sizeLabel}${SlotSizeUtils.format(slotSize)}',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            Text(
                              isFree ? S.of(context).slotFreeCaps : S.of(context).slotBookedCaps,
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white70
                                    : (isFree ? Colors.green : Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildConfirmButton(context),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectedTypeLabel(controller.selectedSlotTypeName ?? ''),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildLegendItem(Colors.green, S.of(context).available),
              const SizedBox(width: 20),
              _buildLegendItem(Colors.grey, S.of(context).booked),
              const SizedBox(width: 20),
              _buildLegendItem(const Color(0xFFE30613), S.of(context).selected),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: GetBuilder<BookParkingController>(
          builder: (controller) {
            final hasSelection = controller.selectedSlotId != null;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (controller.isCalculatedTotalAvailable)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).totalAmount,
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.calculatedTotal,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                if (!controller.isCalculatedTotalAvailable) const Spacer(),
                ElevatedButton(
                  onPressed: hasSelection ? () => Get.back() : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE30613),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(160, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: Text(
                    S.of(context).confirm,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
