import 'package:flutter/material.dart';
import '../../data/locations.dart';

class IndividualRegistrationScreen extends StatefulWidget {
  const IndividualRegistrationScreen({super.key});

  @override
  State<IndividualRegistrationScreen> createState() =>
      _IndividualRegistrationScreenState();
}

class _IndividualRegistrationScreenState
    extends State<IndividualRegistrationScreen> {
  int _currentStep = 0;

  late Country _selectedCountry;
  late String _selectedCity;

  final _fullNameController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();

  String _selectedProfession = 'سباك';
  String? _passportImage;
  String? _profileOrWorkImage;
  final String _generatedPin = '222222';

  final List<String> _professions = [
    'سباك',
    'كهربائي منازل',
    'معلم سيراميك',
    'نقاش / صباغ',
    'نجار',
    'فني مكيفات',
    'حداد',
    'سائق توصيل',
    'ميكانيكي سيارات',
    'فني ألومنيوم',
    'عامل تنظيفات',
    'مهنة أخرى'
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
        title: const Text('تسجيل فرد / حرفي جديد'),
        backgroundColor: Colors.teal,
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
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
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
          // 🔹 الخطوة 1: المهنة والبيانات الشخصية والأوراق
          Step(
            title: const Text('البيانات'),
            isActive: _currentStep >= 0,
            content: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedProfession,
                  decoration: const InputDecoration(
                    labelText: 'المهنة / التخصص',
                    border: OutlineInputBorder(),
                  ),
                  items: _professions
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedProfession = v!),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'الاسم الرباعي',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(
                    labelText: 'الجنسية',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: const Icon(Icons.badge, color: Colors.teal),
                  title: Text(_passportImage ?? 'رفع صورة جواز السفر (مطلوب)'),
                  trailing: const Icon(Icons.upload),
                  onTap: () => setState(() => _passportImage = 'Passport_Ind.jpg'),
                ),
                const SizedBox(height: 8),
                ListTile(
                  tileColor: Colors.grey.shade200,
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(_profileOrWorkImage ??
                      'صورة شخصية / نموذج عمل (اختياري)'),
                  trailing: const Icon(Icons.upload),
                  onTap: () => setState(() => _profileOrWorkImage = 'Photo.png'),
                ),
              ],
            ),
          ),

          // 🔹 الخطوة 2: الدولة والمدينة وأرقام التواصل
          Step(
            title: const Text('الموقع والتواصل'),
            isActive: _currentStep >= 1,
            content: Column(
              children: [
                DropdownButtonFormField<Country>(
                  value: _selectedCountry,
                  decoration: const InputDecoration(
                    labelText: 'الدولة',
                    border: OutlineInputBorder(),
                  ),
                  items: arabCountries
                      .map((c) => DropdownMenuItem(
                            value: c,
                            child: Text('${c.name} (${c.dialCode})'),
                          ))
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
                    labelText: 'المدينة / منطقة العمل الرئيسية',
                    border: OutlineInputBorder(),
                  ),
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
                    labelText: 'رقم الواتساب للتواصل',
                    prefixText: '${_selectedCountry.dialCode} ',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 الخطوة 3: البطاقة التأكيدية وإصدار الرقم السري
          Step(
            title: const Text('التأكيد'),
            isActive: _currentStep >= 2,
            content: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(Icons.engineering, size: 60, color: Colors.teal),
                    const SizedBox(height: 10),
                    const Text(
                      'تم استلام طلب التفعيل بنجاح!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'سيتم التواصل معك هاتفياً أو عبر الواتساب من قبل فريق الدعم الفني لتأكيد بيانات المهنة وتفعيل الحساب بشكل كامل.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, height: 1.4),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'رقمك السري الخاص بك هو:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SelectableText(
                      _generatedPin,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '📸 صور الشاشة لحفظ الرقم السري',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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