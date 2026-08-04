import 'package:flutter/material.dart';

class OrderNotification {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  bool isRead;

  OrderNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    this.isRead = false,
  });
}

class NotificationService {
  // قائمة افتراضية للإشعارات الواردة
  static final List<OrderNotification> _notifications = [
    OrderNotification(
      id: '1',
      title: 'طلب جديد #1024',
      body: 'تم استلام طلب جديد ضمن نطاق 20 كم. يرجى المراجعة والتأكيد.',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    OrderNotification(
      id: '2',
      title: 'تأكيد عملية شحن',
      body: 'قام العميل بتأكيد الرمز (OTP) الخاص بالطلب #1021.',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
    ),
  ];

  static List<OrderNotification> getNotifications() => _notifications;

  static int get unreadCount => _notifications.where((n) => !n.isRead).length;

  static void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index].isRead = true;
    }
  }
}