import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير والإحصائيات'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildReportCard(
            title: 'إجمالي المبيعات الشهرية',
            value: '45,200 ر.س',
            icon: Icons.trending_up,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            title: 'عدد الطلبات المكتملة',
            value: '128 طلب',
            icon: Icons.check_circle_outline,
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            title: 'إجمالي عدد العملاء',
            value: '64 عميل',
            icon: Icons.people_outline,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildReportCard(
            title: 'عدد الموظفين النشطين',
            value: '12 موظف',
            icon: Icons.badge_outlined,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}