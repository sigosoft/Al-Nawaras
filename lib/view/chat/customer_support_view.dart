import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/customer_support_controller.dart';
import '../../generated/l10n.dart';

class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({super.key});

  // ============================================================
  // 🔹 TIME FORMATTER
  // ============================================================
  String _formatTime(String? rawTime) {
    if (rawTime == null || rawTime.isEmpty) return '';
    try {
      String t = rawTime.trim();
      // If the backend returns "2026-03-30 08:34:23" (without T or Z)
      if (!t.toUpperCase().endsWith('Z') && !t.contains('T')) {
        t = '${t.replaceAll(' ', 'T')}Z';
      }
      // If it contains T but no offset (like "2026-03-30T08:34:23")
      else if (!t.toUpperCase().endsWith('Z') &&
          t.contains('T') &&
          !t.contains('+') &&
          (!t.split('T')[1].contains('-'))) {
        t = '${t}Z';
      }

      final dt = DateTime.parse(t).toLocal();
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? S.of(Get.context!).pmLabel : S.of(Get.context!).amLabel;
      return '$h:$m $period';
    } catch (_) {
      return rawTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: Get.isRegistered<ChatController>()
          ? Get.find<ChatController>()
          : ChatController(),
      builder: (controller) {
        // Clear unread badge whenever the chat screen is open
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.markAllRead();
        });

        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: Colors.red[800],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              '24/7 Customer Support',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.messages.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        controller.loadMoreMessages();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      reverse: true, // Bottom to top scroll behavior
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          controller.messages.length +
                          (controller.isFetchingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.messages.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        }
                        final msg = controller.messages[index];
                        return _buildMessageItem(
                          text: msg['text'] ?? '',
                          isMe: msg['isMe'] ?? false,
                          sender: msg['sender'] ?? '',
                          time: _formatTime(msg['time'] as String?),
                          image: msg['image'] as String?,
                          userProfileImageBytes:
                              controller.userProfileImageBytes,
                          userProfileImageUrl: controller.userProfileImage,
                        );
                      },
                    ),
                  );
                }),
              ),
              _buildBottomInput(controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageItem({
    required String text,
    required bool isMe,
    required String sender,
    required String time,
    String? image,
    Uint8List? userProfileImageBytes,
    String? userProfileImageUrl,
  }) {
    // ── Avatar ──────────────────────────────────────────────
    final avatar = isMe
        ? Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: userProfileImageBytes != null
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: MemoryImage(userProfileImageBytes),
                  )
                : (userProfileImageUrl != null &&
                      userProfileImageUrl.startsWith('http'))
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(userProfileImageUrl),
                  )
                : const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(
                      "lib/assets/images/chatbot2.png",
                    ),
                  ),
          )
        : Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.teal.shade800, width: 1.5),
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('lib/assets/images/chatbot.png'),
            ),
          );

    final bubbleBg = isMe ? const Color(0xFFF9E4E4) : Colors.white;
    final bubbleRadius = isMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 40), child: avatar),
                const SizedBox(height: 4),
                Text(
                  sender,
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: bubbleBg,
                    borderRadius: bubbleRadius,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (image != null && image.isNotEmpty) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: image.startsWith('http')
                              ? Image.network(
                                  image,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : _buildBase64Image(image),
                        ),
                        if (text.isNotEmpty) const SizedBox(height: 8),
                      ],
                      if (text.isNotEmpty)
                        Text(
                          text,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                    ],
                  ),
                ),
                if (time.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                ],
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 12),
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 16), child: avatar),
                const SizedBox(height: 4),
                Text(
                  sender,
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBase64Image(String base64Str) {
    try {
      return Image.memory(
        base64Decode(base64Str),
        width: 200,
        fit: BoxFit.cover,
      );
    } catch (_) {
      return const SizedBox.shrink();
    }
  }

  void _showPicker(BuildContext context, ChatController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.black54),
                title: Text(S.of(context).takeAPhoto),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickAndSendImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.black54),
                title: Text(S.of(context).chooseFromGallery),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickAndSendImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomInput(ChatController controller) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
        bottom: 24,
        top: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300, width: 0.8),
              ),
              child: TextField(
                controller: controller.messageController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: S.of(Get.context!).typeYourMessageHere,
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.image_outlined,
                      color: Colors.grey[500],
                      size: 22,
                    ),
                    onPressed: () => _showPicker(Get.context!, controller),
                  ),
                ),
                onSubmitted: (_) => controller.sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 44,
            width: 80,
            child: ElevatedButton(
              onPressed: () => controller.sendMessage(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: Text(
                S.of(Get.context!).send,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
