import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../notifications/notifications_view.dart';
import '../../generated/l10n.dart';

class ProfileHeader extends StatelessWidget {
  final double width;
  final double height;

  const ProfileHeader({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Red Header Background to match HomeScreen
        Container(
          height: height * 0.28,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(234, 227, 6, 6), // Primary red color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Get.find<HomeController>().changeBottomNavIndex(0);
                        }
                      },
                    ),
                    Text(
                      S.of(context).profile,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Get.to(() => const NotificationsView()),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.015),
                _buildUserInfo(width),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(double width) {
    final controller = Get.find<ProfileController>();
    return Obx(() {
      final user = controller.profile.value;
      final box = GetStorage();

      final name = user?.name ?? box.read('name') ?? S.of(Get.context!).userFallback;
      final mobile = user?.mobile ?? box.read('mobile') ?? S.of(Get.context!).notAvailableShort;
      final email = user?.email ?? box.read('email') ?? S.of(Get.context!).notAvailableShort;
      final img = user?.profileImage;

      const transparentPlaceholder =
          "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==";

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),

              child: CircleAvatar(
                radius: width * 0.11, // Dynamic size
                backgroundColor: Colors.white,
                backgroundImage:
                    img != null &&
                        img.isNotEmpty &&
                        img != transparentPlaceholder
                    ? (img.startsWith('http')
                          ? NetworkImage(img)
                          : (controller.profileImageBytes.value != null
                                ? MemoryImage(
                                    controller.profileImageBytes.value!,
                                  )
                                : null))
                    : null,
                child:
                    img == null || img.isEmpty || img == transparentPlaceholder
                    ? Icon(
                        Icons.person,
                        color: Colors.blueGrey[800],
                        size: width * 0.12,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mobile,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
