/// Formats and reads money values shown in the app.
class AmountUtils {
  AmountUtils._();

  static final _number = RegExp(r'\d[\d,]*(?:\.\d+)?');

  /// Returns [value] with two decimals ("20" / 20.0 → "20.00").
  /// Values that aren't numbers (null, Odoo `false`, text) become [fallback].
  static String format(dynamic value, {String fallback = '0.00'}) {
    if (value is num) return value.toStringAsFixed(2);
    final parsed = double.tryParse(value?.toString().replaceAll(',', '') ?? '');
    return parsed == null ? fallback : parsed.toStringAsFixed(2);
  }

  /// Reads the first number in a display string such as "AED 1,500.00",
  /// "د.إ 150.00" or "AED 20/hour". Returns null when there is none.
  /// (Stripping non-digits instead breaks on "د.إ", which contains a dot.)
  static double? parse(String? text) {
    final match = _number.firstMatch(text ?? '');
    if (match == null) return null;
    return double.tryParse(match.group(0)!.replaceAll(',', ''));
  }
}
