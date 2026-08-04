import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإحصائيات والتقارير الحية'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data?.docs ?? [];
          final int totalOrders = orders.length;

          double totalRevenue = 0;
          int pendingOrders = 0;
          int acceptedOrders = 0;

          for (var doc in orders) {
            final data = doc.data() as Map<String, dynamic>;
            totalRevenue += (data['totalPrice'] ?? 0).toDouble();
            if (data['status'] == 'pending') {
              pendingOrders++;
            } else if (data['status'] == 'accepted') {
              acceptedOrders++;
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildStatCard(
                  title: 'إجمالي المبيعات',
                  value: '${totalRevenue.toStringAsFixed(2)} د.ل',
                  icon: Icons.monetization_on,
                  color: Colors.green,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  title: 'إجمالي الطلبات',
                  value: '$totalOrders طلب',
                  icon: Icons.shopping_bag,
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  title: 'طلبات قيد الانتظار',
                  value: '$pendingOrders طلب',
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  title: 'طلبات تم قبولها',
                  value: '$acceptedOrders طلب',
                  icon: Icons.check_circle_outline,
                  color: Colors.teal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}