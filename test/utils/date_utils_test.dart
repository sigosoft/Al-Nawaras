import 'package:al_nawaras/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  group('AppDateUtils.parseApiUtc', () {
    test('treats a zone-less API timestamp as UTC', () {
      final dt = AppDateUtils.parseApiUtc('2026-11-15 07:11:00');
      expect(dt, isNotNull);
      expect(dt!.toUtc(), DateTime.utc(2026, 11, 15, 7, 11));
    });

    test('keeps an explicit zone', () {
      final dt = AppDateUtils.parseApiUtc('2026-11-15T07:11:00+04:00');
      expect(dt!.toUtc(), DateTime.utc(2026, 11, 15, 3, 11));
    });

    test('returns null for empty or Odoo false values', () {
      for (final v in [null, false, '', 'false', 'N/A', 'not a date']) {
        expect(AppDateUtils.parseApiUtc(v), isNull, reason: '$v');
      }
    });
  });

  group('AppDateUtils.formatApiUtc', () {
    test('formats in local time inside a left-to-right isolate', () {
      final local = DateTime.utc(2026, 11, 15, 7, 11).toLocal();
      final expected = DateFormat('dd/MM/yyyy hh:mm a').format(local);
      final out = AppDateUtils.formatApiUtc('2026-11-15 07:11:00');
      expect(out.codeUnitAt(0), 0x2066);
      expect(out.codeUnitAt(out.length - 1), 0x2069);
      expect(out.substring(1, out.length - 1), expected);
    });

    test('formats in Arabic without the isolate when the app is Arabic', () async {
      await initializeDateFormatting('ar');
      final out = Intl.withLocale(
        'ar',
        () => AppDateUtils.formatApiUtc('2026-11-15 07:11:00'),
      );
      final local = DateTime.utc(2026, 11, 15, 7, 11).toLocal();
      expect(out, DateFormat('dd/MM/yyyy hh:mm a', 'ar').format(local));
      expect(out.contains(String.fromCharCode(0x2066)), isFalse);
    });

    test('falls back for missing values and passes other text through', () {
      expect(AppDateUtils.formatApiUtc(false), 'N/A');
      expect(AppDateUtils.formatApiUtc(null, fallback: ''), '');
      expect(AppDateUtils.formatApiUtc('Pending'), 'Pending');
    });
  });
}
