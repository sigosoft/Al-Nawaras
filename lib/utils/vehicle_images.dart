/// Picks the bundled picture for a vehicle type name from the API
/// (e.g. "JETSKI", "Food Truck Parking Type A", "Boats Parking Type B").
class VehicleImages {
  VehicleImages._();

  static const fallback = 'lib/assets/images/Airstream.png';

  static String forType(String? typeName) {
    final lower = (typeName ?? '').toLowerCase();
    if (lower.contains('jet ski') || lower.contains('jetski')) {
      return 'lib/assets/images/jet ski.png';
    } else if (lower.contains('truck')) {
      return 'lib/assets/images/food truck.png';
    } else if (lower.contains('boat')) {
      return 'lib/assets/images/boat.png';
    } else if (lower.contains('caravan')) {
      return 'lib/assets/images/caravan.png';
    } else if (lower.contains('trailer')) {
      return 'lib/assets/images/trailer.png';
    } else if (lower.contains('trolly')) {
      return 'lib/assets/images/trolly.png';
    }
    return fallback;
  }
}
