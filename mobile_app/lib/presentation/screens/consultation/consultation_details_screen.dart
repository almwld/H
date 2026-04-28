import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import 'prescription_screen.dart';

class ConsultationDetailsScreen extends StatefulWidget {
  final String consultationId;
  const ConsultationDetailsScreen({super.key, required this.consultationId});

  @override
  State<ConsultationDetailsScreen> createState() => _ConsultationDetailsScreenState();
}

class _ConsultationDetailsScreenState extends State<ConsultationDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل الاستشارة')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'د. أحمد محمد',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'باطنية',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text('4.8'),
                              const SizedBox(width: 8),
                              Text('(127 تقييم)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Consultation Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات الاستشارة',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    _buildInfoRow('التاريخ', Helpers.formatDateTime(DateTime.now())),
                    _buildInfoRow('المدة', '15 دقيقة'),
                    _buildInfoRow('الحالة', 'مكتملة', color: Colors.green),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Symptoms
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الأعراض',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    Text(
                      'ألم حاد في البطن + غثيان + ارتفاع في درجة الحرارة',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Diagnosis
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'التشخيص',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Divider(),
                    const Text('التهاب معوي حاد'),
                    const SizedBox(height: 8),
                    const Text('يحتاج إلى راحة تامة وشرب سوائل بكثرة'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.chat),
                    label: const Text('محادثة'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    label: const Text('اتصال'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.local_hospital),
                    label: const Text('إعادة حجز'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PrescriptionScreen()),
                      );
                    },
                    icon: const Icon(Icons.medical_information),
                    label: const Text('الوصفة الطبية'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
