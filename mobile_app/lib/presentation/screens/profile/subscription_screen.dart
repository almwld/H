import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlan = 1;
  final List<Map<String, dynamic>> _plans = [
    {
      'name': AppStrings.basic,
      'price': '49',
      'period': AppStrings.perMonth,
      'features': [
        '5 استشارات شهرياً',
        'دعم نصي فقط',
        'توصيل عادي',
      ],
      'color': Colors.blue,
      'recommended': false,
    },
    {
      'name': AppStrings.premium,
      'price': '99',
      'period': AppStrings.perMonth,
      'features': [
        'استشارات غير محدودة',
        'مستوصفات فيديو',
        'توصيل مجاني',
        'أولوية في الحجز',
      ],
      'color': AppColors.primary,
      'recommended': true,
    },
    {
      'name': AppStrings.family,
      'price': '189',
      'period': AppStrings.perMonth,
      'features': [
        '6 أفراد',
        'جميع مميزات الممتاز',
        'حسابات منفصلة',
        'تتبع عائلي',
      ],
      'color': Colors.orange,
      'recommended': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.subscriptions)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _plans.length,
              itemBuilder: (context, index) {
                final plan = _plans[index];
                return _buildPlanCard(plan, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: AppStrings.subscribe,
              onPressed: _subscribe,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan, int index) {
    final isSelected = _selectedPlan == index;
    return Card(
      elevation: isSelected ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(color: plan['color'] as Color, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedPlan = index),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (plan['recommended'])
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'مميز',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    plan['price'],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    plan['period'],
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...plan['features'].map<Widget>((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, size: 16, color: plan['color']),
                    const SizedBox(width: 8),
                    Text(feature),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _subscribe() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الاشتراك'),
        content: Text('هل تريد الاشتراك في باقة ${_plans[_selectedPlan]['name']}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم الاشتراك بنجاح')),
              );
            },
            child: const Text('تأكيد'),
          ),
        ],
      ),
    );
  }
}
