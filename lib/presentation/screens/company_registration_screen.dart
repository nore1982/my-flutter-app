import 'package:flutter/material.dart';
import '../../data/locations.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState
    extends State<CompanyRegistrationScreen> {
  int _currentStep = 0;

  late Country _selectedCountry;
  late String _selectedCity;

  final _companyNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _facebookController = TextEditingController();
  final _instagramController = TextEditingController();

  String _selectedActivity = 'مطعم';
  String? _passportImage;
  String? _logoImage;
  String _gpsLocation = 'لم يتم التحديد بعد';
  final String _generatedPin = '111111';

  final List<String> _activities = [
    'مطعم',
    'كافيه',
    'صيدلية',
    'مواد بناء',
    'شركة نقل',
    'معرض سيارات',
    'مواد كهربائية',
    'ورشة ألومنيوم',
    'مكتب عقارات',
    'محل ملابس',
    'شركة مقاولات'
  ];

  @override
  void initState() {
    super.initState();
    _selectedCountry = arabCountries.first;
    _selectedCity = _selectedCountry.cities.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل شركة / متجر جديد'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) setState(() => _currentStep++);
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        controlsBuilder: (context, details) {
          if (_currentStep == 2) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 1 ? 'إرسال الطلب' : 'التالي'),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('السابق'),
                    ),
                  ),
                ]
              ],
            ),
          );
        },
        steps: [
          // 🔹 الخطوة 1: البيانات العامة والأوراق الرسمية
          Step(
            title: const Text('البيانات'),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedActivity,
                  decoration: const InputDecoration(
                      labelText: 'نوع النشاط التجاري',
                      border: OutlineInputBorder()),
                  items: _activities
                      .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedActivity = v!),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _companyNameController,
                  decoration: const InputDecoration(
                      labelText: 'اسم الشركة / المتجر',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _managerNameController,
                  decoration: const InputDecoration(
                      labelText: 'اسم المدير المسؤول',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(
                      labelText: 'الجنسية', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: const Icon(Icons.badge, color: Colors.blue),
                  title: Text(_passportImage ?? 'رفع صورة جواز السفر (مطلوب)'),
                  trailing: const Icon(Icons.upload),
                  onTap: () => setState(() => _passportImage = 'Passport.jpg'),
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: const Icon(Icons.verified_user, color: Colors.green),
                  title: Text(_logoImage ??
                      'صورة الشعار / الأوراق (اختياري - لحساب موثق)'),
                  trailing: const Icon(Icons.upload),
                  onTap: () => setState(() => _logoImage = 'Logo.png'),
                ),
              ],
            ),
          ),

          // 🔹 الخطوة 2: الدولة والفرع وموقع GPS
          Step(
            title: const Text('الموقع والتواصل'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                DropdownButtonFormField<Country>(
                  value: _selectedCountry,
                  decoration: const InputDecoration(
                      labelText: 'الدولة', border: OutlineInputBorder()),
                  items: arabCountries
                      .map((c) => DropdownMenuItem(
                          value: c, child: Text('${c.name} (${c.dialCode})')))
                      .toList(),
                  onChanged: (c) {
                    if (c != null) {
                      setState(() {
                        _selectedCountry = c;
                        _selectedCity = c.cities.first;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCity,
                  decoration: const InputDecoration(
                      labelText: 'المدينة / الفرع الجغرافي',
                      border: OutlineInputBorder()),
                  items: _selectedCountry.cities
                      .map((city) =>
                          DropdownMenuItem(value: city, child: Text(city)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedCity = v!),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف الأساسي',
                    prefixText: '${_selectedCountry.dialCode} ',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _whatsappController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'رقم الواتساب للعمل',
                    prefixText: '${_selectedCountry.dialCode} ',
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white),
                  onPressed: () => setState(() => _gpsLocation =
                      '32.4812° N, 14.8192° E (تم تثبيت المقر)'),
                  icon: const Icon(Icons.my_location),
                  label: Text('تحديد موقع المقر على الخريطة (GPS): $_gpsLocation'),
                ),
                const SizedBox(height: 10),
                TextField(
                    controller: _facebookController,
                    decoration: const InputDecoration(
                        labelText: 'رابط صفحة الفيس بوك (اختياري)',
                        border: OutlineInputBorder())),
                const SizedBox(height: 8),
                TextField(
                    controller: _instagramController,
                    decoration: const InputDecoration(
                        labelText: 'رابط الإنستغرام (اختياري)',
                        border: OutlineInputBorder())),
              ],
            ),
          ),

          // 🔹 الخطوة 3: البطاقة التأكيدية وحفظ الرقم السري
          Step(
            title: const Text('التأكيد'),
            isActive: _currentStep >= 2,
            content: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.storefront, size: 60, color: Colors.blue),
                    const SizedBox(height: 10),
                    const Text('تم استلام طلب المعاينة بنجاح!',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text(
                      'سوف يتم زيارتك غداً أو بعد غد في الشركة أو المعرض من قبل مندوبنا لمعاينة المقر وتفعيل الحساب. إذا تأخر عليك المندوب أكثر من يومين يرجى الاتصال بنا.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const Divider(height: 24),
                    const Text('رقمك السري الخاص بك هو:',
                        style: TextStyle(color: Colors.grey)),
                    SelectableText(_generatedPin,
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            letterSpacing: 4)),
                    const SizedBox(height: 8),
                    const Text('📸 صور الشاشة لحفظ الرقم السري',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}