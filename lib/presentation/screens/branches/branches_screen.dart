import 'package:flutter/material.dart';

// نموذج بيانات الفرع
class Branch {
  String name;
  String city;
  String phone;

  Branch({required this.name, required this.city, required this.phone});
}

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  // قائمة الفروع الإفتراضية
  final List<Branch> _branches = [
    Branch(name: 'الفرع الرئيسي', city: 'الرياض', phone: '0112345678'),
    Branch(name: 'فرع جدة', city: 'جدة', phone: '0123456789'),
    Branch(name: 'فرع الدمام', city: 'الدمام', phone: '0134567890'),
  ];

  // متحكمات الحقول
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // 1️⃣ نافذة إضافة فرع جديد
  void _showAddBranchDialog() {
    _nameController.clear();
    _cityController.clear();
    _phoneController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'إضافة فرع جديد',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم الفرع',
                      prefixIcon: Icon(Icons.store),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال الاسم' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'المدينة',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال المدينة' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'رقم الجوال',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال الرقم' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _branches.add(
                      Branch(
                        name: _nameController.text.trim(),
                        city: _cityController.text.trim(),
                        phone: _phoneController.text.trim(),
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت إضافة الفرع بنجاح!'), backgroundColor: Colors.green),
                  );
                }
              },
              child: const Text('حفظ الفرع', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 2️⃣ نافذة تعديل بيانات فرع موجود
  void _showEditBranchDialog(Branch branch) {
    _nameController.text = branch.name;
    _cityController.text = branch.city;
    _phoneController.text = branch.phone;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'تعديل بيانات الفرع',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'اسم الفرع',
                      prefixIcon: Icon(Icons.store),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال الاسم' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'المدينة',
                      prefixIcon: Icon(Icons.location_city),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال المدينة' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'رقم الجوال',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال الرقم' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    branch.name = _nameController.text.trim();
                    branch.city = _cityController.text.trim();
                    branch.phone = _phoneController.text.trim();
                  });
                  Navigator.pop(context); // إغلاق التعديل
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تحديث بيانات الفرع بنجاح!'), backgroundColor: Colors.blue),
                  );
                }
              },
              child: const Text('تحديث البيانات', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 3️⃣ دالة تأكيد الحذف
  void _deleteBranch(Branch branch) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: Text('هل أنت تأكد من رغبتك في حذف "${branch.name}"؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _branches.remove(branch);
                });
                Navigator.pop(context); // إغلاق تأكيد الحذف
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف الفرع بنجاح'), backgroundColor: Colors.red),
                );
              },
              child: const Text('حذف', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 4️⃣ القائمة السفلية عند النقر على أي فرع (تعديل + حذف)
  void _showBranchOptions(Branch branch) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                branch.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 20),
              
              // زر التعديل
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('تعديل البيانات'),
                onTap: () {
                  Navigator.pop(context); // إغلاق النافذة السفلية
                  _showEditBranchDialog(branch); // فتح التعديل
                },
              ),
              
              // زر الحذف
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('حذف الفرع', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context); // إغلاق النافذة السفلية
                  _deleteBranch(branch); // تنفيذ الحذف
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'إدارة الفروع',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBranchDialog,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _branches.length,
        itemBuilder: (context, index) {
          final branch = _branches[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.domain, color: Colors.green, size: 28),
              ),
              title: Text(
                branch.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'المدينة: ${branch.city} - الجوال: ${branch.phone}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              // قائمة الإجراءات السريعة في أقصى اليسار (تعديل + حذف)
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditBranchDialog(branch);
                  } else if (value == 'delete') {
                    _deleteBranch(branch);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Text('تعديل'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red, size: 20),
                        SizedBox(width: 8),
                        Text('حذف', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () => _showBranchOptions(branch), // فتح الخيارات عند الضغط
            ),
          );
        },
      ),
    );
  }
}