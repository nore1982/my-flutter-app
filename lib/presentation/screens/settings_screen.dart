import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات النظام'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'التفضيلات العامة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.blue),
                  title: const Text('الوضع المظلم'),
                  subtitle: const Text('تفعيل المظهر الداكن للتطبيق'),
                  value: isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('الإشعارات'),
                  subtitle: const Text('تلقي تنبيهات الطلبات والعملاء'),
                  value: notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blue),
                  title: const Text('لغة النظام'),
                  subtitle: Text(selectedLanguage),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // نافذة اختيار اللغة مستقبلاً
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'الحساب والدعم',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.green),
                  title: const Text('عن النظام'),
                  subtitle: const Text('الإصدار 1.0.0'),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'تسجيل الخروج',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // العودة لشاشة تسجيل الدخول مستقبلاً
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}