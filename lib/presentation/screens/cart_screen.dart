import 'package:flutter/material.dart';
import '../../services/cart_checkout_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartCheckoutService _checkoutService = CartCheckoutService();
  bool _isLoading = false;

  // قيم افتراضية للتجربة (يمكن ربطها بموقع المستخدم والمتاجر الحقيقية)
  final double userLat = 32.8872; // طرابلس
  final double userLng = 13.1913;
  
  // موقع متجر افتراضي قريب (أقل من 20 كم)
  final double storeLat = 32.8900;
  final double storeLng = 13.1800;

  void _handleCheckout() async {
    setState(() => _isLoading = true);

    // 1️⃣ التحقق من شرط المسافة (20 كم)
    bool isWithinRange = await _checkoutService.isWithinAllowedDistance(
      userLat: userLat,
      userLng: userLng,
      storeLat: storeLat,
      storeLng: storeLng,
    );

    setState(() => _isLoading = false);

    if (!isWithinRange) {
      _showErrorDialog('عذراً، لا يمكن إتمام الطلب لأن المسافة بينك وبين المتجر تتجاوز 20 كم.');
      return;
    }

    // 2️⃣ طلب إدخال رمز التحقق OTP
    _showOtpDialog();
  }

  void _showOtpDialog() {
    final TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الطلب', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('تم إرسال رمز التحقق (OTP) إلى هاتفك:'),
            const SizedBox(height: 12),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(
                hintText: '0000',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () {
              if (otpController.text.length == 4) {
                Navigator.pop(context);
                _showSuccessDialog();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('يرجى إدخال رمز مكون من 4 أرقام')),
                );
              }
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('تنبيه المسافة'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
        content: const Text(
          'تم تأكيد طلبك بنجاح! سيصلك إشعار بالبضائع والشحن.',
          textAlign: TextAlign.center,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // العودة للرئيسية
            },
            child: const Text('العودة للرئيسية'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.shopping_bag, color: Colors.blue),
                      title: Text('منتج تجريبي 1'),
                      subtitle: Text('الكمية: 2'),
                      trailing: Text('50 د.ل', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('الإجمالي:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('50 د.ل', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isLoading ? null : _handleCheckout,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('إتمام الطلب والتأكيد', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}