import 'package:al_nawaras/view/login/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context).security,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              S.of(context).manageAccountSecurity,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),

            // Security Options
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSecurityOption(
                    icon: Icons.lock_outline,
                    title: S.of(context).changePassword,
                    onTap: () {
                      Get.to(() => const ForgotPasswordView());
                    },
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 16),
                  _buildSecurityOption(
                    icon: Icons.fingerprint,
                    title: S.of(context).enableBiometricsLogin,
                    trailing: Switch(
                      value: false, // Default false for now
                      onChanged: (val) {
                        Get.snackbar(
                          S.of(context).comingSoon,
                          S.of(context).biometricsComingSoon,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      activeColor: Colors.red[800],
                    ),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 16),
                  _buildSecurityOption(
                    icon: Icons.verified_user_outlined,
                    title: S.of(context).twoStepVerification,
                    trailing: Text(
                      S.of(context).offStatus,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Get.snackbar(
                        S.of(context).comingSoon,
                        S.of(context).twoStepComingSoon,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityOption({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red[50],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.red[800], size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: trailing == null
          ? onTap
          : null, // If there's a switch, we let the switch handle it
    );
  }
}
