import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../notifications/notifications_view.dart';

class RewardsHeader extends StatelessWidget {
  final double width;
  final double height;
  final String userName;
  final String phoneNumber;
  final String email;
  final String? profilePicture;

  const RewardsHeader({
    super.key,
    required this.width,
    required this.height,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height * 0.28,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF00B0FF), // Vibrant Light Blue
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 10),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      S.of(context).rewards,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
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
                SizedBox(height: height * 0.008),
                _buildUserInfo(width),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD54F), // Light Gold/Yellow
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: width * 0.09,
              backgroundColor: Colors.transparent,
              child:
                  (profilePicture != null &&
                      profilePicture!.isNotEmpty &&
                      profilePicture != "null" &&
                      profilePicture != "false")
                  ? ClipOval(
                      child: (profilePicture!.startsWith('http'))
                          ? Image.network(
                              profilePicture!,
                              width: width * 0.18,
                              height: width * 0.18,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.person,
                                    color: Colors.blueGrey[800],
                                    size: width * 0.12,
                                  ),
                            )
                          : _isBase64(profilePicture!)
                          ? Image.memory(
                              base64Decode(
                                profilePicture!.contains(',')
                                    ? profilePicture!.split(',').last
                                    : profilePicture!,
                              ),
                              width: width * 0.18,
                              height: width * 0.18,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.person,
                                    color: Colors.blueGrey[800],
                                    size: width * 0.12,
                                  ),
                            )
                          : Icon(
                              Icons.person,
                              color: Colors.blueGrey[800],
                              size: width * 0.12,
                            ),
                    )
                  : Icon(
                      Icons.person,
                      color: Colors.blueGrey[800],
                      size: width * 0.12,
                    ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phoneNumber,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isBase64(String str) {
    if (str.length < 50) return false;
    try {
      base64Decode(str.contains(',') ? str.split(',').last : str);
      return true;
    } catch (_) {
      return false;
    }
  }
}
