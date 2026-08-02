import 'package:shared_preferences/shared_preferences.dart';

class LocationStorageService {
  static const String _keyCountry = 'user_selected_country';
  static const String _keyCity = 'user_selected_city';

  // 🔹 حفظ الدولة والمدينة وتثبيتها محلياً
  static Future<void> saveUserLocation({
    required String countryName,
    required String cityName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCountry, countryName);
    await prefs.setString(_keyCity, cityName);
  }

  // 🔹 جلب الدولة والمدينة المحفوظة
  static Future<Map<String, String?>> getUserLocation() async {
    final prefs = await SharedPreferences.getInstance();
    String? country = prefs.getString(_keyCountry);
    String? city = prefs.getString(_keyCity);

    return {
      'country': country, // سيكون null إذا كانت هذه هي المرة الأولى
      'city': city,
    };
  }
}