import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int _currentStep = 2;
  final List<Map<String, dynamic>> _steps = [
    {'label': 'تم الطلب', 'icon': Icons.check_circle, 'completed': true, 'time': '14:30', 'date': '2024-01-15'},
    {'label': 'تم التجهيز', 'icon': Icons.inventory, 'completed': true, 'time': '14:45', 'date': '2024-01-15'},
    {'label': 'في الطريق', 'icon': Icons.local_shipping, 'completed': false, 'time': '15:00', 'date': '2024-01-15'},
    {'label': 'تم التوصيل', 'icon': Icons.home, 'completed': false, 'time': null, 'date': null},
  ];

  Future<void> _callDriver() async {
    final phoneUrl = 'tel:0500000000';
    if (await canLaunchUrl(Uri.parse(phoneUrl))) {
      await launchUrl(Uri.parse(phoneUrl));
    } else {
      Helpers.showSnackBar(context, 'لا يمكن إجراء المكالمة', isError: true);
    }
  }

  Future<void> _openMap() async {
    final url = 'https://maps.google.com/?q=24.7136,46.6753';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Helpers.showSnackBar(context, 'لا يمكن فتح الخريطة', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع الطلب')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Status Stepper
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
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
                                      : _currentStep > index
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
                                  fontSize: 10,
                                  color: _steps[index]['completed'] || _currentStep > index
                                      ? Colors.green
                                      : Colors.grey.shade600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (_steps[index]['time'] != null)
                                Text(
                                  _steps[index]['time'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    // Progress Indicator
                    LinearProgressIndicator(
                      value: _currentStep / (_steps.length - 1),
                      backgroundColor: Colors.grey.shade200,
                      color: Colors.green,
                      height: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Order Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات الطلب',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    _buildInfoRow('رقم الطلب', widget.orderId),
                    _buildInfoRow('تاريخ الطلب', '2024-01-15 14:30'),
                    _buildInfoRow('الإجمالي', '150 ريال'),
                    _buildInfoRow('طريقة الدفع', 'بطاقة ائتمان'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Delivery Info
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
                      leading: const CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: const Text('أحمد علي'),
                      subtitle: const Text('مندوب التوصيل'),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone, color: Colors.teal),
                        onPressed: _callDriver,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.teal),
                      title: const Text('عنوان التوصيل'),
                      subtitle: const Text('الرياض، حي الملقا، شارع الأمير محمد بن سلمان، building 1234'),
                      trailing: IconButton(
                        icon: const Icon(Icons.map, color: Colors.teal),
                        onPressed: _openMap,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.access_time, color: Colors.teal),
                      title: const Text('الوقت المتوقع'),
                      subtitle: const Text('30-45 دقيقة'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Updates Timeline
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
                    _buildUpdateItem('تم تأكيد الطلب', '14:30', true),
                    _buildUpdateItem('تم تجهيز الطلب', '14:45', true),
                    _buildUpdateItem('المندوب في الطريق', '15:00', false),
                    _buildUpdateItem('قريب منك', null, false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Helpers.showConfirmDialog(
                        context,
                        title: 'إلغاء الطلب',
                        message: 'هل أنت متأكد من إلغاء هذا الطلب؟',
                      );
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('إلغاء الطلب'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('تأكيد الاستلام'),
                          content: const Text('هل تم استلام الطلب بنجاح؟'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('ليس بعد'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Helpers.showSnackBar(context, 'شكراً لك! تم تأكيد الاستلام');
                              },
                              child: const Text('نعم، تم الاستلام'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                    label: const Text('تأكيد الاستلام'),
                  ),
                ),
              ],
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

  Widget _buildUpdateItem(String update, String? time, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green : Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              update,
              style: TextStyle(
                fontWeight: isCompleted ? FontWeight.w500 : FontWeight.normal,
                color: isCompleted ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ),
          if (time != null)
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
