import 'package:flutter/material.dart';

// الرجوع خطوة للخلف للوصول لشاشات مجلد screens
import '../analytics_screen.dart';
import '../cart_screen.dart';
import '../company_registration_screen.dart';
import '../customers_screen.dart';

class DashboardScreen extends StatelessWidget {
  final String? userType;

  const DashboardScreen({super.key, this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userType == 'company' ? 'لوحة تحكم الشركة' : 'لوحة التحكم الرئيسية'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardItem(
              context,
              title: 'السلة والطلبات',
              icon: Icons.shopping_cart,
              color: Colors.orange,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'الإحصائيات',
              icon: Icons.analytics,
              color: Colors.green,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AnalyticsScreen()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'العملاء',
              icon: Icons.people,
              color: Colors.purple,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomersScreen()),
              ),
            ),
            _buildDashboardItem(
              context,
              title: 'تسجيل شركة/فرع',
              icon: Icons.business,
              color: Colors.teal,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CompanyRegistrationScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}