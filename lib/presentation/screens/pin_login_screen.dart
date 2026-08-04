import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'dashboard/dashboard_screen.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final TextEditingController _pinController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _loginWithPin() async {
    String pin = _pinController.text.trim();

    if (pin.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال الرقم السري المكون من 6 أرقام'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // 1. التحقق أولاً عبر Firebase Firestore
    Map<String, dynamic>? userData = await _authService.verifyPin(pin);

    setState(() => _isLoading = false);

    if (!mounted) return;

    // 2. التوجيه عند النجاح في Firebase
    if (userData != null) {
      _showSuccessSnackBar('مرحباً بك ${userData['name']}!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            userType: userData['userType'] ?? 'company',
          ),
        ),
      );
    } else {
      // 3. دعم الأرقام السريعة للتجربة المحلية (Fallback)
      if (pin == '111111') {
        _showSuccessSnackBar('تم تسجيل الدخول بنجاح كـ (متجر/شركة)');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(userType: 'company'),
          ),
        );
      } else if (pin == '222222') {
        _showSuccessSnackBar('تم تسجيل الدخول بنجاح كـ (فرد/حرفي)');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(userType: 'individual'),
          ),
        );
      } else {
        _showErrorDialog(
          'الرقم السري غير صحيح أو لم يتم الموافقة عليه في قاعدة البيانات.',
        );
      }
    }
  }

  void _showSuccessSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 8),
            Text('خطأ في الدخول'),
          ],
        ),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول بالرقم السري'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_person_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'أدخل الرقم السري الخاص بك (PIN)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'الرقم السري المكون من 6 أرقام المستلم بعد الموافقة',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                obscureText: true,
                style: const TextStyle(
                  fontSize: 28,
                  letterSpacing: 10,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: '******',
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade800, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isLoading ? null : _loginWithPin,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'تسجيل الدخول',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}