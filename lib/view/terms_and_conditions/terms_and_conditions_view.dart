import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../controller/terms_and_conditions_controller.dart';
import '../../generated/l10n.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsAndConditionsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.title.value.isNotEmpty
                ? controller.title.value
                : S.of(context).termsAndConditions,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        backgroundColor: const Color(0xFFE30613),
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE30613)),
          );
        }

        final content = controller.localizedContent;
        if (content.isEmpty) {
          return Center(
            child: Text(
              S.of(context).noDataAvailable,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Html(
            data: content,
            style: {
              'body': Style(
                fontSize: FontSize(15.0),
                color: Colors.black87,
                lineHeight: LineHeight(1.5),
              ),
              'h1': Style(color: Colors.black, fontWeight: FontWeight.bold),
              'h2': Style(color: Colors.black, fontWeight: FontWeight.bold),
              'h3': Style(color: Colors.black, fontWeight: FontWeight.w600),
              'p': Style(margin: Margins.only(bottom: 12.0)),
              'a': Style(
                color: const Color(0xFFE30613),
                textDecoration: TextDecoration.none,
              ),
            },
          ),
        );
      }),
    );
  }
}
