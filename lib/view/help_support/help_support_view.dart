import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/help_support_controller.dart';
import '../../generated/l10n.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpSupportController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          S.of(context).helpSupport,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFFE30613), // App Red
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE30613)),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).howCanWeHelp,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).helpSupportDescription,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Email Support Card
              _buildContactCard(
                icon: Icons.email_outlined,
                title: S.of(context).emailSupport,
                value: controller.supportEmail.value.isNotEmpty
                    ? controller.supportEmail.value
                    : S.of(context).notAvailable,
              ),
              const SizedBox(height: 16),

              // Phone Support Card
              _buildContactCard(
                icon: Icons.phone_outlined,
                title: S.of(context).phoneSupport,
                value: controller.supportPhone.value.isNotEmpty
                    ? controller.supportPhone.value
                    : S.of(context).notAvailable,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return InkWell(
      onTap: () {
        if (value.isNotEmpty && value != S.of(Get.context!).notAvailable) {
          Clipboard.setData(ClipboardData(text: value));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9E4E4), // Light Red
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFE30613), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    // Phone numbers and emails are left-to-right; without this
                    // Arabic layout reorders "+971 800…" to "…800 971+".
                    textDirection: value == S.of(Get.context!).notAvailable
                        ? null
                        : TextDirection.ltr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.copy_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
