import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';

class PrescriptionScreen extends StatelessWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الوصفة الطبية')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.medical_services, size: 40, color: Colors.teal),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'وصفة طبية',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'صادر عن: د. أحمد محمد',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'سارية',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Patient Info
            const Text(
              'بيانات المريض',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('الاسم', 'أحمد محمد'),
                    _buildInfoRow('العمر', '32 سنة'),
                    _buildInfoRow('الجنس', 'ذكر'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Diagnosis
            const Text(
              'التشخيص',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow('الحالة', 'التهاب معوي حاد'),
                    _buildInfoRow('تاريخ التشخيص', Helpers.formatDate(DateTime.now())),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Medicines
            const Text(
              'الأدوية',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildMedicineItem('أموكسيسيلين', '500mg', 'مرتين يومياً', '7 أيام'),
                    const Divider(),
                    _buildMedicineItem('باراسيتامول', '500mg', 'عند الحاجة', '3 أيام'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Instructions
            const Text(
              'تعليمات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  '1. تناول الدواء بعد الطعام\n2. الراحة التامة لمدة يومين\n3. شرب سوائل بكثرة\n4. مراجعة الطبيب إذا استمرت الأعراض',
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
                    icon: const Icon(Icons.download),
                    label: const Text('تحميل PDF'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'شراء الدواء',
                    onPressed: () {},
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

  Widget _buildMedicineItem(String name, String dosage, String frequency, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(dosage, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(frequency),
          ),
          Expanded(
            flex: 2,
            child: Text(duration),
          ),
        ],
      ),
    );
  }
}

// Helper function for date formatting
class Helpers {
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
