import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_client.dart';
import '../config/api_constants.dart';

class NotificationsController extends GetxController {
  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;
  int offset = 0;
  final int limit = 10;
  int unreadCount = 0;

  List<Map<String, dynamic>> notifications = [];

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      offset = 0;
      hasMore = true;
      notifications.clear();
    }

    if (isLoading || !hasMore) return;

    isLoading = offset == 0;
    isLoadingMore = offset > 0;
    update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (notifications) ---');
      debugPrint('URL: ${ApiConstants.notifications}');
      debugPrint('Query: {offset: $offset, limit: $limit}');

      final response = await dio.get(
        ApiConstants.notifications,
        queryParameters: {'offset': offset, 'limit': limit},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (notifications) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final data = response.data['data'];
          final List newNotifications = data['notifications'] ?? [];
          final pagination = data['pagination'];

          // Add to list and ensure no duplicates by ID if exists, or just append
          for (var n in newNotifications) {
             notifications.add(Map<String, dynamic>.from(n));
          }

          unreadCount = data['unread_count'] ?? 0;
          
          if (pagination != null) {
            offset = (pagination['offset'] ?? 0) + newNotifications.length;
            hasMore = pagination['has_more'] ?? false;
          } else {
            hasMore = false;
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    } finally {
      isLoading = false;
      isLoadingMore = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMore) return;
    await fetchNotifications();
  }

  Future<void> markAsRead(int notificationId) async {
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final data = {"notification_id": notificationId};

      debugPrint('\n--- API REQUEST (read_notification) ---');
      debugPrint('URL: ${ApiConstants.readNotification}');
      debugPrint('Body: $data');

      final response = await dio.post(
        ApiConstants.readNotification,
        data: data,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (read_notification) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          // Successfully marked as read
          // Update local state if needed (e.g., decrement unreadCount)
          if (unreadCount > 0) {
            unreadCount--;
            update();
          }
          
          // We could also find the notification in the list and mark it as read locally
          // but the current notification object doesn't seem to have a read status field
          // that we are using to style the UI. 
          // Since the user said "Strictly note that not change any single part of UI", 
          // I will just make the call and update the count.
        }
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }
}
