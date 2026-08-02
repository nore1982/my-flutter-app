import 'dart:math';
import 'package:flutter/material.dart';

class CartCheckoutService {
  // 1️⃣ حساب المسافة الجغرافية بين الزبون والمتجر بالكيلومترات
  static double calculateDistanceInKm({
    required double customerLat,
    required double customerLng,
    required double storeLat,
    required double storeLng,
  }) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = cos;
    var a = 0.5 -
        c((storeLat - customerLat) * p) / 2 +
        c(customerLat * p) * c(storeLat * p) * (1 - c((storeLng - customerLng) * p)) / 2;
    return 12742 * asin(sqrt(a)); // المسافة بالكيلومتر
  }

  // 2️⃣ معالجة طلب السلة وتطبيق قيود الأمان (GPS + 20 km + OTP)
  static Future<void> processCartOrder({
    required BuildContext context,
    required bool isGpsEnabled,
    required double customerLat,
    required double customerLng,
    required double storeLat,
    required double storeLng,
    required String deliveryAddress,
    required String customerPhone,
    required String deviceId,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    // 🛑 الشرط الأول: يجب تفعيل خاصية تحديد الموقع (GPS)
    if (!isGpsEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ عذراً، يجب تفعيل خاصية الموقع (GPS) في هاتفك لإتمام الشراء عبر السلة لحماية المتاجر.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🛑 الشرط الثاني: حظر السلة إذا كانت المسافة أكثر من 20 كيلومتر
    double distanceKm = calculateDistanceInKm(
      customerLat: customerLat,
      customerLng: customerLng,
      storeLat: storeLat,
      storeLng: storeLng,
    );

    if (distanceKm > 20.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '⚠️ عذراً، السلة معطلة لأن موقعك يبعد (${distanceKm.toStringAsFixed(1)} كم) وهو أكثر من 20 كم عن المتجر.\nيرجى التواصل عبر الواتساب أو الاتصال المباشر.',
          ),
          backgroundColor: Colors.orange.shade900,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    // ✅ إذا استوفى الشروط: إنشاء رمز OTP لتأكيد الطلب
    String generatedOtp = '4829'; // رمز افتراضي لتأكيد الطلب

    // 3️⃣ عرض نافذة أدخل رمز OTP للزبون
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final otpController = TextEditingController();
        return AlertDialog(
          title: const Text('تأكيد الطلب وحماية المتجر 🛡️'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('المسافة للمتجر: ${distanceKm.toStringAsFixed(1)} كم (ضمن 20 كم)'),
              const SizedBox(height: 8),
              Text('تم إرسال رمز تأكيد إلى رقمك: $customerPhone'),
              const SizedBox(height: 12),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'أدخل رمز التأكيد (OTP)',
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (otpController.text == generatedOtp) {
                  Navigator.pop(context);
                  _sendOrderToMerchant(
                    items: cartItems,
                    phone: customerPhone,
                    location: deliveryAddress.isNotEmpty
                        ? deliveryAddress
                        : '$customerLat, $customerLng',
                    deviceId: deviceId,
                    distanceKm: distanceKm,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ تم إرسال الطلب بنجاح للوجيستيات المتجر!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('❌ الرمز غير صحيح'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('تأكيد الطلب'),
            ),
          ],
        );
      },
    );
  }

  // إرسال بيانات السلة النهائية للوحة تحكم المتجر
  static void _sendOrderToMerchant({
    required List<Map<String, dynamic>> items,
    required String phone,
    required String location,
    required String deviceId,
    required double distanceKm,
  }) {
    debugPrint('=== إرسال بيانات السلة للمتجر ===');
    debugPrint('رقم هاتف الزبون: $phone');
    debugPrint('موقع التوصيل: $location');
    debugPrint('المسافة المحسوبة: ${distanceKm.toStringAsFixed(2)} كم');
    debugPrint('بصمة الهاتف الأمنية (Device ID): $deviceId');
    debugPrint('عناصر السلة: $items');
  }
}