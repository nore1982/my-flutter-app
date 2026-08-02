import 'package:flutter/material.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;

  void _loginWithPin() async {
    String pin = _pinController.text.trim();

    if (pin.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الرقم السري المكون من 6 أرقام')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // محاكاة الاتصال
    setState(() => _isLoading = false);

    // التحقق التوضيحي للأكواد
    if (pin == '111111') {
      _showSuccessSnackBar('تم تسجيل الدخول بنجاح كـ (متجر/شركة)');
      Navigator.pushReplacementNamed(context, '/'); // العودة للرئيسية
    } else if (pin == '222222') {
      _showSuccessSnackBar('تم تسجيل الدخول بنجاح كـ (فرد/حرفي)');
      Navigator.pushReplacementNamed(context, '/');
    } else {
      _showErrorDialog('الرقم السري غير صحيح، يرجى التثبت وإعادة المحاولة.');
    }
  }

  void _showSuccessSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.green),
    );
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطأ في الدخول'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'أدخل الرقم السري الخاص بك (PIN)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'الرقم المكون من 6 أرقام المستلم أثناء التسجيل',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              obscureText: true,
              style: const TextStyle(fontSize: 28, letterSpacing: 12),
              decoration: const InputDecoration(
                hintText: '******',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isLoading ? null : _loginWithPin,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('دخول', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}