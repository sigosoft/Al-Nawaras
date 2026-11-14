import 'package:al_nawaras/utils/amount_utils.dart';
import 'package:al_nawaras/utils/vehicle_images.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AmountUtils.format', () {
    test('always shows two decimals', () {
      expect(AmountUtils.format(20), '20.00');
      expect(AmountUtils.format(20.0), '20.00');
      expect(AmountUtils.format('1500'), '1500.00');
      expect(AmountUtils.format('1,500.5'), '1500.50');
    });

    test('uses the fallback for missing values', () {
      expect(AmountUtils.format(null), '0.00');
      expect(AmountUtils.format(false), '0.00');
      expect(AmountUtils.format('n/a', fallback: '-'), '-');
    });
  });

  group('AmountUtils.parse', () {
    test('reads English and Arabic currency strings', () {
      expect(AmountUtils.parse('AED 1,500.00'), 1500.0);
      expect(AmountUtils.parse('د.إ 150.00'), 150.0);
      expect(AmountUtils.parse(' AED 20.0'), 20.0);
      expect(AmountUtils.parse('AED 20/hour'), 20.0);
    });

    test('returns null when there is no number', () {
      expect(AmountUtils.parse(null), isNull);
      expect(AmountUtils.parse('د.إ'), isNull);
    });
  });

  group('VehicleImages.forType', () {
    test('matches API vehicle type names', () {
      expect(VehicleImages.forType('JETSKI'), 'lib/assets/images/jet ski.png');
      expect(VehicleImages.forType('Food Truck Parking Type A'),
          'lib/assets/images/food truck.png');
      expect(VehicleImages.forType('Boats Parking Type B'),
          'lib/assets/images/boat.png');
      expect(VehicleImages.forType('Caravan Parking Type A'),
          'lib/assets/images/caravan.png');
    });

    test('falls back for unknown or missing types', () {
      expect(VehicleImages.forType(null), VehicleImages.fallback);
      expect(VehicleImages.forType('Bus'), VehicleImages.fallback);
    });
  });
}
