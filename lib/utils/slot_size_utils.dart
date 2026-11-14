/// Helpers for the dynamic `slot_size` field returned by
/// `/api/parking/check_availability` and `/api/parking/slot_details`.
class SlotSizeUtils {
  SlotSizeUtils._();

  /// Reads `slot_size` from an API map, returning an empty string when the
  /// field is missing, null or `false` (Odoo-style empty value).
  static String read(Map? data) {
    if (data == null) return '';
    final raw = data['slot_size'];
    if (raw == null || raw == false) return '';
    final value = raw.toString().trim();
    if (value.isEmpty || value == 'false' || value == 'null') return '';
    return value;
  }

  /// Formats an API size such as `"4.6m x 4m"` for display as `"4.6 X 4"`.
  /// Unit suffixes (m / م) are dropped and the separator is normalised.
  /// Values that don't look like `<w> x <l>` are returned unchanged.
  static String format(String size) {
    final match = RegExp(
      r'^\s*([\d.,]+)\s*(?:m|م)?\s*[xX×]\s*([\d.,]+)\s*(?:m|م)?\s*$',
    ).firstMatch(size);
    if (match == null) return size.trim();
    // Wrapped in a left-to-right isolate (U+2066 … U+2069) so Arabic
    // right-to-left layout doesn't reorder it to "X 4 4.6".
    return '\u2066${match.group(1)} X ${match.group(2)}\u2069';
  }
}
