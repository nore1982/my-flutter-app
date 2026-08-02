import 'package:flutter/material.dart';

class ContactButtonsWidget extends StatelessWidget {
  final String phoneNumber;
  final String whatsappNumber;
  final String locationUrl;
  final VoidCallback? onDirectCall;
  final VoidCallback? onWhatsappTap;
  final VoidCallback? onLocationTap;

  const ContactButtonsWidget({
    super.key,
    required this.phoneNumber,
    required this.whatsappNumber,
    required this.locationUrl,
    this.onDirectCall,
    this.onWhatsappTap,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 📞 زر الاتصال المباشر
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onDirectCall ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('جاري الاتصال بـ: $phoneNumber')),
                      );
                    },
                icon: const Icon(Icons.phone, size: 20),
                label: const Text('اتصال', style: TextStyle(fontSize: 13)),
              ),
            ),
            const SizedBox(width: 8),

            // 💬 زر الواتساب
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onWhatsappTap ??
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('فتح الواتساب: $whatsappNumber')),
                      );
                    },
                icon: const Icon(Icons.chat, size: 20),
                label: const Text('واتساب', style: TextStyle(fontSize: 13)),
              ),
            ),
            const SizedBox(width: 8),

            // 📍 زر تحديد الموقع
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.orange.shade100,
                foregroundColor: Colors.orange.shade900,
              ),
              onPressed: onLocationTap ??
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('موقع المتجر: $locationUrl')),
                    );
                  },
              icon: const Icon(Icons.location_on),
              tooltip: 'عرض موقع المتجر',
            ),
          ],
        ),
      ),
    );
  }
}