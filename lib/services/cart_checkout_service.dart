import 'dart:math';

class CartCheckoutService {
  // حساب المسافة بين نقطتين بالقياس الجغرافي (Haversine Formula)
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Math.PI / 180
    final double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // المسافة بالكيلومترات
  }

  // الدالة التي تتحقق من شرط الـ 20 كم
  Future<bool> isWithinAllowedDistance({
    required double userLat,
    required double userLng,
    required double storeLat,
    required double storeLng,
    double maxDistanceKm = 20.0,
  }) async {
    // محاكاة تأخير بسيط للتحقق
    await Future.delayed(const Duration(milliseconds: 500));

    double distance = calculateDistance(userLat, userLng, storeLat, storeLng);
    return distance <= maxDistanceKm;
  }
}