import 'package:al_nawaras/view/chat/customer_support_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/customer_support_controller.dart';
import '../../generated/l10n.dart';

class ChatbotButton extends StatelessWidget {
  const ChatbotButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Lazily find or create the controller so the badge stays reactive
    final ChatController chatCtrl = Get.isRegistered<ChatController>()
        ? Get.find<ChatController>()
        : Get.put(ChatController(), permanent: false);

    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 16),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomRight,
        children: [
          Positioned(
            bottom: 45, // Elevate above avatar center
            right: 52, // Push leftwards to look top-left
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    S.of(context).needHelp,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  bottom: -4,
                  child: Transform.rotate(
                    angle: 45 * 3.141592653589793 / 180,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CustomerSupportView(),
                ),
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red.shade800, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage('lib/assets/images/chatbot.png'),
                  ),
                ),
                // 🔴 Unread badge dot – only visible when there are unread messages
                Obx(() {
                  if (chatCtrl.unreadCount.value == 0) {
                    return const SizedBox.shrink();
                  }
                  return Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: Colors.red[800],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
