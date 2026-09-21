/// UAE mobile number parsing and validation.
///
/// Accepts: +971XXXXXXXXX, 971XXXXXXXXX, 0XXXXXXXXX, or XXXXXXXXX (9 digits).
/// After country code (+971), the local number must be exactly 9 digits.
class PhoneUtils {
  static const int subscriberLength = 9;

  static String _clean(String input) {
    return input.trim().replaceAll(RegExp(r'[\s\-()]'), '');
  }

  /// Digits after removing +971 / 971 / leading 0.
  static String _subscriberDigits(String cleaned) {
    if (cleaned.startsWith('+971')) {
      return cleaned.substring(4);
    }
    if (cleaned.startsWith('971')) {
      return cleaned.substring(3);
    }
    if (cleaned.startsWith('0')) {
      return cleaned.substring(1);
    }
    return cleaned;
  }

  /// Returns the 9-digit subscriber number, or null if invalid.
  static String? _extractNineDigits(String cleaned) {
    final subscriber = _subscriberDigits(cleaned);
    if (subscriber.length == subscriberLength &&
        RegExp(r'^\d{9}$').hasMatch(subscriber)) {
      return subscriber;
    }
    return null;
  }

  static bool isValidUaeMobile(String input) {
    final cleaned = _clean(input);
    if (cleaned.isEmpty) return false;
    if (!RegExp(r'^\+?\d+$').hasMatch(cleaned)) return false;
    return _extractNineDigits(cleaned) != null;
  }

  /// Returns +971XXXXXXXXX or null if invalid.
  static String? toInternationalFormat(String input) {
    final nine = _extractNineDigits(_clean(input));
    if (nine == null) return null;
    return '+971$nine';
  }

  /// Returns 0XXXXXXXXX local format or null if invalid.
  static String? toLocalFormat(String input) {
    final nine = _extractNineDigits(_clean(input));
    if (nine == null) return null;
    return '0$nine';
  }

  /// Formats stored values for display in input fields.
  static String formatForDisplay(String? stored) {
    if (stored == null || stored.isEmpty) return '';
    return toInternationalFormat(stored) ?? stored;
  }

  static String? validationError(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty || trimmed == '+971' || trimmed == '971') {
      return 'Please enter your Mobile Number';
    }
    final cleaned = _clean(input);
    if (!RegExp(r'^\+?\d+$').hasMatch(cleaned)) {
      return 'Mobile number must contain only digits after +971';
    }

    final subscriber = _subscriberDigits(cleaned);
    if (!RegExp(r'^\d*$').hasMatch(subscriber)) {
      return 'Mobile number must contain only digits after +971';
    }
    if (subscriber.length < subscriberLength) {
      return 'Mobile number must be exactly 9 digits after +971';
    }
    if (subscriber.length > subscriberLength) {
      return 'Mobile number cannot be more than 9 digits after +971';
    }
    return null;
  }
}
