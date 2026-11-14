import 'dart:math' as math;

import 'package:al_nawaras/view/book_parking/book_parking_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/api_constants.dart';
import '../../controller/base_client.dart';
import '../../controller/book_parking_controller.dart';
import '../../generated/l10n.dart';
import '../../utils/slot_size_utils.dart';
import '../../utils/api_labels.dart';
import 'parking_map.dart';

/// Design tokens from the XD "Select Parking Location" screen.
class _Design {
  static const Color red = Color(0xFFE50018);
  static const Color background = Color(0xFFF5F5F5);
  static const double headerHeight = 71;
}

class SelectParkingView extends StatefulWidget {
  final bool isDirectionMode;
  final int? bookingId;
  const SelectParkingView({
    super.key,
    this.isDirectionMode = false,
    this.bookingId,
  });

  @override
  State<SelectParkingView> createState() => _SelectParkingViewState();
}

class _SelectParkingViewState extends State<SelectParkingView> {
  final ParkingMapLayout _map = ParkingMapLayout.instance;

  /// Map slot id, e.g. "FT17-12". Empty when nothing is selected.
  String selectedSlotCode = "";

  /// Backend slot name, e.g. "C12 - FOOD TRUCK".
  String selectedSlotNumber = "";
  String selectedLocationCode = "";
  String selectedLocation = "";
  String selectedLocationType = "";
  String selectedSlotSize = "";
  bool isLoadingData = false;
  bool noActiveBooking = false; // direction mode: user has no booking to show

  Set<String> bookedSlots = {};
  Set<String> shadedSlots = {};
  Map<String, dynamic>? lookupVehicle;
  String _activeBookingVehicle = ""; // e.g. "55555 (2023)" from history
  String initialConfirmedSlot = "";

  final TransformationController _transformationController =
      TransformationController();
  Size? _viewport;

  /// Horizontal scroll position of the map in the design (design px).
  static const double _designScrollX = 171;

  @override
  void initState() {
    super.initState();
    shadedSlots = {
      for (final s in _map.slots)
        if (s.shadedInDesign) s.id,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // In direction mode the backend booking is the source of truth; a
      // locally saved selection would highlight a slot the user never booked.
      if (!widget.isDirectionMode) _loadSavedSlot();
      _applyGloballyConfirmedSlots();
      if (widget.isDirectionMode) {
        _fetchDynamicParkingDetails();
      } else {
        _fetchVehicleTypes();
        _fetchParkingHistory();
      }
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Slot state helpers
  // ---------------------------------------------------------------------------

  /// Accepts either a map id ("FT17-12") or a backend name ("C12 - FOOD TRUCK").
  MapSlot? _resolve(String code) {
    if (code.isEmpty) return null;
    return _map.byId(code) ?? _map.resolveBackendName(code);
  }

  void _markBooked(String code) {
    final slot = _resolve(code);
    if (slot != null) bookedSlots = {...bookedSlots, slot.id};
  }

  void _applyGloballyConfirmedSlots() {
    final List<dynamic>? globalConfirmed = GetStorage().read(
      'user_confirmed_parking_slots',
    );
    if (globalConfirmed == null) return;
    setState(() {
      for (final code in globalConfirmed) {
        _markBooked(code.toString());
      }
    });
  }

  void _loadSavedSlot() {
    final storage = GetStorage();
    final key = 'selected_parking_slot_${widget.bookingId ?? "none"}';
    final saved = storage.read(key);
    if (saved is! Map) return;
    // Selections saved by the old map layout use other ids; drop those.
    final slot = _resolve((saved['code'] ?? "").toString());
    if (slot == null) return;
    setState(() {
      selectedSlotCode = slot.id;
      selectedSlotNumber = slot.backendName;
      selectedLocationCode = (saved['locationCode'] ?? "").toString();
      selectedLocation = (saved['location'] ?? "").toString();
      selectedLocationType = (saved['locationType'] ?? "").toString();
      selectedSlotSize = (saved['size'] ?? "").toString();
    });
  }

  void _saveSelectedSlot() {
    final key = 'selected_parking_slot_${widget.bookingId ?? "none"}';
    GetStorage().write(key, {
      'code': selectedSlotCode,
      'number': selectedSlotNumber,
      'locationCode': selectedLocationCode,
      'location': selectedLocation,
      'locationType': selectedLocationType,
      'size': selectedSlotSize,
    });
  }

  Map<String, dynamic> _headers() {
    final token = GetStorage().read('token');
    return {
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  // ---------------------------------------------------------------------------
  // API
  // ---------------------------------------------------------------------------

  Future<void> _fetchVehicleTypes() async {
    try {
      setState(() => isLoadingData = true);
      final response = await BaseClient.dio.get(
        ApiConstants.vehicleTypes,
        options: Options(headers: _headers()),
      );
      debugPrint('--- API RESPONSE (vehicle_types) ---');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List types = response.data['data'] as List? ?? [];
        if (types.isNotEmpty) _fetchDynamicParkingDetails();
      }
    } catch (e) {
      debugPrint('Error fetching vehicle types: $e');
    } finally {
      if (mounted) setState(() => isLoadingData = false);
    }
  }

  /// Looks up the booked vehicle via the documented
  /// `GET /api/vehicles/lookup?license_number=...`.
  Future<void> _lookupVehicle(String licenseNumber) async {
    if (licenseNumber.isEmpty) return;
    try {
      final response = await BaseClient.dio.get(
        ApiConstants.vehicleLookup,
        queryParameters: {'license_number': licenseNumber},
        options: Options(headers: _headers()),
      );
      final data = response.data is Map ? response.data['data'] : null;
      if (response.statusCode == 200 &&
          response.data['status'] == true &&
          data is Map &&
          data.isNotEmpty &&
          mounted) {
        setState(() => lookupVehicle = Map<String, dynamic>.from(data));
      }
    } catch (e) {
      // 404 "Vehicle not found" lands here; the vehicle row is just hidden.
      debugPrint('Error looking up vehicle: $e');
    }
  }

  Future<void> _fetchDynamicParkingDetails() async {
    try {
      setState(() => isLoadingData = true);
      final dio = BaseClient.dio;
      final headers = _headers();

      // Never fall back to a fixed booking id: booking_id=1 belongs to
      // another customer. In direction mode, use the user's own active
      // booking from their history; otherwise there is nothing to load.
      int? bookingId = widget.bookingId;
      if (bookingId == null && widget.isDirectionMode) {
        bookingId = await _findActiveBookingId(headers, dio);
        // History gives the vehicle as "<plate> (<model>)"; look up the plate.
        _lookupVehicle(_activeBookingVehicle.split(' (').first.trim());
      }
      if (bookingId == null) {
        if (mounted && widget.isDirectionMode) {
          setState(() {
            noActiveBooking = true;
            selectedSlotCode = "";
            selectedSlotNumber = "";
          });
        }
        return;
      }

      final locationResponse = await dio.get(
        ApiConstants.locationDetails,
        queryParameters: {'booking_id': bookingId},
        options: Options(headers: headers),
      );
      debugPrint('--- API RESPONSE (location_details) ---');
      debugPrint('Response Data: ${locationResponse.data}');

      if (locationResponse.statusCode == 200 &&
          locationResponse.data != null &&
          locationResponse.data['status'] == true) {
        final data = locationResponse.data['data'];
        if (data != null &&
            data['slot_number'] != null &&
            data['slot_number'].toString().isNotEmpty &&
            data['slot_number'].toString() != "false") {
          await _fetchSlotDetails(data['slot_number'].toString(), headers, dio);
          return;
        }
      }

      // If we reach here in direction mode, no valid booking was found.
      if (mounted && widget.isDirectionMode) {
        setState(() {
          noActiveBooking = true;
          selectedSlotCode = "";
          selectedSlotNumber = "";
        });
      }
    } catch (e) {
      debugPrint('Error fetching parking details: $e');
      if (mounted && widget.isDirectionMode) {
        setState(() => selectedSlotCode = "");
      }
    } finally {
      if (mounted) setState(() => isLoadingData = false);
    }
  }

  /// Returns the id of the user's most recent booking that has a slot and
  /// is still current (not cancelled, expired, completed or unpaid).
  Future<int?> _findActiveBookingId(
    Map<String, dynamic> headers,
    Dio dio,
  ) async {
    try {
      final response = await dio.get(
        ApiConstants.parkingHistory,
        queryParameters: {'limit': 20, 'offset': 0},
        options: Options(headers: headers),
      );
      if (response.statusCode != 200 ||
          response.data == null ||
          response.data['status'] != true) {
        return null;
      }
      final List history = response.data['data']?['history'] ?? [];
      const inactive = [
        'cancel',
        'expire',
        'done',
        'complete',
        'close',
        'draft',
        'pending',
      ];
      for (final b in history) {
        if (b is! Map) continue;
        final state = (b['state'] ?? '').toString().toLowerCase();
        final slot = (b['slot'] ?? '').toString();
        if (slot.isEmpty || slot == 'false' || slot == 'null') continue;
        if (inactive.any(state.contains)) continue;
        final id = int.tryParse(b['id']?.toString() ?? '');
        if (id != null) {
          _activeBookingVehicle = (b['vehicle'] ?? '').toString();
          return id;
        }
      }
    } catch (e) {
      debugPrint('Error finding active booking: $e');
    }
    return null;
  }

  Future<void> _fetchParkingHistory() async {
    try {
      final response = await BaseClient.dio.get(
        ApiConstants.parkingHistory,
        queryParameters: {'limit': 100, 'offset': 0},
        options: Options(headers: _headers()),
      );
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List history = response.data['data']['history'] ?? [];
        if (!mounted) return;
        setState(() {
          for (final booking in history) {
            final slotStr = booking['slot']?.toString();
            if (slotStr != null && slotStr != "null" && slotStr.isNotEmpty) {
              _markBooked(slotStr);
            }
          }
        });
        _applyGloballyConfirmedSlots(); // Re-apply local ones after API fetch
      }
    } catch (e) {
      debugPrint('Error fetching history for booked slots: $e');
    }
  }

  Future<void> _fetchSlotDetails(
    String slotNumber,
    Map<String, dynamic> headers,
    Dio dio,
  ) async {
    final slotResponse = await dio.post(
      ApiConstants.slotDetails,
      data: {'slot_number': slotNumber},
      options: Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    debugPrint('--- API RESPONSE (slot_details) ---');
    debugPrint('Response Data: ${slotResponse.data}');

    if (slotResponse.statusCode != 200 ||
        slotResponse.data == null ||
        slotResponse.data['status'] != true) {
      return;
    }
    final data = slotResponse.data['data'];
    if (!mounted || data == null) return;

    final number = data['slot_number']?.toString() ?? slotNumber;
    final slot = _resolve(number);
    setState(() {
      selectedSlotNumber = number;
      if (slot != null) {
        selectedLocation = _locationName(slot);
        selectedLocationType = _locationType(slot);
        selectedSlotSize = _fallbackSize(slot);
        if (widget.isDirectionMode || selectedSlotCode.isEmpty) {
          selectedSlotCode = slot.id;
        }
      }
      selectedLocationCode = slot?.displayCode ?? "";
      if (slot == null) {
        // Unknown on the map: show what the API says.
        selectedLocation = ApiLabels.translate(
          S.of(context),
          data['location_type'],
        );
        selectedLocationType = ApiLabels.translate(
          S.of(context),
          data['location_name'],
        );
      }
      _applyApiDetails(slot, data);

      // The slot loaded for this booking is the already-confirmed one.
      if (initialConfirmedSlot.isEmpty) initialConfirmedSlot = number;

      if (slot != null && data.containsKey('is_booked')) {
        bookedSlots = data['is_booked'] == true
            ? {...bookedSlots, slot.id}
            : ({...bookedSlots}..remove(slot.id));
      }
      if (slot != null && data.containsKey('shaded_slot')) {
        shadedSlots = data['shaded_slot'] == true
            ? {...shadedSlots, slot.id}
            : ({...shadedSlots}..remove(slot.id));
      }
    });
    if (slot != null) _centerOn(slot);
  }

  bool _isSameAsConfirmed() =>
      initialConfirmedSlot.isNotEmpty &&
      selectedSlotNumber == initialConfirmedSlot;

  void _onSlotSelected(MapSlot slot) {
    if (bookedSlots.contains(slot.id)) {
      _showCustomSnackBar(S.of(context).slotAlreadyBooked, isError: true);
      return;
    }
    setState(() {
      selectedSlotCode = slot.id;
      selectedSlotNumber = slot.backendName;
      selectedLocationCode = slot.displayCode;
      selectedLocation = _locationName(slot);
      selectedLocationType = _locationType(slot);
      // Local fallback until the dynamic size arrives from slot_details.
      selectedSlotSize = _fallbackSize(slot);
    });
    _saveSelectedSlot();
    _fetchSlotSize(slot);
  }

  /// Fetches the dynamic `slot_size` for the tapped slot from
  /// `/api/parking/slot_details` and replaces the local fallback size.
  Future<void> _fetchSlotSize(MapSlot slot) async {
    try {
      final response = await BaseClient.dio.post(
        ApiConstants.slotDetails,
        data: {'slot_number': slot.backendName},
        options: Options(
          headers: _headers(),
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      if (response.statusCode != 200 ||
          response.data == null ||
          response.data['status'] != true) {
        return;
      }
      final data = response.data['data'];
      if (data is! Map) return;
      // Ignore stale responses if the user tapped another slot meanwhile.
      if (!mounted || selectedSlotCode != slot.id) return;
      setState(() => _applyApiDetails(slot, data));
      _saveSelectedSlot();
    } catch (e) {
      debugPrint('Error fetching slot size: $e');
    }
  }

  Future<void> _continueToBooking() async {
    if (selectedSlotCode.isEmpty || selectedSlotNumber.isEmpty) {
      _showCustomSnackBar(S.of(context).errorConfirmingLocation, isError: true);
      return;
    }
    _saveSelectedSlot();

    if (Get.isRegistered<BookParkingController>()) {
      Get.delete<BookParkingController>(force: true);
    }
    final bookCtrl = Get.put(BookParkingController());
    bookCtrl.applySmartParkingSlot(
      slotNumber: selectedSlotNumber,
      slotCode: selectedSlotCode,
      slotSize: selectedSlotSize,
    );

    Get.to(
      () => BookParkingScreen(
        fromSmartParking: true,
        preselectedSlotNumber: selectedSlotNumber,
        preselectedSlotCode: selectedSlotCode,
        preselectedSlotSize: selectedSlotSize,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Localised slot info
  // ---------------------------------------------------------------------------

  /// Applies a `/parking/slot_details` response. In that API
  /// `location_name` is the shade area ("Shaded" / "Non-Shaded"),
  /// `location_type` is the slot type and `location_code` a location id.
  /// Call inside setState.
  void _applyApiDetails(MapSlot? slot, Map data) {
    final size = SlotSizeUtils.read(data);
    if (size.isNotEmpty) selectedSlotSize = size;
    final area = data['location_name'];
    if (slot == null || area == null || area == false) return;
    final shaded = !RegExp(
      r'non|un',
      caseSensitive: false,
    ).hasMatch(area.toString());
    shadedSlots = shaded
        ? {...shadedSlots, slot.id}
        : ({...shadedSlots}..remove(slot.id));
    selectedLocationType = _locationType(slot);
  }

  String _locationName(MapSlot slot) {
    final s = S.of(context);
    switch (slot.group.key) {
      case 'JET':
        return s.jetskiWithTrailerParking;
      case 'FT17':
      case 'FT13':
        return s.foodTruckParking;
      case 'BOA':
      case 'BOB':
        return s.boatsParking;
      case 'CAA':
      case 'CAB':
        return s.caravanParking;
      default:
        return s.areaSuffix(slot.group.locationCode);
    }
  }

  String _locationType(MapSlot slot) => shadedSlots.contains(slot.id)
      ? S.of(context).shaded
      : S.of(context).unshaded;

  String _fallbackSize(MapSlot slot) => slot.group.fallbackSize;

  /// Translates the English text painted on the map.
  String _translateMapLabel(String text) {
    final s = S.of(context);
    final shaded = RegExp(
      r'^(BOATS|CARAVAN) PARKING - ([AB]) \(SHADED\)$',
    ).firstMatch(text);
    if (shaded != null) {
      return shaded.group(1) == 'BOATS'
          ? s.mapBoatsParkingShaded(shaded.group(2)!)
          : s.mapCaravanParkingShaded(shaded.group(2)!);
    }
    final plain = RegExp(
      r'^(BOATS|CARAVAN) PARKING - ([AB])$',
    ).firstMatch(text);
    if (plain != null) {
      return plain.group(1) == 'BOATS'
          ? s.mapBoatsParking(plain.group(2)!)
          : s.mapCaravanParking(plain.group(2)!);
    }
    final food = RegExp(r'Length (\d+)m$').firstMatch(text);
    if (food != null) return s.mapFoodTruckParkingLength(food.group(1)!);
    switch (text) {
      case 'JETSKI WITH TRAILER PARKING':
        return s.mapJetskiTrailerParking;
      case 'EXIT':
        return s.mapExit;
      case 'ENTRANCE':
        return s.mapEntrance;
    }
    return text;
  }

  // ---------------------------------------------------------------------------
  // Map viewport
  // ---------------------------------------------------------------------------

  double _fitScale(Size viewport) => viewport.height / ParkingMapLayout.height;

  /// Called after every layout. The map always shows its full height (as in
  /// the design), so when the viewport changes size — e.g. the info rows
  /// appear after a tap — it is re-fitted, keeping the same left edge.
  void _setInitialTransform(Size viewport) {
    if (_viewport == viewport) return;
    // Ignore the zero-size frames seen during route transitions; fitting to
    // them would lose the scroll position (scale 0 → NaN).
    if (viewport.width <= 0 || viewport.height <= 0) return;
    final first = _viewport == null;
    _viewport = viewport;
    final m = _transformationController.value;
    final scale = m.getMaxScaleOnAxis();
    double left = first || scale <= 0
        ? _designScrollX
        : -m.getTranslation().x / scale;
    if (!left.isFinite) left = _designScrollX;
    _showFrom(left);
    final selected = _map.byId(selectedSlotCode);
    if (first && selected != null && widget.isDirectionMode) {
      _centerOn(selected);
    }
  }

  /// Fits the map to the viewport height and shows it from map x = [left].
  void _showFrom(double left) {
    final viewport = _viewport;
    if (viewport == null) return;
    final scale = _fitScale(viewport);
    final maxX = math.max(0.0, ParkingMapLayout.width * scale - viewport.width);
    final x = (left * scale).clamp(0.0, maxX);
    _transformationController.value = Matrix4.identity()
      ..translateByDouble(-x, 0, 0, 1)
      ..scaleByDouble(scale, scale, 1, 1);
  }

  void _centerOn(MapSlot slot) {
    final viewport = _viewport;
    if (viewport == null) return;
    final scale = _fitScale(viewport);
    _showFrom(slot.center.dx - viewport.width / 2 / scale);
  }

  /// Scale from the 430-wide XD artboard to this screen's width.
  double get _k =>
      (MediaQuery.sizeOf(context).width / 430).clamp(0.8, 1.25).toDouble();

  /// Design pixels → logical pixels on this device.
  double _d(double v) => v * _k;

  /// API sizes come as length x width ("17m x 5m"); the design shows the
  /// short side first ("5m x 17m").
  String _designSize(String raw) {
    final m = RegExp(r'([\d.]+)\s*(?:m|م)?\s*[xX×]\s*([\d.]+)').firstMatch(raw);
    if (m == null) return raw;
    final a = double.parse(m.group(1)!), b = double.parse(m.group(2)!);
    String fmt(double v) =>
        v == v.roundToDouble() ? v.toInt().toString() : v.toString();
    final w = fmt(math.min(a, b)), l = fmt(math.max(a, b));
    // Left-to-right isolate so Arabic layout keeps "5م x 17م" in order.
    const lri = '\u{2066}', pdi = '\u{2069}';
    return '$lri${S.of(context).sizeFormat(w, l)}$pdi';
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _Design.background,
      appBar: AppBar(
        backgroundColor: _Design.red,
        surfaceTintColor: _Design.red,
        toolbarHeight: _d(_Design.headerHeight),
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: _d(72),
        titleSpacing: _d(6),
        leading: InkResponse(
          onTap: () => Navigator.of(context).pop(),
          radius: 28,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: _d(33)),
            child: Center(child: _BackChevron(scale: _k)),
          ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            widget.isDirectionMode
                ? S.of(context).vehicleDirection
                : S.of(context).selectParkingLocation,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: _d(25),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _buildInstructions(),
              Expanded(child: _buildMap()),
              _buildFooterPanel(),
            ],
          ),
          if (isLoadingData)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(color: _Design.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(_d(44), _d(5), _d(40), _d(7)),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          S.of(context).navigateSelectSlot,
          style: TextStyle(color: Colors.black, fontSize: _d(16), height: 1.3),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = constraints.biggest;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _setInitialTransform(viewport);
        });
        final fit = _fitScale(viewport);
        return ClipRect(
          child: Container(
            color: ParkingMapColors.ground,
            child: InteractiveViewer(
              transformationController: _transformationController,
              constrained: false,
              minScale: fit,
              maxScale: fit * 4,
              boundaryMargin: EdgeInsets.zero,
              child: GestureDetector(
                onTapUp: widget.isDirectionMode
                    ? null
                    : (details) {
                        final slot = _map.hitTest(details.localPosition);
                        if (slot != null) _onSlotSelected(slot);
                      },
                child: CustomPaint(
                  size: const Size(
                    ParkingMapLayout.width,
                    ParkingMapLayout.height,
                  ),
                  painter: ParkingMapPainter(
                    selectedId: selectedSlotCode,
                    bookedIds: bookedSlots,
                    shadedIds: shadedSlots,
                    translateLabel: _translateMapLabel,
                    textDirection: Directionality.of(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterPanel() {
    final s = S.of(context);
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(top: _d(14), bottom: _d(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegendRow(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                _d(19),
                _d(24),
                _d(16),
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isDirectionMode && noActiveBooking)
                    Text(
                      s.noActiveBooking,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _d(16),
                        color: Colors.black,
                      ),
                    ),
                  if (widget.isDirectionMode && lookupVehicle != null)
                    _buildInfoRow(
                      '${s.vehicle} :',
                      "${lookupVehicle!['license_number'] ?? ''} • ${lookupVehicle!['vehicle_type_name'] ?? lookupVehicle!['model'] ?? ''}",
                    ),
                  if (selectedSlotCode.isNotEmpty) ...[
                    _buildInfoRow(
                      s.locationCodeLabel.trim(),
                      selectedLocationCode,
                    ),
                    _buildInfoRow(s.locationLabel.trim(), selectedLocation),
                    _buildInfoRow(
                      s.locationTypeLabel.trim(),
                      selectedLocationType,
                    ),
                    _buildInfoRow(
                      s.sizeShortLabel,
                      _designSize(selectedSlotSize),
                    ),
                  ],
                ],
              ),
            ),
            if (!widget.isDirectionMode) ...[
              SizedBox(height: _d(12)),
              Center(child: _buildConfirmButton()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    final confirmed = _isSameAsConfirmed();
    return SizedBox(
      width: _d(318),
      height: _d(49),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _Design.red,
          disabledBackgroundColor: _Design.red.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_d(16)),
          ),
        ),
        // Like the design, the button always looks active; with no slot
        // chosen, _continueToBooking explains what is missing.
        onPressed: confirmed ? null : _continueToBooking,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            confirmed
                ? S.of(context).locationConfirmedSuccessfully
                : S.of(context).confirmLocation,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: _d(20)),
          ),
        ),
      ),
    );
  }

  Widget _buildLegendRow() {
    final s = S.of(context);
    // Square x positions in the design: 17, 126, 225, 333 (430 wide).
    return Padding(
      padding: EdgeInsetsDirectional.only(start: _d(17)),
      child: Row(
        children: [
          _buildLegendItem(ParkingMapColors.available, s.available, 109),
          _buildLegendItem(ParkingMapColors.booked, s.booked, 99),
          _buildLegendItem(ParkingMapColors.selected, s.selected, 108),
          Expanded(
            child: _buildLegendItem(ParkingMapColors.shaded, s.shaded, null),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, double? width) {
    final item = Row(
      children: [
        Container(
          width: _d(21),
          height: _d(22),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white),
          ),
        ),
        SizedBox(width: _d(8)),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              label,
              style: TextStyle(fontSize: _d(15), color: Colors.black),
            ),
          ),
        ),
        SizedBox(width: _d(6)),
      ],
    );
    return width == null ? item : SizedBox(width: _d(width), child: item);
  }

  Widget _buildInfoRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: _d(20.7),
      child: Row(
        children: [
          SizedBox(
            width: _d(120),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: _d(15)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _d(15),
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? _Design.red : const Color(0xFF2ECC71),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// The thick white "<" back chevron from the design (stroke 4).
class _BackChevron extends StatelessWidget {
  final double scale;
  const _BackChevron({this.scale = 1});

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Transform.flip(
      flipX: rtl,
      child: CustomPaint(
        size: Size(16 * scale, 27 * scale),
        painter: _ChevronPainter(),
      ),
    );
  }
}

class _ChevronPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(size.width - 2.5, 2.5)
      ..lineTo(2.5, size.height / 2)
      ..lineTo(size.width - 2.5, size.height - 2.5);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
