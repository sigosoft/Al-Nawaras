import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../generated/l10n.dart';
import '../../controller/register_vehicle_controller.dart';

class RegisterVehicleScreen extends StatelessWidget {
  const RegisterVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<RegisterVehicleController>(
      init: RegisterVehicleController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: AppBar(
            backgroundColor: const Color(0xFFE30613),
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              S.of(context).registerNewVehicle,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: controller.onSkipClick,
                child: Row(
                  children: [
                    Text(
                      S.of(context).skip,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: width * 0.01),
                    Image.asset(
                      "lib/assets/images/skip.png",
                      height: 10,
                      width: 10,
                    ),
                  ],
                ),
              ),
            ],
            centerTitle: false,
            titleSpacing: 0,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.025),
                      Text(
                        S.of(context).pleaseProvideVehicleDetails,
                        style: const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        S.of(context).selectVehicleType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      _buildVehicleTypeGrid(context, controller, height, width),
                      SizedBox(height: height * 0.035),
                      _buildLabel(S.of(context).vehicleLicenseNumber),
                      _buildTextField(
                        controller.licenseController,
                        S.of(context).enterLicenseNumber,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildLabel(S.of(context).make),
                      _buildTextField(
                        controller.makeController,
                        S.of(context).makeHint,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildLabel('${S.of(context).model} (Optional)'),
                      _buildTextField(
                        controller.modelController,
                        S.of(context).modelHint,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildLabel('${S.of(context).chassisNumber} (Optional)'),
                      _buildTextField(
                        controller.chassisController,
                        S.of(context).chassisHint,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildLabel('${S.of(context).year} (Optional)'),
                      _buildTextField(
                        controller.yearController,
                        S.of(context).yearHint,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.02),
                      _buildLabel('Color (Optional)'),
                      _buildTextField(
                        controller.colorController,
                        'e.g. Blue',
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.035),
                      Text(
                        S.of(context).vehicleDimensions,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      _buildTextField(
                        controller.lengthController,
                        S.of(context).lengthM,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.012),
                      _buildTextField(
                        controller.widthController,
                        S.of(context).widthM,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.012),
                      _buildTextField(
                        controller.heightController,
                        S.of(context).heightM,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.035),
                      _buildLabel(S.of(context).comments),
                      _buildTextArea(
                        controller.commentsController,
                        S.of(context).comments,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.035),
                      _buildLabel('${S.of(context).vehiclePhoto} (Optional)'),
                      _buildUploadBox(
                        S.of(context).tapToUploadPhoto,
                        controller.onUploadPhotoClick,
                        height,
                        width,
                        file: controller.vehiclePhoto,
                      ),
                      SizedBox(height: height * 0.035),
                      _buildLabel(S.of(context).vehicleRegistrationDocument),
                      _buildUploadBox(
                        S.of(context).tapToUploadDocument,
                        controller.onUploadDocClick,
                        height,
                        width,
                        file: controller.registrationDoc,
                      ),
                      SizedBox(height: height * 0.045),
                      _buildButton(
                        S.of(context).register,
                        const Color(0xFFE30613),
                        Colors.white,
                        controller.onRegisterClick,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.015),
                      _buildOutlinedButton(
                        S.of(context).registerLater,
                        const Color(0xFFE30613),
                        controller.onRegisterLaterClick,
                        height,
                        width,
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVehicleTypeGrid(
    BuildContext context,
    RegisterVehicleController controller,
    double height,
    double width,
  ) {
    if (controller.isLoadingTypes) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
      );
    }

    if (controller.vehicleTypes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            S.of(context).noVehicleTypesAvailable,
            style: const TextStyle(color: Colors.black45),
          ),
        ),
      );
    }

    final types = controller.vehicleTypes;
    final rowItems = <Widget>[];

    for (int i = 0; i < types.length; i += 3) {
      final rowChildren = <Widget>[];
      for (int j = 0; j < 3; j++) {
        if (i + j < types.length) {
          final vt = types[i + j];
          final name = vt['name']?.toString() ?? 'Vehicle';
          final imagePath = controller.getVehicleImage(name);
          rowChildren.add(
            _buildTypeItem(name, imagePath, controller, height, width),
          );
        } else {
          // Add invisible placeholder of same width to preserve spaceBetween alignment
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

  Widget _buildTypeItem(
    String title,
    String imagePath,
    RegisterVehicleController controller,
    double height,
    double width,
  ) {
    final isSelected = controller.selectedVehicleType == title;
    return GestureDetector(
      onTap: () => controller.setVehicleType(title),
      child: Container(
        width: width * 0.28,
        height: height * 0.19, // Ensuring identical height across all cards
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.directions_car,
                size: 40,
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: isSelected
                        ? const Color(0xFFE30613)
                        : Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFE30613) : Colors.black12,
                  width: 1,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    double height,
    double width,
  ) {
    return Container(
      height: height * 0.055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildTextArea(
    TextEditingController controller,
    String hint,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildUploadBox(
    String hint,
    VoidCallback onTap,
    double height,
    double width, {
    XFile? file,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.15,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomPaint(
          painter: DashPainter(),
          child: file != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(File(file.path), fit: BoxFit.cover),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/images/no image.png",
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      hint,
                      style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color bg,
    Color textCol,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: textCol,
        minimumSize: Size(double.infinity, height * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildOutlinedButton(
    String text,
    Color color,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 1.2),
        minimumSize: Size(double.infinity, height * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final length = dashWidth;
        canvas.drawPath(metric.extractPath(distance, distance + length), paint);
        distance += length + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
