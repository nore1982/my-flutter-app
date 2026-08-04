import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String userType;

  const DashboardScreen({
    super.key,
    this.userType = 'company', // قيمة افتراضية تجنباً لأي خطأ
  });

  @override
  Widget build(BuildContext context) {
    final bool isCompany = userType == 'company';

    return Scaffold(
      appBar: AppBar(
        title: Text(isCompany ? 'لوحة تحكم المتجر' : 'لوحة تحكم الحرفي'),
        backgroundColor: isCompany ? Colors.blue.shade800 : Colors.teal.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              color: isCompany ? Colors.blue.shade50 : Colors.teal.shade50,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isCompany ? Colors.blue : Colors.teal,
                  child: Icon(
                    isCompany ? Icons.store : Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  isCompany ? 'حساب متجر مفعّل' : 'حساب حرفي مفعّل',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('الحالة: نشط وموثق'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(Icons.shopping_bag, color: Colors.orange, size: 30),
                          const SizedBox(height: 8),
                          const Text('12', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(isCompany ? 'الطلبات' : 'الخدمات', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 30),
                          const SizedBox(height: 8),
                          const Text('4.8', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text('التقييم', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}