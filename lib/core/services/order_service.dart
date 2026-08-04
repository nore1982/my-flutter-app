import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// إرسال طلب جديد إلى Firebase Firestore
  Future<bool> createOrder({
    required String userId,
    required String userName,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
    required double distanceKm,
    required String deliveryAddress,
  }) async {
    try {
      await _db.collection('orders').add({
        'userId': userId,
        'userName': userName,
        'items': items,
        'totalPrice': totalPrice,
        'distanceKm': distanceKm,
        'deliveryAddress': deliveryAddress,
        'status': 'pending', // حالة الطلب قيد الانتظار
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('خطأ أثناء حفظ الطلب في الفايربيس: $e');
      return false;
    }
  }
}