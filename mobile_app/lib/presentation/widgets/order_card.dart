import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final double total;
  final String status;
  final List<String> items;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'delivered':
        return 'تم التوصيل';
      case 'shipped':
        return 'تم الشحن';
      case 'pending':
        return 'قيد المعالجة';
      case 'cancelled':
        return 'ملغي';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'طلب رقم: $orderId',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusText(status),
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                items.join('، '),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                  Text(
                    '$total ريال',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
