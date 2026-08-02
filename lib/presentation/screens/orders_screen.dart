import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> orders = [
      {'id': '#ORD-1001', 'client': 'شركة التقنية المتقدمة', 'status': 'قيد المعالجة', 'amount': '1,500 ر.س'},
      {'id': '#ORD-1002', 'client': 'مؤسسة الأفق التجارية', 'status': 'مكتمل', 'amount': '3,200 ر.س'},
      {'id': '#ORD-1003', 'client': 'شركة الحلول السريعة', 'status': 'ملغي', 'amount': '850 ر.س'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الطلبات'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          
          // تحديد لون حالة الطلب
          Color statusColor = Colors.blue;
          if (order['status'] == 'مكتمل') {
            statusColor = Colors.green;
          } else if (order['status'] == 'ملغي') {
            statusColor = Colors.red;
          } else if (order['status'] == 'قيد المعالجة') {
            statusColor = Colors.orange;
          }

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: statusColor.withOpacity(0.1),
                child: Icon(Icons.shopping_cart, color: statusColor),
              ),
              title: Text(
                'رقم الطلب: ${order['id']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('العميل: ${order['client']} - المبلغ: ${order['amount']}'),
              trailing: Chip(
                label: Text(
                  order['status']!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: statusColor,
              ),
              onTap: () {
                // تفاصيل الطلب مستقبلاً
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // إضافة طلب جديد مستقبلاً
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}