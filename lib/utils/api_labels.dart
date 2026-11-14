import 'package:intl/intl.dart';

import '../generated/l10n.dart';

/// Translates known English values sent by the API (booking states, shade
/// areas, membership tiers and plan types) for display. Unknown values are
/// returned unchanged, so new backend values still show (in English).
class ApiLabels {
  ApiLabels._();

  static String translate(S s, dynamic raw) {
    if (raw == null || raw == false) return '';
    final value = raw.toString().trim();
    // The API already sends English; keep its exact wording (e.g.
    // "Non-Shaded") in English and only translate for other languages.
    if (Intl.getCurrentLocale().startsWith('en')) return value;
    final key = value.toLowerCase().replaceAll(RegExp(r'[_\-\s]+'), ' ');
    switch (key) {
      // Booking states
      case 'booked':
        return s.booked;
      case 'confirmed':
        return s.stateConfirmed;
      case 'cancel':
      case 'cancelled':
      case 'canceled':
        return s.stateCancelled;
      case 'done':
      case 'completed':
      case 'complete':
        return s.stateCompleted;
      case 'expired':
        return s.stateExpired;
      case 'draft':
        return s.stateDraft;
      case 'pending payment':
        return s.statePendingPayment;
      case 'paid':
        return s.statePaid;
      // Shade areas / locations
      case 'shaded':
        return s.shaded;
      case 'non shaded':
      case 'unshaded':
        return s.unshaded;
      // Membership tiers
      case 'standard':
        return s.standardTier;
      case 'silver':
        return s.silverTier;
      case 'gold':
        return s.goldTier;
      // Plan types
      case 'hourly':
        return s.planHourly;
      case 'daily':
        return s.planDaily;
      case 'weekly':
        return s.planWeekly;
      case 'monthly':
        return s.planMonthly;
      case 'yearly':
      case 'annual':
        return s.planYearly;
      default:
        return value;
    }
  }
}
