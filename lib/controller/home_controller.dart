import 'dart:async';
import 'package:intl/intl.dart';
import 'package:al_nawaras/view/book_parking/book_parking_screen.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:al_nawaras/controller/book_parking_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/register_vehicle/register_vehicle_screen.dart';
import '../view/membership_plans/membership_plans_screen.dart';
import '../view/additional_services/additional_services_screen.dart';
import '../view/profile/profile_view.dart';
import '../view/booking/booking_history.dart';
import '../view/parking/select_parking_view.dart';
import '../view/home/home_screen.dart';
import 'package:al_nawaras/view/rewards/rewards_view.dart';
import '../../generated/l10n.dart';
import '../view/home/my_vehicles_view.dart';
import '../view/home/recent_activity_view.dart';
import '../view/notifications/notifications_view.dart';
import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import '../view/login/login_screen.dart';
import '../view/settings/maintenance.dart';
import '../config/api_constants.dart';
import 'base_client.dart';
import 'dart:math' as math;

class HomeController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  int currentIndex = 0;
  String searchQuery = "";
  bool showAllVehicles = false;
  bool showAllActivities = false;

  String userName = "Loading...";
  String membershipStatus = "Loading...";
  String membershipTier = "Loading...";
  String? membershipValidUntil;
  bool claimReward = false;
  String? profilePicture;

  List<Map<String, dynamic>> allVehicles = [];
  List<Map<String, dynamic>> allActivities = [];

  List<Map<String, dynamic>> filteredVehicles = [];
  List<Map<String, dynamic>> filteredActivities = [];

  bool hasMoreVehicles = true;
  bool hasMoreActivities = true;
  bool isVehicleLoading = false;
  bool isActivityLoading = false;
  bool isLoadingHistory = false;

  int vehicleOffset = 0;
  int activityOffset = 0;
  int historyOffset = 0;
  final int limit = 10;

  bool hasMoreHistory = true;
  bool _isHomeLoading = false;
  bool isSectionVisible(String sectionName, List<String> terms) {
    if (searchQuery.isEmpty) return true;

    // Check if any of the provided terms match the search query
    bool match = terms.any((term) => term.toLowerCase().contains(searchQuery));
    if (match) return true;

    // Also check if any of the list items match (if it's a list section)
    if (sectionName == 'vehicles' && filteredVehicles.isNotEmpty) return true;
    if (sectionName == 'activity' && filteredActivities.isNotEmpty) return true;
    if (sectionName == 'locations' && searchLocationsResults.isNotEmpty) {
      return true;
    }

    return false;
  }

  bool isHistoryLoadingMore = false;

  List<Map<String, dynamic>> bookingHistory = [];

  @override
  void onInit() {
    super.onInit();
    fetchSettings();
    fetchHomeData();
    fetchParkingHistory();
  }

  Future<void> fetchSettings() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String buildVersion = packageInfo.version;

      final dio = BaseClient.dio;
      final response = await dio.get(ApiConstants.settings);

      if (kDebugMode) {
        print('\n--- API REQUEST (settings) ---');
        print('URL: ${ApiConstants.settings}');
        print('--- API RESPONSE (settings) ---');
        print('Response Body: ${response.data}');
      }

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data']?['settings'];
        if (data != null) {
          bool maintenanceAndroid = data['maintenance_android'] == 1;
          bool maintenanceIos = data['maintenance_ios'] == 1;

          String? reason = Platform.isAndroid
              ? data['maintenance_reason_android']?.toString()
              : data['maintenance_reason_ios']?.toString();

          // Fallback if platform-specific reason is missing
          reason ??=
              data['maintenance_reason_ios']?.toString() ??
              data['maintenance_reason_android']?.toString();

          if (Platform.isAndroid && maintenanceAndroid) {
            Get.offAll(() => Maintenance(serverDownReason: reason));
          } else if (Platform.isIOS && maintenanceIos) {
            Get.offAll(() => Maintenance(serverDownReason: reason));
          } else {
            // Check for updates
            String playStoreVersion =
                data['play_store_version']?.toString() ?? "1.0.0";
            String appStoreVersion =
                data['app_store_version']?.toString() ?? "1.0.0";
            bool forceUpdateAndroid = data['play_store_update'] == 1;
            bool forceUpdateIos = data['app_store_update'] == 1;

            if (Platform.isAndroid &&
                forceUpdateAndroid &&
                _versionToCode(playStoreVersion) >
                    _versionToCode(buildVersion)) {
              // Get.offAll(() => const NeedAnUpdate()); // If you have this screen
            } else if (Platform.isIOS &&
                forceUpdateIos &&
                _versionToCode(appStoreVersion) >
                    _versionToCode(buildVersion)) {
              // Get.offAll(() => const NeedAnUpdate()); // If you have this screen
            }
          }
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch settings: $e');
      }
    }
  }

  int _versionToCode(String version) {
    try {
      List<String> codes = version.split('.');
      int code = 0;
      for (int i = 0; i < codes.length; i++) {
        // Correct versioning multiplication to handle correctly (major, minor, patch)
        code += int.parse(codes[i]) * math.pow(1000, 2 - i).toInt();
      }
      return code;
    } catch (e) {
      return 0;
    }
  }

  bool _isLoggingOut = false;
  Future<void> logOut() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    try {
      final storage = GetStorage();
      await storage.erase();

      // Clear specific user related data just in case erase() is not immediate enough for sync reads
      userName = "Loading...";
      membershipStatus = "Loading...";
      profilePicture = null;

      // Ensure we only navigate if we are not already going there
      if (Get.currentRoute != '/LoginScreen') {
        Get.offAll(() => const LoginScreen());
      }
    } finally {
      _isLoggingOut = false;
    }
  }

  Future<void> fetchHomeData() async {
    if (_isHomeLoading) return;
    _isHomeLoading = true;
    try {
      // Check maintenance status every time home data is fetched/refreshed
      fetchSettings();

      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      if (token == null || token.toString().isEmpty || token == "null") {
        if (kDebugMode) print('No token found, skipping home data fetch.');
        _isHomeLoading = false;
        return;
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      if (kDebugMode) {
        print('\n--- API REQUEST (home) ---');
        print('URL: ${ApiConstants.home}');
        print('Headers: $headers');
      }

      final response = await dio.get(
        ApiConstants.home,
        options: Options(headers: headers),
      );

      if (kDebugMode) {
        print('--- API RESPONSE (home) ---');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.data}');
        print('--------------------------\n');
      }

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final data = response.data['data'];

          userName = data['user_name'] ?? 'Guest';
          profilePicture = data['profile_picture'];

          final membership = data['membership_details'];
          if (membership != null) {
            String status =
                membership['status']?.toString() ?? 'No Active Plan';
            if (status.toLowerCase().contains('no active')) {
              membershipStatus = S.of(Get.context!).noActivePlan;
            } else {
              membershipStatus = status;
            }

            String tier = membership['tier']?.toString() ?? 'Standard';
            if (tier.toLowerCase().contains('silver')) {
              membershipTier = S.of(Get.context!).silverTier;
            } else if (tier.toLowerCase().contains('gold')) {
              membershipTier = S.of(Get.context!).goldTier;
            } else if (tier.toLowerCase().contains('standard')) {
              membershipTier = S.of(Get.context!).standardTier;
            } else {
              membershipTier = tier;
            }
            membershipValidUntil = membership['valid_until']?.toString();
          }

          claimReward = data['claim_reward'] == true;

          final vehicles = data['my_vehicles'] as List?;
          if (vehicles != null) {
            allVehicles = vehicles.map((v) {
              String? imageVal = v['vehicle_image']?.toString();
              return {
                'title': v['vehicle_type_name'] ?? 'Vehicle',
                'license': v['license_number'] ?? '',
                'isParked': false,
                'spot': '',
                'image':
                    (imageVal != null &&
                        imageVal.isNotEmpty &&
                        imageVal != "false")
                    ? imageVal
                    : 'lib/assets/images/Airstream.png',
              };
            }).toList();
            vehicleOffset = allVehicles.length;
            hasMoreVehicles = vehicles.length >= limit;
          }

          final activities = data['recent_activities'] as List?;
          if (activities != null) {
            allActivities = activities.map<Map<String, dynamic>>((raw) {
              final a = Map<String, dynamic>.from(raw as Map);
              final String state = a['state']?.toString().toLowerCase() ?? '';
              final double amount = (a['amount'] as num?)?.toDouble() ?? 0.0;
              final String startStr = a['booking_start']?.toString() ?? '';

              // Inferred type: if payment-related, use 'renew' style (blue)
              final bool isPayment =
                  amount > 0 || state.contains('payment') || state == 'paid';
              final String type = isPayment ? 'renew' : 'checkin';

              // Decide on titleKey
              final String titleKey =
                  a['title_key'] ??
                  (isPayment ? 'parkingPayment' : 'vehicleCheckIn');

              // Format Subtitle: Today/Yesterday/Date + hh:mm a + Extra Info
              String displaySub = startStr;
              try {
                if (startStr.isNotEmpty) {
                  final dt = DateTime.parse(startStr);
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final activityDate = DateTime(dt.year, dt.month, dt.day);

                  String datePart;
                  if (activityDate == today) {
                    datePart = S.of(Get.context!).today;
                  } else if (activityDate == yesterday) {
                    datePart = S.of(Get.context!).yesterday;
                  } else {
                    datePart = DateFormat('MMM dd').format(dt);
                  }

                  displaySub = "$datePart, ${DateFormat('hh:mm a').format(dt)}";
                }
              } catch (_) {}

              if (amount > 0) {
                displaySub += ' AED $amount';
              } else if (a['location'] != null && a['location'] != "false") {
                displaySub += '-Spot ${a['location']}';
              }

              return <String, dynamic>{
                'titleKey': titleKey,
                'subtitle': displaySub,
                'icon': _getActivityIcon(type),
                'color': _getActivityColor(type),
              };
            }).toList();
            activityOffset = allActivities.length;
            hasMoreActivities = activities.length >= limit;
          }

          filteredVehicles = List.from(allVehicles);
          filteredActivities = List.from(allActivities);
          update();
        }
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        logOut();
      }
      BaseClient.handleDioError(e);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch home data: $e');
      }
    } finally {
      _isHomeLoading = false;
    }
  }

  IconData _getActivityIcon(String? type) {
    if (type == 'renew' || type == 'checkin') {
      return Icons.check_circle_outline;
    }
    return Icons.notifications_none;
  }

  Color _getActivityColor(String? type) {
    if (type == 'renew') return const Color(0xFF00B2FF);
    if (type == 'checkin') return const Color(0xFF4EEB4E);
    return Colors.grey;
  }

  Future<void> fetchParkingHistory({bool reset = true}) async {
    if (reset) {
      historyOffset = 0;
      hasMoreHistory = true;
      isLoadingHistory = true;
      bookingHistory.clear();
    } else {
      if (!hasMoreHistory || isHistoryLoadingMore) return;
      isHistoryLoadingMore = true;
    }
    update();

    try {
      final storage = GetStorage();
      final token = storage.read('token');

      if (token == null || token.toString().isEmpty || token == "null") {
        debugPrint('No token found, skipping parking history fetch.');
        isLoadingHistory = false;
        isHistoryLoadingMore = false;
        return;
      }

      final dio = BaseClient.dio;

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (parking/history) ---');
      debugPrint('ENTRY: fetchParkingHistory(reset: $reset)');
      debugPrint('URL: ${ApiConstants.parkingHistory}');
      debugPrint('Query: {offset: $historyOffset, limit: $limit}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.parkingHistory,
        queryParameters: {'offset': historyOffset, 'limit': limit},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking/history) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final historyData = response.data['data']['history'] as List? ?? [];
          final newItems = historyData.map((item) {
            final String state = item['state']?.toString() ?? 'N/A';

            String formatStatus(String statusStr) {
              if (statusStr.isEmpty || statusStr.toLowerCase() == 'n/a')
                return 'N/A';
              final clean = statusStr.replaceAll('_', ' ').replaceAll('-', ' ');
              return clean
                  .split(' ')
                  .map((word) {
                    if (word.isEmpty) return '';
                    return word[0].toUpperCase() +
                        word.substring(1).toLowerCase();
                  })
                  .join(' ');
            }

            return {
              'id': item['id'],
              'reference': item['reference'] ?? '',
              'title':
                  item['membership_type']?.toString() ??
                  item['reference'] ??
                  'Parking',
              'subtitle':
                  '${item['vehicle'] ?? ''} • ${item['vehicle_type'] ?? ''} • Spot ${item['slot'] ?? item['location'] ?? 'N/A'}',
              'status': formatStatus(state),
              'startDate': item['start_date'] ?? '',
              'endDate': item['end_date'] ?? '',
              'amount':
                  '${S.of(Get.context!).currency} ${item['amount'] ?? '0'}',
              'isActive':
                  state.toLowerCase().contains('active') ||
                  state.toLowerCase().contains('payment') ||
                  state.toLowerCase().contains('progress') ||
                  state.toLowerCase().contains('pending') ||
                  state.toLowerCase() == 'paid' ||
                  state.toLowerCase() == 'draft',
              'monthYear': item['month_year'] ?? 'Recent',
              'extra_amount': item['extra_amount'] ?? 0.0,
              'location': item['location'] ?? '',
              'vehicle_type': item['vehicle_type'] ?? '',
              'vehicle': item['vehicle'] ?? '',
            };
          }).toList();

          // Avoid duplicates by checking ID
          for (var newItem in newItems) {
            bool exists = bookingHistory.any(
              (element) => element['id'] == newItem['id'],
            );
            if (!exists) {
              bookingHistory.add(newItem);
            }
          }

          historyOffset += historyData.length;
          hasMoreHistory = historyData.length >= limit;
        } else {
          hasMoreHistory = false;
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      hasMoreHistory = false;
    } catch (e) {
      debugPrint('Error fetching parking history: $e');
      hasMoreHistory = false;
    } finally {
      isLoadingHistory = false;
      isHistoryLoadingMore = false;
      update();
    }
  }

  Future<void> loadMoreParkingHistory() async {
    await fetchParkingHistory(reset: false);
  }

  Future<void> loadMoreVehicles({bool reset = false}) async {
    if (isVehicleLoading) return;
    if (reset) {
      vehicleOffset = 0;
      hasMoreVehicles = true;
    }
    if (!hasMoreVehicles) return;
    isVehicleLoading = true;
    update();

    try {
      final storage = GetStorage();
      final token = storage.read('token');
      if (token == null || token.toString().isEmpty || token == "null") {
        isVehicleLoading = false;
        return;
      }

      final dio = BaseClient.dio;

      debugPrint('\n--- API REQUEST (more_vehicles) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Query: {offset: $vehicleOffset, limit: $limit}');
      debugPrint('Headers: {"Authorization": "Bearer $token"}');

      final response = await dio.get(
        ApiConstants.vehicles,
        queryParameters: {'offset': vehicleOffset, 'limit': limit},
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      debugPrint('--- API RESPONSE (more_vehicles) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          if (reset) allVehicles.clear();
          final List vData = response.data['data']['vehicles'] ?? [];
          final newVehicles = vData.map((v) {
            String? imageVal = v['vehicle_image']?.toString();
            return {
              'title': v['vehicle_type_name'] ?? 'Vehicle',
              'license': v['license_number'] ?? '',
              'isParked': false,
              'spot': '',
              'image':
                  (imageVal != null &&
                      imageVal.isNotEmpty &&
                      imageVal != "false")
                  ? imageVal
                  : 'lib/assets/images/Airstream.png',
            };
          }).toList();

          // avoid duplicates by checking license
          for (var nv in newVehicles) {
            bool exists = allVehicles.any((v) => v['license'] == nv['license']);
            if (!exists) {
              allVehicles.add(nv);
            }
          }
          vehicleOffset += newVehicles.length;
          hasMoreVehicles = newVehicles.length >= limit;

          onSearchChanged(searchController.text); // Refresh filtered list
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      if (kDebugMode) print('Error loading more vehicles: $e');
    } finally {
      isVehicleLoading = false;
      update();
    }
  }

  Future<void> loadMoreActivities({bool reset = false}) async {
    if (isActivityLoading) return;
    if (reset) {
      activityOffset = 0;
      hasMoreActivities = true;
    }
    if (!hasMoreActivities) return;
    isActivityLoading = true;
    update();

    try {
      final storage = GetStorage();
      final token = storage.read('token');
      if (token == null || token.toString().isEmpty || token == "null") {
        isActivityLoading = false;
        return;
      }

      final dio = BaseClient.dio;

      debugPrint('\n--- API REQUEST (more_activities) ---');
      debugPrint('URL: ${ApiConstants.home}');
      debugPrint(
        'Query: {activity_offset: $activityOffset, activity_limit: $limit}',
      );
      debugPrint('Headers: {"Authorization": "Bearer $token"}');

      final response = await dio.get(
        ApiConstants.home,
        queryParameters: {
          'activity_offset': activityOffset,
          'activity_limit': limit,
        },
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      debugPrint('--- API RESPONSE (more_activities) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          if (reset) allActivities.clear();
          final activities =
              response.data['data']['recent_activities'] as List?;
          if (activities != null && activities.isNotEmpty) {
            final newActivities = activities.map<Map<String, dynamic>>((raw) {
              // Explicitly convert to avoid '_Map<String,dynamic>' subtype cast error
              final a = Map<String, dynamic>.from(raw as Map);

              final String state = a['state']?.toString().toLowerCase() ?? '';
              final double amount = (a['amount'] as num?)?.toDouble() ?? 0.0;
              final String startStr = a['booking_start']?.toString() ?? '';

              final bool isPayment =
                  amount > 0 || state.contains('payment') || state == 'paid';
              final String type = isPayment ? 'renew' : 'checkin';
              final String titleKey =
                  a['title_key'] ??
                  (isPayment ? 'parkingPayment' : 'vehicleCheckIn');

              // Format subtitle the same way as fetchHomeData
              String displaySub = startStr;
              try {
                if (startStr.isNotEmpty) {
                  final dt = DateTime.parse(startStr);
                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));
                  final activityDate = DateTime(dt.year, dt.month, dt.day);

                  String datePart;
                  if (activityDate == today) {
                    datePart = S.of(Get.context!).today;
                  } else if (activityDate == yesterday) {
                    datePart = S.of(Get.context!).yesterday;
                  } else {
                    datePart = DateFormat('MMM dd').format(dt);
                  }
                  displaySub = "$datePart, ${DateFormat('hh:mm a').format(dt)}";
                }
              } catch (_) {}

              if (amount > 0) {
                displaySub += ' AED $amount';
              } else if (a['location'] != null && a['location'] != "false") {
                displaySub += '-Spot ${a['location']}';
              }

              return <String, dynamic>{
                'titleKey': titleKey,
                'subtitle': displaySub,
                'icon': _getActivityIcon(type),
                'color': _getActivityColor(type),
              };
            }).toList();

            // avoid duplicates
            for (var na in newActivities) {
              bool exists = allActivities.any(
                (a) =>
                    a['subtitle'].toString() == na['subtitle'].toString() &&
                    a['titleKey'].toString() == na['titleKey'].toString(),
              );
              if (!exists) {
                allActivities.add(na);
              }
            }
            activityOffset += newActivities.length;
            hasMoreActivities = newActivities.length >= limit;

            onSearchChanged(searchController.text); // Refresh filtered list
          } else {
            hasMoreActivities = false;
          }
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      hasMoreActivities = false;
    } catch (e) {
      if (kDebugMode) print('Error loading more activities: $e');
      hasMoreActivities = false;
    } finally {
      isActivityLoading = false;
      update();
    }
  }

  void changeBottomNavIndex(int index) {
    if (currentIndex == index) return;
    currentIndex = index;
    if (index == 0) {
      Get.offAll(() => const HomeScreen());
    } else if (index == 1) {
      Get.offAll(() => const BookingHistoryView());
    } else if (index == 2) {
      Get.offAll(() => const AdditionalServicesScreen());
    } else if (index == 3) {
      Get.offAll(() => const ProfileView());
    }
    update();
  }

  List<Map<String, dynamic>> searchLocationsResults = [];

  void onSearchChanged(String value) {
    searchQuery = value.toLowerCase();

    if (searchQuery.isEmpty) {
      filteredVehicles = List.from(allVehicles);
      filteredActivities = List.from(allActivities);
      searchLocationsResults = []; // Clear search results when query is empty
    } else {
      // Search in vehicles
      filteredVehicles = allVehicles.where((v) {
        return v.values.any(
          (val) =>
              val != null && val.toString().toLowerCase().contains(searchQuery),
        );
      }).toList();

      // Search in activities
      filteredActivities = allActivities.where((a) {
        return a.values.any(
          (val) =>
              val != null && val.toString().toLowerCase().contains(searchQuery),
        );
      }).toList();

      // Additionally, search in userName and membership if they are properties of the controller
      // For example, if you have `String userName;` and `String membershipType;`
      // if (userName?.toLowerCase().contains(searchQuery) == true ||
      //     membershipType?.toLowerCase().contains(searchQuery) == true) {
      //   // Handle how you want to display this match, e.g., add a special item to a list
      // }
    }

    // Call the search API as requested
    searchLocations(value);

    update();
  }

  Future<void> searchLocations(
    String query, {
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final storage = GetStorage();
      final token = storage.read('token');
      if (token == null || token.toString().isEmpty || token == "null") {
        return;
      }

      final dio = BaseClient.dio;

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final queryParameters = {
        'query': query,
        'limit': limit,
        'offset': offset,
      };

      debugPrint('\n--- API REQUEST (search) ---');
      debugPrint('URL: ${ApiConstants.search}');
      debugPrint('Parameters: $queryParameters');

      final response = await dio.get(
        ApiConstants.search,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (search) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final data = response.data['data'];
          final locations = data['locations'] as List? ?? [];
          searchLocationsResults = locations
              .map((l) => Map<String, dynamic>.from(l))
              .toList();

          debugPrint(
            'Search results found: ${searchLocationsResults.length} locations',
          );
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      debugPrint('Error during search API call: $e');
    } finally {
      update(); // Ensure UI reflects arrival of API results
    }
  }

  // Helper to determine if a section should be visible based on search results

  void onNotificationClick() {
    Get.to(() => const NotificationsView());
  }

  void onProfileClick() {
    changeBottomNavIndex(3);
  }

  void onRenewClick() {
    if (kDebugMode) print("Renew Clicked");
  }

  void onBookParkingClick() {
    Get.to(() => const BookParkingScreen());
  }

  void onRequestServiceClick() {
    Get.to(() => const AdditionalServicesScreen());
  }

  void onBuyMembershipClick() {
    Get.to(() => const MembershipPlansScreen());
  }

  void onGetDirectionsClick() {
    Get.to(() => const SelectParkingView(isDirectionMode: true));
  }

  void onBookNowClick() {
    // Get bookingId if available from BookParkingController
    int? bId;
    try {
      final bookCtrl = Get.find<BookParkingController>();
      bId = bookCtrl.lastBookingId;
    } catch (_) {}

    Get.to(() => SelectParkingView(isDirectionMode: false, bookingId: bId));
  }

  void onCheckRewardsClick() {
    Get.to(() => const RewardsView());
  }

  void onViewAllVehiclesClick() {
    Get.to(() => const MyVehiclesView());
  }

  void onRegisterVehicleClick() {
    Get.to(() => const RegisterVehicleScreen());
  }

  void onViewAllActivityClick() {
    Get.to(() => const RecentActivityView());
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
