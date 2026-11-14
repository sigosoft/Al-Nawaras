import 'package:al_nawaras/generated/l10n.dart';
import 'package:al_nawaras/utils/slot_size_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SlotSizeUtils.read', () {
    test('returns the trimmed slot_size', () {
      expect(SlotSizeUtils.read({'slot_size': ' 4.6m x 4m '}), '4.6m x 4m');
    });

    test('returns empty for missing, null or Odoo false values', () {
      expect(SlotSizeUtils.read(null), '');
      expect(SlotSizeUtils.read({}), '');
      expect(SlotSizeUtils.read({'slot_size': false}), '');
      expect(SlotSizeUtils.read({'slot_size': 'false'}), '');
    });
  });

  group('SlotSizeUtils.format', () {
    late S s;
    setUpAll(() async {
      s = await S.load(const Locale('en'));
    });

    String strip(String v) => v.replaceAll(RegExp('[\u2066\u2069]'), '');

    test('keeps the API order and uses an upper-case X', () {
      expect(strip(SlotSizeUtils.format('4.6m x 4m', s)), '4.6m X 4m');
      expect(strip(SlotSizeUtils.format('17 x 5', s)), '17m X 5m');
    });

    test('returns other values unchanged', () {
      expect(SlotSizeUtils.format(' Large ', s), 'Large');
    });
  });
}
