import 'package:flutter/material.dart';
import '../../core/services/order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final OrderService _orderService = OrderService();
  bool _isSubmitting = false;

  // مسافة التوصيل (مثال تجريبي)
  double distanceInKm = 25.0; // تجريبياً 25 كم لاختبار التوجيه الهاتفي

  void _checkout() async {
    // 1. فحص المسافة: إذا تجاوزت 20 كم يُمنع الحفظ سحابياً وتظهر رسالة الطلب الهاتفي
    if (distanceInKm > 20.0) {
      _showPhoneOrderDialog();
      return;
    }

    // 2. إذا كانت المسافة ضمن 20 كم يتم الحفظ في Firestore
    setState(() => _isSubmitting = true);

    bool success = await _orderService.createOrder(
      userId: 'user_123',
      userName: 'عميل تجريبي',
      items: [
        {'name': 'منتج 1', 'price': 50, 'quantity': 1},
        {'name': 'منتج 2', 'price': 30, 'quantity': 2},
      ],
      totalPrice: 110.0,
      distanceKm: distanceInKm,
      deliveryAddress: 'عنوان التوصيل المحدد',
    );

    setState(() => _isSubmitting = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال الطلب وحفظه في الفايربيس بنجاح! 🎉'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء حفظ الطلب.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showPhoneOrderDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.phone_in_talk, color: Colors.orange),
            SizedBox(width: 8),
            Text('خارج نطاق التوصيل المباشر', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Text(
          'مسافة التوصيل الحالية ($distanceInKm كم) تتجاوز الحد المسموح به للطلب التلقائي (20 كم).\n\nيمكنك إتمام الطلب مباشرة عن طريق الاتصال الهاتفي بخدمة العملاء لتنسيق التوصيل الخاص.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('جاري الاتصال بخدمة العملاء... 📞'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: const Icon(Icons.phone),
            label: const Text('اتصال الآن'),
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.blue),
                title: const Text('مسافة التوصيل المحسوبة'),
                subtitle: Text('$distanceInKm كم من موقعك'),
                trailing: TextButton(
                  onPressed: () {
                    // التبديل بين الأرقام لاختبار الحالتين (أكبر وأقل من 20 كم)
                    setState(() {
                      distanceInKm = distanceInKm > 20.0 ? 15.0 : 25.0;
                    });
                  },
                  child: const Text('تغيير المسافة للتجربة'),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSubmitting ? null : _checkout,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'تأكيد وإتمام الطلب',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}