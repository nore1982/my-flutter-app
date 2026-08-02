import 'package:flutter/material.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final String employeeName;
  final String employeeRole;
  final String employeePhone;

  const EmployeeDetailsScreen({
    super.key,
    required this.employeeName,
    required this.employeeRole,
    required this.employeePhone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الموظف'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline, color: Colors.blue),
                      title: const Text('اسم الموظف'),
                      subtitle: Text(employeeName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.work_outline, color: Colors.blue),
                      title: const Text('المسمى الوظيفي'),
                      subtitle: Text(employeeRole, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone_outlined, color: Colors.blue),
                      title: const Text('رقم الجوال'),
                      subtitle: Text(employeePhone, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}