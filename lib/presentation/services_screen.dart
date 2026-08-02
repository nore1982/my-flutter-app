import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<Map<String, String>> _services = [
    {'name': 'خدمات الأفراد', 'category': 'أفراد', 'price': '150 ر.س'},
    {'name': 'خدمات المتاجر والشركات', 'category': 'متاجر', 'price': '500 ر.س'},
  ];

  // دالة لإضافة أو تعديل خدمة
  void _showServiceDialog({Map<String, String>? service, int? index}) {
    final nameController = TextEditingController(text: service?['name'] ?? '');
    final categoryController = TextEditingController(text: service?['category'] ?? '');
    final priceController = TextEditingController(text: service?['price'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'إضافة خدمة جديدة' : 'تعديل بيانات الخدمة', textAlign: TextAlign.right),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'اسم الخدمة'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'القسم (فردي / متجر)'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'السعر التقديري'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    if (index == null) {
                      _services.add({
                        'name': nameController.text,
                        'category': categoryController.text.isNotEmpty ? categoryController.text : 'عام',
                        'price': priceController.text.isNotEmpty ? priceController.text : '0 ر.س',
                      });
                    } else {
                      _services[index] = {
                        'name': nameController.text,
                        'category': categoryController.text,
                        'price': priceController.text,
                      };
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  // دالة تأكيد الحذف
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من حذف هذه الخدمة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _services.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الخدمات والأقسام'),
        centerTitle: true,
      ),
      body: _services.isEmpty
          ? const Center(child: Text('لا توجد خدمات مسجلة حالياً', style: TextStyle(fontSize: 18, color: Colors.grey)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: const Icon(Icons.room_service, color: Colors.orange),
                    ),
                    title: Text(service['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text('القسم: ${service['category']} | السعر: ${service['price']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showServiceDialog(service: service, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showServiceDialog(),
        icon: const Icon(Icons.add),
        label: const Text('إضافة خدمة'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}