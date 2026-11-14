import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'parking_map_data.dart';

/// Colours used on the parking map (taken from the XD design).
class ParkingMapColors {
  ParkingMapColors._();
  static const Color ground = Color(0xFF4C4C4C);
  static const Color available = Color(0xFF4C4C4C);
  static const Color booked = Color(0xFFD3D3D3);
  static const Color selected = Color(0xFFFF0000);
  static const Color shaded = Color(0xFF8F9E79);
}

/// A parking area on the map (one block of numbered slots).
class SlotGroup {
  final String key;

  /// Short code shown as "Location Code" (e.g. "FTP 12").
  final String locationCode;

  /// Backend series letter ("A" or "B"). The backend numbers slots
  /// continuously across areas, so map slot n is backend number
  /// [backendOffset] + n, e.g. Food Truck 17m slot 12 is "A47".
  final String backendSeries;
  final int backendOffset;
  final int count;

  /// Backend slot type name, e.g. "Food Truck Parking Type A".
  final String slotTypeName;

  /// Fallback size in the API's format until `slot_size` arrives.
  final String fallbackSize;

  const SlotGroup(
    this.key,
    this.locationCode,
    this.backendSeries,
    this.backendOffset,
    this.count,
    this.slotTypeName,
    this.fallbackSize,
  );

  bool containsBackendNumber(int n) =>
      n > backendOffset && n <= backendOffset + count;
}

/// Slot groups as drawn in the XD design, with the backend naming verified
/// against the staging API (`/parking/check_availability`, Nov 2026).
const Map<String, SlotGroup> kSlotGroups = {
  'JET': SlotGroup('JET', 'JTP', 'A', 0, 35, 'JETSKI', '4.6m x 4m'),
  'FT17': SlotGroup(
    'FT17',
    'FTP',
    'A',
    35,
    15,
    'Food Truck Parking Type A',
    '17m x 5m',
  ),
  'FT13': SlotGroup(
    'FT13',
    'FTP',
    'A',
    50,
    28,
    'Food Truck Parking Type B',
    '13m x 5m',
  ),
  'BOA': SlotGroup(
    'BOA',
    'BTP',
    'B',
    0,
    45,
    'Boats Parking Type A',
    '6.5m x 4m',
  ),
  'BOB': SlotGroup(
    'BOB',
    'BTP',
    'B',
    45,
    94,
    'Boats Parking Type B',
    '12m x 4m',
  ),
  'CAA': SlotGroup(
    'CAA',
    'CTP',
    'B',
    139,
    24,
    'Caravan Parking Type A',
    '8m x 4.5m',
  ),
  'CAB': SlotGroup(
    'CAB',
    'CTP',
    'B',
    163,
    94,
    'Caravan Parking Type B',
    '9.5m x 4m',
  ),
};

class MapSlot {
  /// Stable id, e.g. "FT17-12".
  final String id;
  final SlotGroup group;
  final String number; // two digits, e.g. "12"
  final Path path;
  final Offset center;
  final Offset textPos;
  final double textRotation; // radians
  final double strokeWidth;
  final bool shadedInDesign;

  MapSlot({
    required this.id,
    required this.group,
    required this.number,
    required this.path,
    required this.center,
    required this.textPos,
    required this.textRotation,
    required this.strokeWidth,
    required this.shadedInDesign,
  });

  /// Name the backend uses for this slot, e.g. "A47 - Food Truck Parking Type A".
  String get backendName {
    final n = group.backendOffset + int.parse(number);
    return '${group.backendSeries}${n.toString().padLeft(2, '0')}'
        ' - ${group.slotTypeName}';
  }

  /// Short code shown in the footer, e.g. "FTP 12".
  String get displayCode => '${group.locationCode} $number';
}

class _Deco {
  final Path path;
  final Color? fill;
  final Color? stroke;
  final double strokeWidth;
  final double dash;
  final double opacity;
  Path? dashedPath; // cached
  _Deco(
    this.path,
    this.fill,
    this.stroke,
    this.strokeWidth,
    this.dash,
    this.opacity,
  );
}

class _Label {
  final String text;
  final Offset pos;
  final double rotation;
  final double size;
  _Label(this.text, this.pos, this.rotation, this.size);
}

/// Parsed geometry of the XD parking map. Parsed once and shared.
class ParkingMapLayout {
  ParkingMapLayout._();

  static final ParkingMapLayout instance = ParkingMapLayout._().._parse();

  static const double width = kParkingMapWidth;
  static const double height = kParkingMapHeight;

  /// Draw list in design order: [_Deco], [MapSlot] or [_Label].
  final List<Object> _items = [];
  final List<MapSlot> slots = [];
  final Map<String, MapSlot> _byId = {};
  final Map<String, MapSlot> _byBackendName = {};

  MapSlot? byId(String id) => _byId[id];

  void _parse() {
    for (final line in kParkingMapData.split('\n')) {
      if (line.isEmpty) continue;
      final f = line.split('|');
      switch (f[0]) {
        case 'D':
          final closed = f[6] == '1';
          final fill = f[1] == '-' ? null : _hex(f[1]);
          _items.add(
            _Deco(
              _path(f[7], close: closed && fill != null),
              fill,
              f[2] == '-' ? null : _hex(f[2]),
              double.parse(f[3]),
              double.parse(f[4]),
              double.parse(f[5]),
            ),
          );
          break;
        case 'S':
          final group = kSlotGroups[f[1]]!;
          final pts = _points(f[5]);
          final c = pts.reduce((a, b) => a + b) / pts.length.toDouble();
          final t = f[6].split(',');
          final slot = MapSlot(
            id: '${group.key}-${f[2]}',
            group: group,
            number: f[2],
            path: Path()..addPolygon(pts, true),
            center: c,
            textPos: Offset(double.parse(t[0]), double.parse(t[1])),
            textRotation: double.parse(f[7]) * math.pi / 180,
            strokeWidth: double.parse(f[3]),
            shadedInDesign: f[4] == '1',
          );
          slots.add(slot);
          _byId[slot.id] = slot;
          _byBackendName[_norm(slot.backendName)] = slot;
          _items.add(slot);
          break;
        case 'L':
          _items.add(
            _Label(
              f[1],
              Offset(double.parse(f[2]), double.parse(f[3])),
              double.parse(f[4]) * math.pi / 180,
              double.parse(f[5]),
            ),
          );
          break;
      }
    }
  }

  static String _norm(String s) =>
      s.toUpperCase().replaceAll(RegExp(r'\s+'), '');

  /// Finds the map slot for a backend slot name such as
  /// "A47 - Food Truck Parking Type A".
  MapSlot? resolveBackendName(String name) {
    final direct = _byBackendName[_norm(name)];
    if (direct != null) return direct;
    // Tolerate "A47", "A 47", "A47-…" or a different type suffix: the series
    // letter + number alone identify the slot.
    final m = RegExp(r'^\s*([AB])\s*-?\s*(\d+)\b').firstMatch(name);
    if (m == null) return null;
    final series = m.group(1)!;
    final n = int.parse(m.group(2)!);
    for (final g in kSlotGroups.values) {
      if (g.backendSeries == series && g.containsBackendNumber(n)) {
        final local = (n - g.backendOffset).toString().padLeft(2, '0');
        return _byId['${g.key}-$local'];
      }
    }
    return null;
  }

  /// Returns the slot under [p] (map coordinates), with a little tolerance
  /// so the thin slanted slots are easy to tap.
  MapSlot? hitTest(Offset p) {
    for (final s in slots) {
      if (s.path.contains(p)) return s;
    }
    MapSlot? best;
    double bestD = 14;
    for (final s in slots) {
      final d = (s.center - p).distance;
      if (d < bestD) {
        bestD = d;
        best = s;
      }
    }
    return best;
  }

  static Color _hex(String h) =>
      Color(int.parse(h.substring(1), radix: 16) | 0xFF000000);

  static List<Offset> _points(String s) => s.split(' ').map((p) {
    final xy = p.split(',');
    return Offset(double.parse(xy[0]), double.parse(xy[1]));
  }).toList();

  static Path _path(String s, {required bool close}) {
    final pts = _points(s);
    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (final p in pts.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    if (close) path.close();
    return path;
  }
}

/// Paints the XD parking map with live slot states.
class ParkingMapPainter extends CustomPainter {
  final String? selectedId;
  final Set<String> bookedIds;
  final Set<String> shadedIds;
  final String Function(String) translateLabel;
  final TextDirection textDirection;

  ParkingMapPainter({
    required this.selectedId,
    required this.bookedIds,
    required this.shadedIds,
    required this.translateLabel,
    required this.textDirection,
  });

  static final Map<String, TextPainter> _numberCache = {};

  @override
  void paint(Canvas canvas, Size size) {
    final layout = ParkingMapLayout.instance;
    for (final item in layout._items) {
      if (item is _Deco) {
        _paintDeco(canvas, item);
      } else if (item is MapSlot) {
        _paintSlot(canvas, item);
      } else if (item is _Label) {
        _paintLabel(canvas, item);
      }
    }
  }

  void _paintDeco(Canvas canvas, _Deco d) {
    if (d.fill != null) {
      canvas.drawPath(
        d.path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = d.fill!.withValues(alpha: d.opacity),
      );
    }
    if (d.stroke != null) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = d.strokeWidth
        ..color = d.stroke!.withValues(alpha: d.opacity);
      canvas.drawPath(
        d.dash > 0 ? (d.dashedPath ??= _dashed(d.path, d.dash)) : d.path,
        paint,
      );
    }
  }

  void _paintSlot(Canvas canvas, MapSlot s) {
    Color? fill;
    if (s.id == selectedId) {
      fill = ParkingMapColors.selected;
    } else if (bookedIds.contains(s.id)) {
      fill = ParkingMapColors.booked;
    } else if (shadedIds.contains(s.id) && !s.shadedInDesign) {
      // Shaded per API but outside the design's shaded zone: tint it.
      fill = ParkingMapColors.shaded;
    }
    if (fill != null) {
      canvas.drawPath(s.path, Paint()..color = fill);
    }
    canvas.drawPath(
      s.path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = s.strokeWidth
        ..color = Colors.white,
    );

    final tp = _numberCache.putIfAbsent(s.number, () {
      return TextPainter(
        text: TextSpan(
          text: s.number,
          style: const TextStyle(color: Colors.white, fontSize: 13, height: 1),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
    });
    canvas.save();
    canvas.translate(s.textPos.dx, s.textPos.dy);
    canvas.rotate(s.textRotation);
    tp.paint(
      canvas,
      Offset(0, -tp.computeDistanceToActualBaseline(TextBaseline.alphabetic)),
    );
    canvas.restore();
  }

  void _paintLabel(Canvas canvas, _Label l) {
    final tp = TextPainter(
      text: TextSpan(
        text: translateLabel(l.text),
        style: TextStyle(
          color: Colors.white,
          fontSize: l.size,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
      textDirection: textDirection,
    )..layout();
    canvas.save();
    canvas.translate(l.pos.dx, l.pos.dy);
    canvas.rotate(l.rotation);
    tp.paint(
      canvas,
      Offset(0, -tp.computeDistanceToActualBaseline(TextBaseline.alphabetic)),
    );
    canvas.restore();
  }

  static Path _dashed(Path source, double dash) {
    final out = Path();
    for (final ui.PathMetric m in source.computeMetrics()) {
      double d = 0;
      while (d < m.length) {
        out.addPath(
          m.extractPath(d, math.min(d + dash, m.length)),
          Offset.zero,
        );
        d += dash * 2;
      }
    }
    return out;
  }

  @override
  bool shouldRepaint(covariant ParkingMapPainter old) => true;
}
