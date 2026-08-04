import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// التحقق من الـ PIN واسترجاع نوع المستخدم (company أو individual)
  Future<Map<String, dynamic>?> verifyPin(String pin) async {
    try {
      // البحث في مجموعة users عن المستخدم صاحب الـ PIN المدخل
      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('pin', isEqualTo: pin)
          .where('status', isEqualTo: 'approved') // تأكيد أن الحساب مقبول
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        return {
          'userType': data['userType'], // 'company' أو 'individual'
          'name': data['name'] ?? 'مستخدم',
          'userId': snapshot.docs.first.id,
        };
      }
    } catch (e) {
      // ignore: avoid_print
      print('خطأ في الاتصال بالـ Firestore: $e');
    }
    return null;
  }
}