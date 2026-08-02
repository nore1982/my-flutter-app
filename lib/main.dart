import 'package:flutter/material.dart';

// استدعاء الملفات التي قمنا بإنشائها
import 'presentation/screens/company_registration_screen.dart';
import 'presentation/screens/individual_registration_screen.dart';
import 'widgets/home_location_header.dart';
import 'widgets/contact_buttons_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'التطبيق التجاري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto', // يمكنك تغيير الخط حسب مشروعك
      ),
      home: const HomeScreen(),
      routes: {
        '/register_company': (context) => const CompanyRegistrationScreen(),
        '/register_individual': (context) => const IndividualRegistrationScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentCountry = 'ليبيا';
  String currentCity = 'طرابلس';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1️⃣ هيدر اختيار الدولة والمدينة
            HomeLocationHeader(
              onLocationChanged: (country, city) {
                setState(() {
                  currentCountry = country;
                  currentCity = city;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('تم تحديث العروض لـ: $country - $city'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // بطاقة الترحيب بالموقع الحالي
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.store, size: 40, color: Colors.blue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'المتاجر المتاحة حالياً في:',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  '$currentCountry / $currentCity',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'اختبار أزرار التواصل للمتاجر:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  // 2️⃣ ودجت أزرار التواصل (اتصال، واتساب، موقع)
                  const ContactButtonsWidget(
                    phoneNumber: '+218910000000',
                    whatsappNumber: '+218910000000',
                    locationUrl: 'https://maps.google.com',
                  ),

                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),

                  const Text(
                    'الانتقال لشاشات التسجيل الجديدة:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),

                  // 3️⃣ زر الانتقال لتسجيل شركة / متجر
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_company');
                    },
                    icon: const Icon(Icons.business),
                    label: const Text('تسجيل شركة / متجر جديد', style: TextStyle(fontSize: 15)),
                  ),

                  const SizedBox(height: 12),

                  // 4️⃣ زر الانتقال لتسجيل فرد / حرفي
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_individual');
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('تسجيل فرد / حرفي جديد', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}