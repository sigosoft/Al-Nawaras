import 'package:intl/intl.dart';

/// The parking API stores and returns booking times in UTC as
/// "YYYY-MM-DD HH:MM:SS" (no zone marker); the app sends them in UTC too.
/// These helpers convert them to the phone's local time for display.
class AppDateUtils {
  AppDateUtils._();

  /// Parses an API timestamp as UTC and returns it in local time,
  /// or null if it is missing or not a date.
  static DateTime? parseApiUtc(dynamic value) {
    if (value == null || value == false) return null;
    final s = value.toString().trim();
    if (s.isEmpty || s == 'false' || s.toLowerCase() == 'n/a') return null;
    final iso = s.contains('T') ? s : s.replaceFirst(' ', 'T');
    final hasZone = RegExp(r'(Z|[+-]\d{2}:?\d{2})$').hasMatch(iso);
    final parsed = DateTime.tryParse(hasZone ? iso : '${iso}Z');
    return parsed?.toLocal();
  }

  /// Formats an API UTC timestamp as local "dd/MM/yyyy hh:mm a".
  /// Values that are not dates are returned unchanged (e.g. "N/A").
  static String formatApiUtc(dynamic value, {String fallback = 'N/A'}) {
    final dt = parseApiUtc(value);
    if (dt == null) {
      final s = value?.toString() ?? '';
      return (s.isEmpty || s == 'false') ? fallback : s;
    }
    return DateFormat('dd/MM/yyyy hh:mm a').format(dt);
  }
}
