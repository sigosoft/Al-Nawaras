import 'package:flutter/material.dart';
import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:al_nawaras/view/book_parking/slot_selection_screen.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import 'base_client.dart';

class BookParkingController extends GetxController {
  bool isLoadingVehicles = false;
  bool isLoadingMemberships = false;
  bool isLoadingParkingTypes = false;
  bool isLoadingServices = false;
  bool isBooking = false;
  List<Map<String, dynamic>> vehiclesList = [];
  Map<String, dynamic>? selectedVehicleData;

  int? lastBookingId; // Stores the booking_id returned from parking/book API
  double? lastBookingTotal; // Stores the total_amount from booking response

  String selectedParkingType = 'Shaded'; // Initial UI selection
  String selectedMembership = 'Hourly';

  // --- Dynamic Slot Availability State ---
  bool isLoadingSummary = false;
  bool isLoadingAvailability = false;
  List<Map<String, dynamic>> availableSummaryList = [];
  List<Map<String, dynamic>> availableSlotsList = [];
  int? selectedSlotId;
  String? selectedSlotName; // e.g. "Slot A-101"
  int? selectedSlotTypeId;
  String? selectedSlotTypeName;

  // Maps UI display values (Shaded/Non-Shaded) to API Location IDs.
  final Map<String, int> locationIdMap = {
    'shaded': 1,
    'unshaded': 2,
    'non-shaded': 2,
    'non shaded': 2,
  };

  // Maps UI display values to API IDs.
  // Populated dynamically from /parking/types API.
  final Map<String, int> parkingTypeIdMap = {};

  // Populated from /memberships API: key = plan title, value = plan id
  final Map<String, int> membershipIdMap = {};

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
    fetchMemberships();
    fetchParkingTypes();
    fetchServices();
  }

  Future<void> fetchVehicles() async {
    isLoadingVehicles = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (vehicles) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.vehicles,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (vehicles) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List vData = response.data['data']['vehicles'] ?? [];
          vehiclesList = vData.map((e) => e as Map<String, dynamic>).toList();

          if (vehiclesList.isNotEmpty) {
            selectedVehicleData = vehiclesList[0];
          }
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching vehicles: $e');
    } finally {
      isLoadingVehicles = false;
      if (!isClosed) update();
    }
  }

  void setSelectedVehicle(Map<String, dynamic> vehicle) {
    selectedVehicleData = vehicle;
    if (!isClosed) update();
  }

  String getVehicleImage(String? typeName) {
    // Mapping based on common names or defaults
    return 'lib/assets/images/Airstream.png';
  }

  // Populated from /parking/types
  List<Map<String, dynamic>> dynamicParkingTypes = [];

  Future<void> fetchParkingTypes() async {
    isLoadingParkingTypes = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (parking types) ---');
      debugPrint('URL: ${ApiConstants.parkingTypes}');

      final response = await dio.get(
        ApiConstants.parkingTypes,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking types) ---');
      debugPrint('Status Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.data}'); // Optional debug

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List<dynamic> pTypes = response.data['data'] ?? [];

        dynamicParkingTypes = [];
        parkingTypeIdMap.clear();

        for (final p in pTypes) {
          final id = p['id'] as int?;
          final name = p['name']?.toString() ?? 'Parking Plan';

          dynamicParkingTypes.add(p as Map<String, dynamic>);
          if (id != null) parkingTypeIdMap[name] = id;
        }

        if (dynamicParkingTypes.isNotEmpty) {
          selectedParkingType = dynamicParkingTypes.first['name'] ?? '';
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching parking types: $e');
    } finally {
      isLoadingParkingTypes = false;
      if (!isClosed) update();
    }
  }

  AssetImage getParkingTypeImage(String typeName) {
    final lower = typeName.toLowerCase();

    // Existing typical ones
    if (lower.contains('unshaded')) {
      return const AssetImage("lib/assets/images/unshaded.png");
    } else if (lower.contains('shaded')) {
      return const AssetImage("lib/assets/images/shaded.png");
    } else if (lower.contains('air conditioned')) {
      return const AssetImage("lib/assets/images/air conditioned.png");
    }

    // Dynamic vehicle-oriented ones
    if (lower.contains('jet ski') || lower.contains('jetski')) {
      return const AssetImage("lib/assets/images/jet ski.png");
    } else if (lower.contains('truck')) {
      return const AssetImage("lib/assets/images/food truck.png");
    } else if (lower.contains('boat')) {
      return const AssetImage("lib/assets/images/boat.png");
    } else if (lower.contains('caravan')) {
      return const AssetImage("lib/assets/images/caravan.png");
    }

    // Generic fallback
    return const AssetImage("lib/assets/images/shaded.png");
  }

  // Populated dynamically from /memberships API
  List<Map<String, String>> membershipPackages = [];

  Future<void> fetchMemberships() async {
    isLoadingMemberships = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (memberships - book parking) ---');
      debugPrint('URL: ${ApiConstants.memberships}');

      final response = await dio.get(
        ApiConstants.memberships,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (memberships - book parking) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List<dynamic> memberships =
            response.data['data']['memberships'] ?? [];

        membershipPackages = [];
        membershipIdMap.clear();

        for (final m in memberships) {
          final title = m['plan_type']?.toString() ?? 'Standard Plan';
          final rawPrice = m['plan_price']?.toString() ?? '0';
          final rawDuration =
              (m['duration'] == null ||
                  m['duration'] == false ||
                  m['duration'] == 'false')
              ? 'unit'
              : m['duration'].toString();

          final id = m['id'] as int?;

          // Manual Price Overrides as requested
          String finalPrice = 'AED $rawPrice/$rawDuration';
          final lowerTitle = title.toLowerCase();

          if (lowerTitle.contains('hourly')) {
            finalPrice = 'AED 20/hour';
          } else if (lowerTitle.contains('monthly')) {
            finalPrice = 'AED 1,000/month';
          } else if (lowerTitle.contains('yearly') ||
              lowerTitle.contains('annual')) {
            finalPrice = 'AED 6,000/year';
          }

          // Filter out 'Daily' as requested
          if (lowerTitle != 'daily') {
            membershipPackages.add({'title': title, 'price': finalPrice});
            if (id != null) membershipIdMap[title] = id;
          }
        }

        // Auto-select the first membership if available
        if (membershipPackages.isNotEmpty) {
          selectedMembership = membershipPackages.first['title']!;
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching memberships for book parking: $e');
    } finally {
      isLoadingMemberships = false;
      if (!isClosed) update();
    }
  }

  void setSelectedMembership(String title) {
    selectedMembership = title;
    _updateEndDateBasedOnMembership();
    if (!isClosed) update();
    // After changing membership, we might want to re-check availability
    // or recalculate summary if prices are dependent on plan.
    fetchAvailableSummary();
  }

  /// Calculates the end date and time automatically based on the selected membership.
  void _updateEndDateBasedOnMembership() {
    // 1. Get the start date/time
    final start = _combineDateAndTime(
      dateController.text,
      selectedStartTime,
      DateTime.now(),
    );

    DateTime end;
    final lowerTitle = selectedMembership.toLowerCase();

    // 2. Map titles to durations
    if (lowerTitle.contains('hourly')) {
      end = start.add(const Duration(hours: 1));
    } else if (lowerTitle.contains('daily')) {
      end = start.add(const Duration(days: 1));
    } else if (lowerTitle.contains('weekly')) {
      end = start.add(const Duration(days: 7));
    } else if (lowerTitle.contains('monthly')) {
      // Use 30 days as a standard Odoo month or actual month?
      // Most Odoo billing uses 30 days for pro-rating, so we use 30 to be safe.
      end = start.add(const Duration(days: 30));
    } else if (lowerTitle.contains('3 month')) {
      end = start.add(const Duration(days: 90));
    } else if (lowerTitle.contains('6 month')) {
      end = start.add(const Duration(days: 180));
    } else if (lowerTitle.contains('yearly') || lowerTitle.contains('annual')) {
      end = start.add(const Duration(days: 365));
    } else {
      // Default fallback
      end = start.add(const Duration(hours: 2));
    }

    // 3. Update controllers and state
    endDateController.text = "${end.day}/${end.month}/${end.year}";
    selectedEndTime = TimeOfDay(hour: end.hour, minute: end.minute);
    endTimeController.text = selectedEndTime!.format(Get.context!);

    if (!isClosed) update();
  }

  // Populated dynamically from /services API
  List<Map<String, dynamic>> addonServices = [];

  Future<void> fetchServices() async {
    isLoadingServices = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (services - book parking) ---');
      debugPrint('URL: ${ApiConstants.services}');

      final response = await dio.get(
        ApiConstants.services,
        options: Options(
          headers: headers,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      debugPrint('--- API RESPONSE (services - book parking) ---');
      debugPrint('Status Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.data}'); // Optional debug

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final rawData = response.data['data'];
        List<dynamic> servicesList = [];
        if (rawData is List) {
          servicesList = rawData;
        } else if (rawData is Map && rawData['services'] != null) {
          servicesList = rawData['services'] as List<dynamic>;
        }

        addonServices = [];

        for (final s in servicesList) {
          final title =
              s['name']?.toString() ?? s['title']?.toString() ?? 'Service';
          final priceVal = s['price'] ?? 0;
          final subtitle =
              s['subtitle']?.toString() ??
              s['description']?.toString() ??
              'Additional service';
          addonServices.add({
            'title': title,
            'price': 'AED $priceVal',
            'subtitle': subtitle,
            'icon': getServiceImage(title),
            'isSelected': false,
            'id': s['id'],
          });
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching services for book parking: $e');
    } finally {
      isLoadingServices = false;
      if (!isClosed) update();
    }
  }

  String getServiceImage(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('battery')) {
      return 'lib/assets/images/battery.png';
    }
    if (lower.contains('oil')) {
      return 'lib/assets/images/oil charge.png';
    }
    if (lower.contains('tire')) {
      return 'lib/assets/images/tire change.png';
    }
    if (lower.contains('wash') || lower.contains('clean')) {
      return 'lib/assets/images/cleaning.png';
    }
    if (lower.contains('towing')) {
      return 'lib/assets/images/trolly.png';
    }
    if (lower.contains('vehicle pickup')) {
      return 'lib/assets/images/vehicle pickup.png';
    }
    if (lower.contains('customer pickup')) {
      return 'lib/assets/images/customer pickup.png';
    }
    return 'lib/assets/images/battery.png'; // default fallback
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  bool get isDateTimeSelected =>
      dateController.text.isNotEmpty &&
      timeController.text.isNotEmpty &&
      endDateController.text.isNotEmpty &&
      endTimeController.text.isNotEmpty;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      _updateEndDateBasedOnMembership();
      _checkAndFetchSummary();
      if (!isClosed) update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedStartTime = picked;
      if (!isClosed) timeController.text = picked.format(context);
      _updateEndDateBasedOnMembership();
      _checkAndFetchSummary();
      if (!isClosed) update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      endDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      _checkAndFetchSummary();
      if (!isClosed) update();
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedEndTime = picked;
      if (!isClosed) endTimeController.text = picked.format(context);
      _checkAndFetchSummary();
      if (!isClosed) update();
    }
  }

  /// Checks if all date/time fields are filled and triggers summary API
  void _checkAndFetchSummary() {
    if (dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        endDateController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty) {
      fetchAvailableSummary();
    }
  }

  Future<void> fetchAvailableSummary() async {
    isLoadingSummary = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final start = _combineDateAndTime(
        dateController.text,
        selectedStartTime,
        DateTime.now(),
      );
      final end = _combineDateAndTime(
        endDateController.text,
        selectedEndTime,
        start.add(const Duration(hours: 2)),
      );

      String format(DateTime dt) =>
          "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";

      final body = {
        "booking_start_date": format(start.toUtc()),
        "booking_end_date": format(end.toUtc()),
        // Aggregated counts for all locations as per user definition
      };

      debugPrint('\n--- API REQUEST (available_summary) ---');
      debugPrint('URL: ${ApiConstants.availableSummary}');
      debugPrint('Body: $body');

      final response = await dio.post(
        ApiConstants.availableSummary,
        data: body,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (available_summary) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint(
        'Full Response Data: ${response.data}',
      ); // Detailed debug to find hidden rates

      if (response.statusCode == 200 &&
          response.data != null &&
          (response.data['status'] == 200 || response.data['status'] == true)) {
        final List data = response.data['data'] ?? [];
        availableSummaryList = data
            .map((e) => e as Map<String, dynamic>)
            .toList();
      } else {
        String msg =
            response.data?['message'] ?? 'Unable to fetch availability';
        Get.snackbar(
          'Notice',
          msg,
          backgroundColor: Colors.orangeAccent,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      debugPrint('Error fetching available summary: $e');
    } finally {
      isLoadingSummary = false;
      if (!isClosed) update();
    }
  }

  Future<void> checkSlotAvailability(
    int slotTypeId,
    String typeName,
    int locationId,
  ) async {
    isLoadingAvailability = true;
    selectedSlotTypeId = slotTypeId;
    selectedSlotTypeName = typeName;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final start = _combineDateAndTime(
        dateController.text,
        selectedStartTime,
        DateTime.now(),
      );
      final end = _combineDateAndTime(
        endDateController.text,
        selectedEndTime,
        start.add(const Duration(hours: 2)),
      );

      String format(DateTime dt) =>
          "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";

      final body = {
        "location_id": locationId,
        "slot_type_id": slotTypeId,
        "booking_start_date": format(start.toUtc()),
        "booking_end_date": format(end.toUtc()),
      };

      debugPrint('\n--- API REQUEST (check_availability) ---');
      debugPrint('URL: ${ApiConstants.checkAvailability}');
      debugPrint('Body: $body');

      final response = await dio.post(
        ApiConstants.checkAvailability,
        data: body,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (check_availability) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          (response.data['status'] == 200 || response.data['status'] == true)) {
        final dynamic rawData = response.data['data'];

        // Handle empty object or list
        if (rawData == null ||
            (rawData is Map && rawData.isEmpty) ||
            (rawData is List && rawData.isEmpty)) {
          Get.snackbar(
            'No Slots Available',
            'No units available for the selected ${selectedMembership.toLowerCase()} duration. Try another date or parking type.',
            backgroundColor: Colors.orangeAccent,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
          );
          availableSlotsList = [];
          return;
        }

        final List data = (rawData is List) ? rawData : [];
        availableSlotsList = data
            .map((e) => e as Map<String, dynamic>)
            .toList();

        // Navigate to SlotSelectionScreen
        Get.to(() => const SlotSelectionScreen());
      } else {
        String msg =
            response.data?['message'] ?? 'Unable to check slot availability';
        Get.snackbar(
          'Notice',
          msg,
          backgroundColor: Colors.orangeAccent,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
    } catch (e) {
      debugPrint('Error checking availability: $e');
    } finally {
      isLoadingAvailability = false;
      if (!isClosed) update();
    }
  }

  void selectSlot(int id, String name) {
    selectedSlotId = id;
    selectedSlotName = name;
    if (!isClosed) update();
  }

  void setParkingType(String type) {
    selectedParkingType = type;
    _checkAndFetchSummary();
    if (!isClosed) update();
  }

  void setMembership(String membership) {
    selectedMembership = membership;
    if (!isClosed) update();
  }

  void toggleAddon(int index) {
    addonServices[index]['isSelected'] = !addonServices[index]['isSelected'];
    if (!isClosed) update();
  }

  /// Returns the total price as a formatted string based on:
  ///  - the selected membership package price
  ///  - the prices of all selected add-on services
  String get calculatedTotal {
    // ABSOLUTE SOURCE OF TRUTH: If the backend has already calculated a real price for this
    // specific combination (e.g. 960.00), we must use it instantly to avoid discrepancies.
    if (lastBookingTotal != null && lastBookingTotal! > 0) {
      return 'AED ${lastBookingTotal!.toStringAsFixed(2)}';
    }

    double total = 0.0;

    // 1. Try to fetch the specific price for the selected slot type from the backend's availableSummaryList
    if (selectedSlotTypeId != null && availableSummaryList.isNotEmpty) {
      final summaryEntry = availableSummaryList.firstWhere(
        (st) => st['slot_type_id'] == selectedSlotTypeId,
        orElse: () => {},
      );

      if (summaryEntry.isNotEmpty) {
        // PRIORITY: Only use total-based fields. Avoid "rate" or "price" as they are unit costs (e.g. 10/hr).
        final backendPrice =
            summaryEntry['total_price'] ??
            summaryEntry['total'] ??
            summaryEntry['amount'];

        if (backendPrice != null) {
          final parsed = _parsePrice(backendPrice.toString());
          if (parsed > 0) {
            total = parsed;
            debugPrint(
              '--- [DEBUG] Total Amount (API Summary): $total (key found) ---',
            );
            return _formatTotalWithAddons(total);
          }
        }
      }
    }

    // 2. Fallback: Manual estimation removed per user request: "do not calculate the amount manually"
    return _formatTotalWithAddons(total);
  }

  /// Returns true if the calculated total is greater than 0
  bool get isCalculatedTotalAvailable {
    final amt = calculatedTotal.replaceAll(RegExp(r'[^0-9.]'), '');
    final val = double.tryParse(amt) ?? 0.0;
    return val > 0;
  }

  /// Appends addon service prices and formats the final string
  String _formatTotalWithAddons(double baseTotal) {
    double total = baseTotal;
    for (final addon in addonServices) {
      if (addon['isSelected'] == true) {
        total += _parsePrice(addon['price']?.toString() ?? '0');
      }
    }
    return 'AED ${total.toStringAsFixed(2)}';
  }

  /// Extracts the first numeric value from a price string.
  /// e.g. "AED 1500/month" → 1500.0,  "AED 150" → 150.0
  double _parsePrice(String priceStr) {
    final match = RegExp(r'[\d]+\.?[\d]*').firstMatch(priceStr);
    if (match != null) {
      return double.tryParse(match.group(0)!) ?? 0.0;
    }
    return 0.0;
  }

  Future<void> onNextClick() async {
    // --- START VALIDATION ---
    if (selectedVehicleData == null) {
      Get.snackbar(
        'Selection Required',
        'Please select a vehicle before proceeding.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        endDateController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      Get.snackbar(
        'Selection Required',
        'Please select both start and end date/time.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedSlotId == null) {
      Get.snackbar(
        'Selection Required',
        'Please select a parking slot from the available types.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // --- END VALIDATION ---

    isBooking = true;
    if (!isClosed) update();

    int? bookingId;
    double? bookingTotal;

    // Step 1: Call parking/book API
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Build ISO 8601 date strings for start/end
      final now = DateTime.now();
      final startDate = _combineDateAndTime(
        dateController.text,
        selectedStartTime,
        now,
      );
      final endDate = _combineDateAndTime(
        endDateController.text,
        selectedEndTime,
        startDate.add(const Duration(hours: 2)),
      );

      // Validate Duration
      if (!endDate.isAfter(startDate)) {
        Get.snackbar(
          'Invalid Duration',
          'End time must be after the start time',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        isBooking = false;
        if (!isClosed) update();
        return;
      }
      if (selectedSlotTypeId == null) {
        Get.snackbar(
          'Selection Required',
          'Please select an available Slot Type first',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        isBooking = false;
        if (!isClosed) update();
        return;
      }

      final vehicleId = selectedVehicleData?['id'];
      final currentLocationId = locationIdMap[selectedParkingType] ?? 2;
      final membershipPackageId = membershipIdMap[selectedMembership] ?? 1;

      String format(DateTime dt) =>
          "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} "
          "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:00";

      final requestBody = {
        "vehicle_id": vehicleId,
        "location_id": currentLocationId,
        "parking_type_id": selectedSlotTypeId, // Missing required parameter
        "membership_package_id": membershipPackageId,
        "booking_start_date": format(startDate.toUtc()),
        "booking_end_date": format(endDate.toUtc()),
        if (selectedSlotId != null) "slot_id": selectedSlotId,
      };

      debugPrint('\n--- API REQUEST (parking/book) ---');
      debugPrint('URL: ${ApiConstants.parkingBook}');
      debugPrint('Body: $requestBody');

      final bookResponse = await dio.post(
        ApiConstants.parkingBook,
        data: requestBody,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking/book) ---');
      debugPrint('Status Code: ${bookResponse.statusCode}');
      debugPrint('Response Body: ${bookResponse.data}');

      if ((bookResponse.statusCode == 200 || bookResponse.statusCode == 201) &&
          bookResponse.data != null) {
        final bookData = bookResponse.data['data'];
        if (bookData != null) {
          bookingId = bookData['booking_id'];
          bookingTotal = (bookData['total_amount'] as num?)?.toDouble();
          lastBookingId = bookingId;
          lastBookingTotal = bookingTotal;

          // AUTO-CONFIRM: If the booking is in 'draft', we must confirm it to generate the invoice.
          // This moves the state to 'pending_payment' as required by payment/confirm.
          if ((bookData['state'] == 'draft' ||
                  bookData['state'] == 'pending_payment') &&
              selectedSlotName != null) {
            final confirmed = await confirmBookingLocation(
              bookingId!,
              selectedSlotName!,
              selectedSlotId,
            );
            if (!confirmed) {
              Get.snackbar(
                'Slot Not Found',
                'The selected slot could not be found or confirmed. Please try another selection.',
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
              isBooking = false;
              if (!isClosed) update();
              return; // STOP: Do not go to payment if confirmation failed
            }
          }

          // Refresh availability and reset selection for any future booking
          selectedSlotId = null;
          selectedSlotName = null;
          fetchAvailableSummary();
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error calling parking/book: $e');

      isBooking = false;
      if (!isClosed) update();
      return;
    } catch (e) {
      debugPrint('Unexpected error in booking: $e');
      isBooking = false;
      if (!isClosed) update();
      return; // STOP HERE on error
    }

    // Step 2: Fetch payment/summary and navigate to PaymentView
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Use the real booking_id if available, else fallback to 1
      final summaryBookingId = bookingId ?? 1;

      debugPrint('\n--- API REQUEST (payment/summary) ---');
      debugPrint(
        'URL: ${ApiConstants.paymentSummary}?booking_id=$summaryBookingId',
      );

      final response = await dio.get(
        ApiConstants.paymentSummary,
        queryParameters: {'booking_id': summaryBookingId},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (payment/summary) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final data = response.data['data'] ?? {};
        final apiSubtotal = data['subtotal']?.toString() ?? '0.00';
        final apiVat = data['vat']?.toString() ?? '0.00';
        final apiTotal = data['total']?.toString() ?? '0.00';

        final apiCurrency =
            (data['currency'] == null ||
                data['currency'] == false ||
                data['currency'] == 'false')
            ? 'AED'
            : data['currency'].toString();

        final displayTotal = "$apiCurrency $apiTotal";

        // Step 3: Clear stale slot selection data
        availableSlotsList = [];
        selectedSlotId = null;
        selectedSlotName = null;
        if (!isClosed) update();

        Get.off(
          () => PaymentView(
            bookingId: bookingId,
            title: 'Booking Payment',
            subtitle:
                '${data['parking_type']?.toString() ?? selectedParkingType} Parking',
            amount: displayTotal,
            subtotal: "$apiCurrency $apiSubtotal",
            vat: "$apiCurrency $apiVat",
            total: displayTotal,
            details: [
              {
                'label': 'Membership Type',
                'value':
                    data['membership_type']?.toString() ?? selectedMembership,
              },
              {
                'label': 'Parking Type',
                'value':
                    data['parking_type']?.toString() ?? selectedParkingType,
              },
              {
                'label': 'Vehicle',
                'value': data['vehicle']?.toString() ?? 'N/A',
              },
              {
                'label': 'Start Date',
                'value': data['start_date']?.toString() ?? 'N/A',
              },
              {
                'label': 'End Date',
                'value': data['end_date']?.toString() ?? 'N/A',
              },
              {
                'label': 'Duration',
                'value': data['duration']?.toString() ?? 'N/A',
              },
            ],
          ),
        );
      } else {
        _navigateToDefaultPayment(bookingId: bookingId);
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching payment summary: $e');
      _navigateToDefaultPayment(bookingId: bookingId);
    } catch (e) {}
  }

  /// Combines a date string (dd/mm/yyyy) and a TimeOfDay into a DateTime object.
  DateTime _combineDateAndTime(
    String dateStr,
    TimeOfDay? time,
    DateTime fallback,
  ) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final year = int.parse(parts[2]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[0]);

        final hour = time?.hour ?? 0;
        final minute = time?.minute ?? 0;

        return DateTime(year, month, day, hour, minute);
      }
    } catch (_) {}
    return fallback;
  }

  void _navigateToDefaultPayment({int? bookingId}) {
    Get.to(
      () => PaymentView(
        bookingId: bookingId,
        title: 'Booking Payment',
        subtitle: '$selectedParkingType Parking',
        amount: calculatedTotal,
        subtotal: calculatedTotal,
        vat: 'AED 0.00',
        total: calculatedTotal,
        details: [
          {
            'label': 'Vehicle',
            'value': selectedVehicleData?['vehicle_type_name'] ?? 'N/A',
          },
          {'label': 'Membership', 'value': selectedMembership},
          {'label': 'Type', 'value': selectedParkingType},
          {
            'label': 'Start Date',
            'value': "${dateController.text} ${timeController.text}",
          },
          {
            'label': 'End Date',
            'value': "${endDateController.text} ${endTimeController.text}",
          },
        ],
      ),
    );
  }

  /// Shows a snackbar when an unavailable item (slot type or specific slot) is selected.
  void handleUnavailableSelection({String? message}) {
    Get.snackbar(
      'Slot Unavailable',
      message ?? 'This selection is currently full or already booked.',
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.info_outline, color: Colors.white),
    );
  }

  @override
  void onClose() {
    // Rely on GetX lifecycle for cleanup to avoid "used after disposed" errors
    super.onClose();
  }

  Future<bool> confirmBookingLocation(int bId, String sName, int? sId) async {
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': '*/*',
      };
      final body = {
        'booking_id': bId,
        'slot_id': sId,
        'slot_name': sName,
        'slot_number': sName,
      };
      debugPrint('\n--- API REQUEST (confirm_location - auto) ---');
      debugPrint('URL: ${ApiConstants.confirmLocation}');
      debugPrint('Body: $body');

      final resp = await dio.post(
        ApiConstants.confirmLocation,
        data: body,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (confirm_location - auto) ---');
      debugPrint('Status Code: ${resp.statusCode}');
      debugPrint('Response Data: ${resp.data}');

      final isSuccess =
          resp.statusCode == 200 &&
          resp.data != null &&
          (resp.data['status'] == 200 || resp.data['status'] == true);

      // DIAGNOSTIC SNACKBAR
      // Get.snackbar(
      //   'Slot Confirmation Status',
      //   'Result: $isSuccess\nMessage: ${resp.data?['message'] ?? 'No message'}\nSlot: $sName (ID: $sId)',
      //   backgroundColor: isSuccess ? Colors.green : Colors.red,
      //   colorText: Colors.white,
      //   duration: const Duration(seconds: 4),
      //   snackPosition: SnackPosition.TOP,
      // );

      if (isSuccess) {
        debugPrint('Slot confirmation SUCCESS: $sName');
        return true;
      }

      debugPrint(
        'Slot confirmation FAILED: ${resp.data?['message'] ?? 'Check server logs'}',
      );
      return false;
    } catch (e) {
      debugPrint('Auto-confirm failed with exception: $e');
      Get.snackbar(
        'Slot Not Found',
        'An error occurred while confirming the slot. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
}
