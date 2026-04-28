import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/custom_button.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  final List<String> _chronicDiseases = [];
  final List<String> _allergies = [];
  final List<Map<String, String>> _medications = [];

  final List<String> _availableDiseases = [
    'السكري',
    'ارتفاع ضغط الدم',
    'أمراض القلب',
    'الربو',
    'الغدة الدرقية',
    'الأنيميا',
  ];

  final List<String> _availableAllergies = [
    'البنسلين',
    'المكسرات',
    'البيض',
    'الحليب',
    'الغلوتين',
    'اللاتكس',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السجل الطبي')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blood Type
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'فصيلة الدم',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(value: 'A+', child: Text('A+')),
                        DropdownMenuItem(value: 'A-', child: Text('A-')),
                        DropdownMenuItem(value: 'B+', child: Text('B+')),
                        DropdownMenuItem(value: 'B-', child: Text('B-')),
                        DropdownMenuItem(value: 'O+', child: Text('O+')),
                        DropdownMenuItem(value: 'O-', child: Text('O-')),
                        DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                        DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                      ],
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Chronic Diseases
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الأمراض المزمنة',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _availableDiseases.map((disease) {
                        return FilterChip(
                          label: Text(disease),
                          selected: _chronicDiseases.contains(disease),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _chronicDiseases.add(disease);
                              } else {
                                _chronicDiseases.remove(disease);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Allergies
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الحساسيات',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _availableAllergies.map((allergy) {
                        return FilterChip(
                          label: Text(allergy),
                          selected: _allergies.contains(allergy),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _allergies.add(allergy);
                              } else {
                                _allergies.remove(allergy);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'حفظ التغييرات',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
