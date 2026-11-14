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
  const DraggableHelpButton({super.key, this.bottomOffset = 0});

  /// Extra space to leave below the default position, for screens whose
  /// Stack also holds a sticky footer (e.g. a Next or Pay button).
  final double bottomOffset;

  /// Approximate size of the label + avatar, used to keep it on screen.
  static const double _btnHeight = 84;
  static const double _btnWidth = 90;
  static const double _margin = 12;

  @override
  Widget build(BuildContext context) {
    // Fill the parent Stack so the button is placed relative to the screen
    // body (above the bottom nav), not the whole device screen. Empty space
    // in this layer doesn't take taps, so content underneath stays usable.
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, box) => GetBuilder<DraggableHelpController>(
          init: DraggableHelpController(),
          builder: (controller) =>
              Stack(children: [_buildButton(context, controller, box)]),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    DraggableHelpController controller,
    BoxConstraints box,
  ) {
    final maxTop = (box.maxHeight - _btnHeight - _margin).clamp(
      0.0,
      double.infinity,
    );
    final maxEnd = (box.maxWidth - _btnWidth).clamp(0.0, double.infinity);
    // Default: bottom "end" corner, so it doesn't sit over mid-screen
    // links such as "View All". A dragged position is kept but clamped.
    final double currentTop = (controller.helpBtnTop ?? maxTop - bottomOffset)
        .clamp(0.0, maxTop);
    final double currentRight = (controller.helpBtnRight ?? _margin).clamp(
      0.0,
      maxEnd,
    );

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
          final newTop = (currentTop + details.delta.dy).clamp(0.0, maxTop);
          // "end" offset grows when dragging toward the start side.
          final newRight =
              (isRtl
                      ? currentRight + details.delta.dx
                      : currentRight - details.delta.dx)
                  .clamp(0.0, maxEnd);
          controller.updateHelpBtnPosition(newTop, newRight);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
  }
}
