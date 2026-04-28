import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 1;
  final List<Map<String, dynamic>> _steps = [
    {'label': 'تم الطلب', 'icon': Icons.check_circle, 'completed': true},
    {'label': 'تم التجهيز', 'icon': Icons.inventory, 'completed': true},
    {'label': 'في الطريق', 'icon': Icons.local_shipping, 'completed': false},
    {'label': 'تم التوصيل', 'icon': Icons.home, 'completed': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الطلب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Stepper
                    Row(
                      children: List.generate(_steps.length, (index) {
                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: _steps[index]['completed']
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _steps[index]['icon'],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _steps[index]['label'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _steps[index]['completed']
                                      ? Colors.green
                                      : Colors.grey.shade600,
                                ),
                              ),
                              if (index < _steps.length - 1)
                                Container(
                                  width: double.infinity,
                                  height: 2,
                                  color: _steps[index]['completed']
                                      ? Colors.green
                                      : Colors.grey.shade300,
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    // Order Info
                    _buildInfoRow('رقم الطلب', widget.orderId),
                    _buildInfoRow('تاريخ الطلب', '2024-01-15 14:30'),
                    _buildInfoRow('الإجمالي', '150 ريال'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات التوصيل',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('المندوب'),
                      subtitle: const Text('أحمد علي'),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.teal),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('عنوان التوصيل'),
                      subtitle: Text('الرياض، حي الملقا، شارع الأمير محمد بن سلمان'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time),
                      title: const Text('الوقت المتوقع'),
                      subtitle: const Text('30-45 دقيقة'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'تحديثات الطلب',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    _buildUpdateItem('تم تأكيد الطلب', '14:30'),
                    _buildUpdateItem('تم تجهيز الطلب', '14:45'),
                    _buildUpdateItem('المندوب في الطريق', '15:00'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String update, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(update)),
          Text(time, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
