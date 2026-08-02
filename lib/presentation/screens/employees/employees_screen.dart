import 'package:flutter/material.dart';

// نموذج بيانات الموظف
class Employee {
  String name;
  String jobTitle;
  String branch;
  String phone;

  Employee({
    required this.name,
    required this.jobTitle,
    required this.branch,
    required this.phone,
  });
}

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  // قائمة الموظفين الإفتراضية
  final List<Employee> _employees = [
    Employee(name: 'أحمد محمود', jobTitle: 'مدير فرع', branch: 'الفرع الرئيسي', phone: '0501234567'),
    Employee(name: 'سارة العتيبي', jobTitle: 'محاسب', branch: 'فرع جدة', phone: '0559876543'),
    Employee(name: 'محمد علي', jobTitle: 'موضف خدمة عملاء', branch: 'فرع الدمام', phone: '0541122334'),
  ];

  // متحكمات الحقول
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // 1️⃣ نافذة إضافة موظف جديد
  void _showAddEmployeeDialog() {
    _nameController.clear();
    _jobController.clear();
    _branchController.clear();
    _phoneController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('إضافة موظف جديد', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'اسم الموظف', prefixIcon: Icon(Icons.person)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال اسم الموظف' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _jobController,
                    decoration: const InputDecoration(labelText: 'المسمى الوظيفي', prefixIcon: Icon(Icons.work)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال المسمى الوظيفي' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _branchController,
                    decoration: const InputDecoration(labelText: 'الفرع التابع له', prefixIcon: Icon(Icons.store)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال اسم الفرع' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'رقم الجوال', prefixIcon: Icon(Icons.phone)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال رقم الجوال' : null,
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
                    _employees.add(
                      Employee(
                        name: _nameController.text.trim(),
                        jobTitle: _jobController.text.trim(),
                        branch: _branchController.text.trim(),
                        phone: _phoneController.text.trim(),
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت إضافة الموظف بنجاح!'), backgroundColor: Colors.green),
                  );
                }
              },
              child: const Text('حفظ الموظف', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // 2️⃣ نافذة تعديل بيانات الموظف
  void _showEditEmployeeDialog(Employee employee) {
    _nameController.text = employee.name;
    _jobController.text = employee.jobTitle;
    _branchController.text = employee.branch;
    _phoneController.text = employee.phone;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('تعديل بيانات الموظف', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'اسم الموظف', prefixIcon: Icon(Icons.person)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال اسم الموظف' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _jobController,
                    decoration: const InputDecoration(labelText: 'المسمى الوظيفي', prefixIcon: Icon(Icons.work)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال المسمى الوظيفي' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _branchController,
                    decoration: const InputDecoration(labelText: 'الفرع التابع له', prefixIcon: Icon(Icons.store)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال اسم الفرع' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'رقم الجوال', prefixIcon: Icon(Icons.phone)),
                    validator: (val) => val == null || val.trim().isEmpty ? 'يرجى إدخال رقم الجوال' : null,
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
                    employee.name = _nameController.text.trim();
                    employee.jobTitle = _jobController.text.trim();
                    employee.branch = _branchController.text.trim();
                    employee.phone = _phoneController.text.trim();
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تحديث بيانات الموظف بنجاح!'), backgroundColor: Colors.blue),
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

  // 3️⃣ دالة حذف موظف
  void _deleteEmployee(Employee employee) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: Text('هل أنت تأكد من رغبتك في حذف الموظف "${employee.name}"؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _employees.remove(employee);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف الموظف بنجاح'), backgroundColor: Colors.red),
                );
              },
              child: const Text('حذف', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _branchController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('إدارة الموظفين', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEmployeeDialog,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _employees.length,
        itemBuilder: (context, index) {
          final employee = _employees[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.blue.shade50,
                child: Text(
                  employee.name.isNotEmpty ? employee.name[0] : 'M',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18),
                ),
              ),
              title: Text(
                employee.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('${employee.jobTitle} - ${employee.branch}', style: TextStyle(color: Colors.grey.shade700)),
                  Text('الجوال: ${employee.phone}', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditEmployeeDialog(employee);
                  } else if (value == 'delete') {
                    _deleteEmployee(employee);
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
            ),
          );
        },
      ),
    );
  }
}