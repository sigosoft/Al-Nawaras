import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../generated/l10n.dart';
import '../chat/customer_support_view.dart';

class DraggableHelpController extends GetxController {
  final _storage = GetStorage();
  double? helpBtnTop;
  double? helpBtnRight;

  @override
  void onInit() {
    super.onInit();
    helpBtnTop = _storage.read('helpBtnTop');
    helpBtnRight = _storage.read('helpBtnRight');
  }

  void updateHelpBtnPosition(double top, double right) {
    helpBtnTop = top;
    helpBtnRight = right;
    _storage.write('helpBtnTop', top);
    _storage.write('helpBtnRight', right);
    update();
  }

  void resetPosition(double initialTop, double initialRight) {
    helpBtnTop = initialTop;
    helpBtnRight = initialRight;
    _storage.remove('helpBtnTop');
    _storage.remove('helpBtnRight');
    update();
  }
}

class DraggableHelpButton extends StatelessWidget {
  const DraggableHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<DraggableHelpController>(
      init: DraggableHelpController(),
      builder: (controller) {
        // Initial position if not set
        // Default to the lower-right corner (above bottom bars) so it doesn't
        // cover buttons in the middle of the screen; users can still drag it.
        double currentTop = controller.helpBtnTop ?? height * 0.68;
        double currentRight = controller.helpBtnRight ?? 20.0;

        // Pinned to the "end" side: right in English, left in Arabic, so it
        // sits away from the start-aligned buttons in both layouts.
        final isRtl = Directionality.of(context) == TextDirection.rtl;
        return PositionedDirectional(
          top: currentTop,
          end: currentRight,
          child: GestureDetector(
            onTap: () {
              Get.to(() => const CustomerSupportView());
            },
            onPanUpdate: (details) {
              double newTop = currentTop + details.delta.dy;
              // "end" offset grows when dragging toward the start side.
              double newRight = isRtl
                  ? currentRight + details.delta.dx
                  : currentRight - details.delta.dx;

              // Bound checking to keep it within screen
              if (newTop > 0 && newTop < height - 100) {
                if (newRight > 0 && newRight < width - 50) {
                  controller.updateHelpBtnPosition(newTop, newRight);
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Text(
                    S.of(context).needHelp,
                    style: const TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ),
                const SizedBox(height: 5),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.teal.shade200,
                  child: ClipOval(
                    child: Image.asset(
                      'lib/assets/images/help.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
