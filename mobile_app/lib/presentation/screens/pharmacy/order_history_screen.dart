import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/order_card.dart';
import 'order_tracking_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  final List<Map<String, dynamic>> _orders = const [
    {
      'id': 'ORD-001',
      'date': '15/01/2024',
      'total': 150.0,
      'status': 'delivered',
      'items': ['أموكسيسيلين', 'باراسيتامول'],
    },
    {
      'id': 'ORD-002',
      'date': '10/01/2024',
      'total': 89.0,
      'status': 'delivered',
      'items': ['فيتامين سي'],
    },
    {
      'id': 'ORD-003',
      'date': '05/01/2024',
      'total': 220.0,
      'status': 'cancelled',
      'items': ['مضاد حيوي', 'مسكن'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد طلبات سابقة',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return OrderCard(
                  orderId: order['id'],
                  date: order['date'],
                  total: order['total'],
                  status: order['status'],
                  items: order['items'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OrderTrackingScreen(orderId: order['id']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
