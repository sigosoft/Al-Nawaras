import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../config/api_constants.dart';
import '../generated/l10n.dart';
import 'base_client.dart';

class ChatController extends GetxController {
  final Dio dio = BaseClient.dio;
  final box = GetStorage();
  final TextEditingController messageController = TextEditingController();

  var isLoading = false.obs;
  var isSending = false.obs;
  var messages = <Map<String, dynamic>>[].obs;

  var hasMoreMessages = true.obs;
  var isFetchingMore = false.obs;
  var offset = 0.obs;
  final int limit = 20;

  /// Unread message count – shown as a red dot on the chatbot FAB
  var unreadCount = 0.obs;

  /// The logged-in user's profile picture (base64 or URL) loaded from storage
  String? userProfileImage;

  /// Decoded bytes for the user's profile image (if base64)
  Uint8List? userProfileImageBytes;

  Timer? _pollTimer;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile(); // Calls API to get the real profile picture
    fetchMessages();
    startPolling();
  }

  @override
  void onClose() {
    stopPolling();
    super.onClose();
  }

  // ============================================================
  // 🔹 FETCH USER PROFILE IMAGE FROM API
  // ============================================================
  Future<void> fetchUserProfile() async {
    final token = box.read('token');
    if (token == null) return;

    try {
      final response = await dio.get(
        ApiConstants.profile,
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data != null && data['status'] == true) {
        final profileData = data['data'] ?? data;
        final img =
            profileData['profile_picture'] ??
            profileData['profile_image'] ??
            profileData['image'] ??
            '';

        const transparentPlaceholder =
            "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==";

        if (img is String && img.isNotEmpty && img != transparentPlaceholder) {
          userProfileImage = img;
          if (!img.startsWith('http')) {
            try {
              userProfileImageBytes = base64Decode(img);
            } catch (_) {
              userProfileImageBytes = null;
            }
          } else {
            userProfileImageBytes = null;
          }
          // Persist for other reads
          box.write('profile_image', img);
          update(); // Rebuild view with real avatar
        }
      }
    } on DioException catch (e) {
      if (kDebugMode) print('fetchUserProfile error: $e');
    } catch (e) {
      if (kDebugMode) print('fetchUserProfile exception: $e');
    }
  }

  void startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isLoading.value && !isFetchingMore.value) {
        pollMessages();
      }
    });
  }

  void stopPolling() {
    _pollTimer?.cancel();
  }

  /// Called when the user opens the chat – clears the unread badge
  void markAllRead() {
    unreadCount.value = 0;
  }

  // ============================================================
  // 🔹 HELPER: map a raw API message to local structure
  // ============================================================
  Map<String, dynamic> _mapMessage(dynamic m) {
    final isMe = m['is_from_customer'] == true;
    return {
      'isMe': isMe,
      'text': m['message'] ?? '',
      'sender': isMe ? S.of(Get.context!).meLabel : S.of(Get.context!).supportLabel,
      'id': m['id'],
      'time': m['created_at'] ?? m['date'] ?? m['timestamp'] ?? '',
      'is_read': m['is_read'] ?? true,
      'image': m['image'] ?? m['attachment'],
    };
  }

  // ============================================================
  // 🔹 1. FETCH MESSAGES
  // ============================================================
  Future<void> fetchMessages({bool reset = true}) async {
    if (reset) {
      isLoading(true);
      offset(0);
      hasMoreMessages(true);
      messages.clear();
    } else {
      if (!hasMoreMessages.value || isFetchingMore.value) return;
      isFetchingMore(true);
    }
    update();

    try {
      final token = box.read('token');

      if (kDebugMode) {
        print('--- Fetching Messages ---');
        print('URL: ${ApiConstants.getMessages}');
        print('Query: {limit: $limit, offset: ${offset.value}}');
      }

      final response = await dio.get(
        ApiConstants.getMessages,
        queryParameters: {"limit": limit, "offset": offset.value},
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
      }

      final data = response.data;
      if (data != null && data['status'] == true) {
        final rawData = data['data'];
        final List fetchedMessages =
            (rawData != null && rawData['messages'] is List)
            ? rawData['messages']
            : [];

        final mapped = fetchedMessages.map(_mapMessage).toList();

        if (reset) {
          messages.assignAll(mapped);
          // Count unread support messages on initial load
          unreadCount.value = mapped
              .where((m) => m['isMe'] == false && m['is_read'] == false)
              .length;
        } else {
          // Filter out duplicates before appending
          final existingIds = messages
              .where((m) => m['id'] != null)
              .map((m) => m['id'])
              .toSet();

          final uniqueNewMessages = mapped
              .where((m) => !existingIds.contains(m['id']))
              .toList();

          messages.addAll(uniqueNewMessages);
        }

        offset.value += mapped.length;
        hasMoreMessages.value = mapped.length >= limit;
      } else {
        hasMoreMessages.value = false;
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      hasMoreMessages.value = false;
    } catch (e) {
      if (kDebugMode) print('Exception in fetchMessages: $e');
      hasMoreMessages.value = false;
    } finally {
      isLoading(false);
      isFetchingMore(false);
      update();
    }
  }

  Future<void> loadMoreMessages() async {
    await fetchMessages(reset: false);
  }

  // ============================================================
  // 🔹 2. POLL NEW MESSAGES (Real-time)
  // ============================================================
  Future<void> pollMessages() async {
    final token = box.read('token');
    if (token == null) return;

    try {
      final response = await dio.get(
        ApiConstants.getMessages,
        queryParameters: {"limit": limit, "offset": 0},
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data != null && data['status'] == true) {
        final rawData = data['data'];
        final List fetchedMessages =
            (rawData != null && rawData['messages'] is List)
            ? rawData['messages']
            : [];

        final mapped = fetchedMessages.map(_mapMessage).toList();

        // Identify truly new messages (not in our current list by ID)
        final List<Map<String, dynamic>> newItems = [];
        for (var newItem in mapped) {
          final newItemId = newItem['id'];
          if (messages.any((m) => m['id'] == newItemId)) {
            break; // Hit existing messages
          }
          newItems.add(newItem);
        }

        if (newItems.isNotEmpty) {
          // Count new unread support messages for the badge
          final newUnread = newItems
              .where((m) => m['isMe'] == false && m['is_read'] == false)
              .length;
          unreadCount.value += newUnread;

          // Process updates in reverse to maintain order while inserting at 0
          for (var newItem in newItems.reversed) {
            // Remove optimistic placeholder for sent messages if found
            if (newItem['isMe'] == true) {
              final optIdx = messages.indexWhere(
                (m) =>
                    m['id'] == null &&
                    m['isMe'] == true &&
                    m['text'] == newItem['text'],
              );
              if (optIdx != -1) {
                messages.removeAt(optIdx);
              }
            }
            messages.insert(0, newItem);
            offset.value++;
          }
          update();
        }
      }
    } catch (e) {
      if (kDebugMode) print('Polling error: $e');
    }
  }

  // ============================================================
  // 🔹 3. SEND MESSAGE
  // ============================================================
  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    try {
      isSending(true);
      final token = box.read('token');

      // Optimistically add to local list for snappy UI
      messages.insert(0, {
        'isMe': true,
        'text': text,
        'sender': S.of(Get.context!).meLabel,
        'id': null, // Marks it as optimistic
        'time': DateTime.now().toUtc().toIso8601String(),
        'is_read': true,
      });

      messageController.clear(); // Clear input right away
      update(); // Update UI optimistically

      final response = await dio.post(
        ApiConstants.sendMessage,
        data: {"message": text.trim()},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data['status'] != true) {
        // If failed, remove optimistic message
        messages.removeWhere((m) => m['id'] == null && m['text'] == text);
        Get.snackbar(
          S.of(Get.context!).error,
          data['message'] ?? S.of(Get.context!).failedToSendMessage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Force poll to get the real message with ID immediately
        pollMessages();
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      messages.removeWhere((m) => m['id'] == null && m['text'] == text);
    } catch (e) {
      if (kDebugMode) print('Exception in sendMessage: $e');
      messages.removeWhere((m) => m['id'] == null && m['text'] == text);
    } finally {
      isSending(false);
      update();
    }
  }

  // ============================================================
  // 🔹 4. PICK & SEND IMAGE
  // ============================================================
  final picker = ImagePicker();

  Future<void> pickAndSendImage(ImageSource source) async {
    try {
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 800,
      );
      if (picked == null) return;

      isSending(true);
      final token = box.read('token');

      final bytes = await picked.readAsBytes();
      final base64Image = base64Encode(bytes);

      // Optimistic UI for image
      messages.insert(0, {
        'isMe': true,
        'text': '', // or '[Image]' if we don't render it
        'image': base64Image,
        'sender': S.of(Get.context!).meLabel,
        'id': null,
        'time': DateTime.now().toUtc().toIso8601String(),
        'is_read': true,
      });
      update();

      // For Odoo APIs it's safer to use FormData when sending large base64 or files,
      // but to match sendMessage, we can try formUrlEncoded or FormData.
      // Profile uses FormData. Let's use FormData here to avoid URL escaping issues with large base64.
      final formData = FormData.fromMap({
        "message": "",
        "image": base64Image,
        "attachment": base64Image,
        "file": base64Image,
      });

      final response = await dio.post(
        ApiConstants.sendMessage,
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $token", "Accept": "*/*"},
        ),
      );

      final data = response.data;
      if (data != null && data['status'] != true) {
        messages.removeWhere((m) => m['id'] == null && m['image'] == base64Image);
        Get.snackbar(
          S.of(Get.context!).error,
          data['message'] ?? S.of(Get.context!).failedToSendImage,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        pollMessages();
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      messages.removeWhere((m) => m['id'] == null);
    } catch (e) {
      if (kDebugMode) print('Exception in pickAndSendImage: $e');
      messages.removeWhere((m) => m['id'] == null);
    } finally {
      isSending(false);
      update();
    }
  }
}
