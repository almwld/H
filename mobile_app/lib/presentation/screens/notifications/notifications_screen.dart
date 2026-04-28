import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> _notifications = const [
    {
      'title': 'تذكير بموعد',
      'message': 'لديك استشارة مع د. أحمد بعد ساعة',
      'time': 'منذ 5 دقائق',
      'isRead': false,
      'icon': Icons.event,
    },
    {
      'title': 'تم وصول الطلب',
      'message': 'طلبك رقم ORD-001 قد تم توصيله',
      'time': 'منذ ساعتين',
      'isRead': true,
      'icon': Icons.local_shipping,
    },
    {
      'title': 'عرض خاص',
      'message': 'خصم 20% على باقة الاشتراك الممتاز',
      'time': 'منذ يوم',
      'isRead': true,
      'icon': Icons.local_offer,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('تحديد الكل كمقروء'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: notification['isRead'] == false
                  ? Colors.teal
                  : Colors.grey.shade300,
              child: Icon(
                notification['icon'],
                color: notification['isRead'] == false ? Colors.white : Colors.grey,
              ),
            ),
            title: Text(
              notification['title'],
              style: TextStyle(
                fontWeight: notification['isRead'] == false
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            subtitle: Text(notification['message']),
            trailing: Text(
              notification['time'],
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
