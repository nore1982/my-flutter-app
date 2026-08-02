import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // الفلاتر الزمنية
  String _selectedPeriod = 'شهري';

  // دالة محاكاة لتصدير البيانات للشركات
  void _exportReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تصدير تقرير السوق ($_selectedPeriod) بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('تحليلات وتقارير السوق', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'تصدير التقرير للشركات',
            onPressed: _exportReport,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // شريط الفلاتر
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(Icons.filter_alt, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text('نطاق التقرير: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _selectedPeriod,
                      items: ['شهري', 'موسمي', 'سنوي'].map((String val) {
                        return DropdownMenuItem(value: val, child: Text(val));
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedPeriod = val);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // بطاقات الإحصائيات
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: 'إجمالي الطلبات',
                    value: '12,450',
                    subtitle: '+18% زيادة شهرية',
                    icon: Icons.shopping_cart,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMetricCard(
                    title: 'الأكثر طلباً',
                    value: 'صيانة وتكييف',
                    subtitle: '42% من الطلبات',
                    icon: Icons.trending_up,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // الأكثر طلباً في السوق
            const Text(
              'أعلى الخدمات طلباً من المستهلكين',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDemandRow('صيانة تكييف وأجهزة', 85, Colors.green),
                    const Divider(height: 24),
                    _buildDemandRow('تنظيف منازل ومقرات', 65, Colors.blue),
                    const Divider(height: 24),
                    _buildDemandRow('تأسيس سباكة وكهرباء', 40, Colors.purple),
                    const Divider(height: 24),
                    _buildDemandRow('خدمات استشارية وتقنية', 25, Colors.orange),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // زر تصدير التقرير
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _exportReport,
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text(
                  'تحميل التقرير المكتمل للبيع والتصدير',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDemandRow(String name, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text('$percentage%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey.shade200,
          color: color,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}