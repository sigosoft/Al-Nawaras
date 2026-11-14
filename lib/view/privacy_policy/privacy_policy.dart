import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../controller/privacy_policy_controller.dart';
import '../../generated/l10n.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrivacyPolicyController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          S.of(context).privacyPolicy,
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

        if (controller.privacyPolicyContent.value.isEmpty) {
          return Center(
            child: Text(
              S.of(context).privacyPolicyNotAvailable,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Html(
            data: controller.privacyPolicyContent.value,
            style: {
              "body": Style(
                fontSize: FontSize(15.0),
                color: Colors.black87,
                lineHeight: LineHeight(1.5),
              ),
              "h1": Style(color: Colors.black, fontWeight: FontWeight.bold),
              "h2": Style(color: Colors.black, fontWeight: FontWeight.bold),
              "h3": Style(color: Colors.black, fontWeight: FontWeight.w600),
              "p": Style(margin: Margins.only(bottom: 12.0)),
              "a": Style(color: const Color(0xFFE30613), textDecoration: TextDecoration.none),
            },
          ),
        );
      }),
    );
  }
}
