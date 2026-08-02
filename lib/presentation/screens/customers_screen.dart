import 'package:flutter/material.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  // قائمة وهمية للمشتركين
  final List<Map<String, dynamic>> _customers = [
    {
      'name': 'شركة الأمل للتجارة',
      'phone': '0912345678',
      'plan': 'الباقة الذهبية',
      'status': 'نشط',
      'expiryDate': '2026/12/31',
      'color': Colors.green,
    },
    {
      'name': 'مؤسسة التقنية الحديثة',
      'phone': '0922223344',
      'plan': 'الباقة الفضية',
      'status': 'قريب الانتهاء',
      'expiryDate': '2026/08/15',
      'color': Colors.orange,
    },
    {
      'name': 'مركز السلام الطبي',
      'phone': '0919988776',
      'plan': 'الباقة البرونزية',
      'status': 'منتهي',
      'expiryDate': '2026/07/01',
      'color': Colors.red,
    },
    {
      'name': 'مكتب الإبداع للهندسة',
      'phone': '0945566778',
      'plan': 'الباقة الذهبية',
      'status': 'نشط',
      'expiryDate': '2027/01/10',
      'color': Colors.green,
    },
  ];

  void _addNewCustomer() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ميزة إضافة مشترك جديد ستتاح قريباً!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('إدارة المشتركين', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewCustomer,
        backgroundColor: Colors.blue,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('مشترك جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ملخص الإحصائيات
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('إجمالي المشتركين', '${_customers.length}', Icons.group, Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('الاشتراكات النشطة', '2', Icons.check_circle, Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text(
              'قائمة المشتركين الحالية',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // قائمة المشتركين
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final customer = _customers[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: const Icon(Icons.business, color: Colors.blue),
                    ),
                    title: Text(
                      customer['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الهاتف: ${customer['phone']}'),
                          Text('نوع الاشتراك: ${customer['plan']}'),
                          Text('ينتهي في: ${customer['expiryDate']}'),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: (customer['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: customer['color']),
                      ),
                      child: Text(
                        customer['status'],
                        style: TextStyle(
                          color: customer['color'],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}