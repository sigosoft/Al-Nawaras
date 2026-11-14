import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../controller/profile_controller.dart';
import '../../generated/l10n.dart';

class ProfileUpdateView extends StatelessWidget {
  const ProfileUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.06;

    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          S.of(context).personalInformation,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Red Curved Header overlap
                Container(
                  height: height * 0.12,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE30613),
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(30),
                      bottomEnd: Radius.circular(30),
                    ),
                  ),
                ),

                // Form Container
                Transform.translate(
                  offset: Offset(0, -height * 0.05),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Column(
                      children: [
                        _buildProfileImagePicker(context, width),
                        SizedBox(height: height * 0.04),
                        _buildFormFields(context, width),
                        SizedBox(height: height * 0.05),
                        _buildSaveButton(context, width),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Loading Overlay
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE30613)),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker(BuildContext context, double width) {
    final controller = Get.find<ProfileController>();
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Obx(() {
              final user = controller.profile.value;
              final selected = controller.selectedImage.value;
              final removed = controller.isImageRemoved.value;
              final img = user?.profileImage;

              const transparentPlaceholder =
                  "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==";

              return CircleAvatar(
                radius: width * 0.14,
                backgroundColor: Colors.white,
                backgroundImage: selected != null
                    ? FileImage(selected) as ImageProvider
                    : (img != null &&
                              img.isNotEmpty &&
                              img != transparentPlaceholder &&
                              !removed
                          ? (img.startsWith('http')
                                ? NetworkImage(img)
                                : MemoryImage(base64Decode(img))
                                      as ImageProvider)
                          : null),
                child:
                    (selected == null &&
                        (img == null ||
                            img.isEmpty ||
                            img == transparentPlaceholder ||
                            removed))
                    ? Icon(
                        Icons.person,
                        color: Colors.blueGrey[800],
                        size: width * 0.15,
                      )
                    : null,
              );
            }),
          ),
          PositionedDirectional(
            bottom: 4,
            end: 4,
            child: GestureDetector(
              onTap: () => _showImageSourceDialog(context, controller),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Color(0xFFE30613),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(
    BuildContext context,
    ProfileController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),

            // Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      S.of(context).profilePicture,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Obx(() {
                    final hasImage =
                        controller.selectedImage.value != null ||
                        (controller.profile.value?.profileImage != null &&
                            controller
                                .profile
                                .value!
                                .profileImage!
                                .isNotEmpty &&
                            !controller.isImageRemoved.value);

                    return hasImage
                        ? IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFFE30613),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              controller.removeImage();
                              controller.updateProfile(); // Save immediately
                            },
                          )
                        : const SizedBox(
                            width: 48,
                          ); // Placeholder to center title
                  }),
                ],
              ),
            ),
            const Divider(),

            // Source Options
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE30613).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Color(0xFFE30613),
                ),
              ),
              title: Text(
                S.of(context).camera,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE30613).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.image_outlined,
                  color: Color(0xFFE30613),
                ),
              ),
              title: Text(
                S.of(context).gallery,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context, double width) {
    final controller = Get.find<ProfileController>();
    return Column(
      children: [
        _buildInputField(
          label: S.of(context).fullName,
          hintText: S.of(context).enterFullName,
          icon: Icons.person_outline,
          controller: controller.nameController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: S.of(context).emailAddress,
          hintText: S.of(context).enterEmail,
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          controller: controller.emailController,
        ),
        const SizedBox(height: 20),
        _buildInputField(
          label: S.of(context).mobileNumber,
          hintText: S.of(context).enterMobileNumber,
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
          controller: controller.phoneController,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              prefixIcon: Icon(icon, color: Colors.grey[400], size: 22),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, double width) {
    final controller = Get.find<ProfileController>();
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () => controller.updateProfile(),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE30613),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          S.of(context).saveChanges,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
