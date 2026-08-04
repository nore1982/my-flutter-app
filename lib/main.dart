import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/screens/pin_login_screen.dart';
import 'presentation/screens/cart_screen.dart';

void main() async {
  // تأكيد تهيئة أداة الفلاتر قبل استدعاء الأكواد اللازامنية
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة الفايربيس
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيقي فلاتر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Cairo', // استخدم الخط المناسب لتطبيقك إن وجد
      ),
      // الشاشة الأولية عند فتح التطبيق (يمكنك تغييرها إلى PinLoginScreen أو CartScreen)
      initialRoute: '/login',
      routes: {
        '/login': (context) => const PinLoginScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}