import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int _selectedMethod = 0;
  final List<Map<String, dynamic>> _methods = [
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'last4': '4242', 'expiry': '12/25'},
    {'name': 'مدى', 'icon': Icons.account_balance, 'last4': '1234', 'expiry': '08/26'},
    {'name': 'Apple Pay', 'icon': Icons.apple, 'last4': null, 'expiry': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('طرق الدفع')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _methods.length,
              itemBuilder: (context, index) {
                final method = _methods[index];
                return RadioListTile<int>(
                  value: index,
                  groupValue: _selectedMethod,
                  onChanged: (value) => setState(() => _selectedMethod = value!),
                  title: Text(method['name']),
                  subtitle: method['last4'] != null
                      ? Text('**** **** **** ${method['last4']} - ينتهي ${method['expiry']}')
                      : null,
                  secondary: Icon(method['icon'], color: AppColors.primary),
                  controlAffinity: ListTileControlAffinity.trailing,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('إضافة بطاقة جديدة'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'حفظ التغييرات',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
