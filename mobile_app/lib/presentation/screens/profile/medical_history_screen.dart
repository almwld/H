import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../widgets/custom_button.dart';

class MedicalHistoryScreen extends StatefulWidget {
  const MedicalHistoryScreen({super.key});

  @override
  State<MedicalHistoryScreen> createState() => _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  String? _selectedBloodType;
  final List<String> _chronicDiseases = [];
  final List<String> _allergies = [];
  final List<Map<String, String>> _currentMedications = [];

  final List<String> _availableDiseases = [
    'السكري',
    'ارتفاع ضغط الدم',
    'أمراض القلب',
    'الربو',
    'الغدة الدرقية',
    'الأنيميا',
    'التحصين ضد التيتانوس',
    'الصرع',
    'الاكتئاب',
  ];

  final List<String> _availableAllergies = [
    'البنسلين',
    'المكسرات',
    'البيض',
    'الحليب',
    'الغلوتين',
    'اللاتكس',
    'الصويا',
    'السمك',
    'المحار',
  ];

  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];

  void _addMedication() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة دواء'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'اسم الدواء',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'الجرعة',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                labelText: 'المدة',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Helpers.showSnackBar(context, 'تم إضافة الدواء');
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('السجل الطبي')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blood Type Selection
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
                      value: _selectedBloodType,
                      hint: const Text('اختر فصيلة الدم'),
                      items: _bloodTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBloodType = value;
                        });
                      },
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
                      runSpacing: 8,
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
                          selectedColor: AppColors.primary.withOpacity(0.2),
                          checkmarkColor: AppColors.primary,
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
                      runSpacing: 8,
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
                          selectedColor: AppColors.error.withOpacity(0.2),
                          checkmarkColor: AppColors.error,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Current Medications
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'الأدوية الحالية',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_circle, color: AppColors.primary),
                          onPressed: _addMedication,
                        ),
                      ],
                    ),
                    const Divider(),
                    if (_currentMedications.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('لا توجد أدوية حالية'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'حفظ التغييرات',
              onPressed: () {
                Helpers.showSnackBar(context, 'تم حفظ السجل الطبي بنجاح');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
