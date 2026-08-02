import 'package:flutter/material.dart';
import '../data/locations.dart';
import '../services/location_storage_service.dart';

class HomeLocationHeader extends StatefulWidget {
  final Function(String country, String city) onLocationChanged;

  const HomeLocationHeader({
    super.key,
    required this.onLocationChanged,
  });

  @override
  State<HomeLocationHeader> createState() => _HomeLocationHeaderState();
}

class _HomeLocationHeaderState extends State<HomeLocationHeader> {
  String selectedCountry = 'ليبيا';
  String selectedCity = 'طرابلس';

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  // 🔹 تحميل الموقع المحفوظ سابقاً
  Future<void> _loadSavedLocation() async {
    final locationData = await LocationStorageService.getUserLocation();
    if (locationData['country'] != null && locationData['city'] != null) {
      if (mounted) {
        setState(() {
          selectedCountry = locationData['country']!;
          selectedCity = locationData['city']!;
        });
        widget.onLocationChanged(selectedCountry, selectedCity);
      }
    }
  }

  // 🔹 فتح نافذة تغيير الدولة والمدينة
  void _showLocationSelector() {
    String tempCountry = selectedCountry;
    String tempCity = selectedCity;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Country currentCountryObj = arabCountries.firstWhere(
              (c) => c.name == tempCountry,
              orElse: () => arabCountries.first,
            );

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'اختر موقع العرض والتوصيل 📍',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // قائمة اختيار الدولة
                  DropdownButtonFormField<String>(
                    value: tempCountry,
                    decoration: const InputDecoration(
                      labelText: 'الدولة',
                      border: OutlineInputBorder(),
                    ),
                    items: arabCountries.map((c) {
                      return DropdownMenuItem(
                        value: c.name,
                        child: Text(c.name),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          tempCountry = val;
                          tempCity = arabCountries
                              .firstWhere((c) => c.name == val)
                              .cities
                              .first;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // قائمة اختيار المدينة
                  DropdownButtonFormField<String>(
                    value: currentCountryObj.cities.contains(tempCity)
                        ? tempCity
                        : currentCountryObj.cities.first,
                    decoration: const InputDecoration(
                      labelText: 'المدينة',
                      border: OutlineInputBorder(),
                    ),
                    items: currentCountryObj.cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          tempCity = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // زر الحفظ والتأكيد
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          selectedCountry = tempCountry;
                          selectedCity = tempCity;
                        });
                        LocationStorageService.saveUserLocation(
                          countryName: tempCountry,
                          cityName: tempCity,
                        );
                        widget.onLocationChanged(tempCountry, tempCity);
                        Navigator.pop(context);
                      },
                      child: const Text('تأكيد وحفظ الموقع'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الموقع المعتمد حالياً:',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    '$selectedCountry - $selectedCity',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: _showLocationSelector,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: const Row(
                children: [
                  Text(
                    'تغيير',
                    style: TextStyle(fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.blue, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}