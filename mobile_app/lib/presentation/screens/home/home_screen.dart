import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/doctor_model.dart';
import '../../widgets/doctor_card.dart';
import '../consultation/symptoms_selector_screen.dart';
import '../doctor/doctor_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DoctorModel> _recentDoctors = [];

  @override
  void initState() {
    super.initState();
    _loadDummyDoctors();
  }

  void _loadDummyDoctors() {
    _recentDoctors = [
      DoctorModel(
        id: '1',
        name: 'د. أحمد محمد',
        specialization: 'باطنية',
        rating: 4.8,
        reviewCount: 127,
        experienceYears: 12,
        isAvailable: true,
        consultationFee: 99,
      ),
      DoctorModel(
        id: '2',
        name: 'د. سارة علي',
        specialization: 'أطفال',
        rating: 4.9,
        reviewCount: 203,
        experienceYears: 8,
        isAvailable: true,
        consultationFee: 89,
      ),
      DoctorModel(
        id: '3',
        name: 'د. خالد محمود',
        specialization: 'جلدية',
        rating: 4.7,
        reviewCount: 95,
        experienceYears: 10,
        isAvailable: false,
        consultationFee: 109,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مرحباً بك في صحتك',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'احصل على الرعاية الصحية المناسبة من منزلك',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Start Consultation Button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SymptomsSelectorScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.medical_services, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  AppStrings.startConsultation,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'خدمات سريعة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildQuickAction(
                icon: Icons.medical_services,
                label: 'استشارة',
                color: Colors.teal,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SymptomsSelectorScreen(),
                    ),
                  );
                },
              ),
              _buildQuickAction(
                icon: Icons.local_pharmacy,
                label: 'صيدليات',
                color: Colors.blue,
                onTap: () {},
              ),
              _buildQuickAction(
                icon: Icons.analytics,
                label: 'تحاليل',
                color: Colors.orange,
                onTap: () {},
              ),
              _buildQuickAction(
                icon: Icons.psychology,
                label: 'الذكاء الاصطناعي',
                color: Colors.purple,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Doctors
          const Text(
            'أطباؤك المفضلون',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recentDoctors.length,
              itemBuilder: (context, index) {
                return DoctorCard(
                  doctor: _recentDoctors[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DoctorProfileScreen(
                          doctorId: _recentDoctors[index].id,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Health Tips
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lightbulb, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نصيحة اليوم',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'اشرب 8 أكواب من الماء يومياً للحفاظ على ترطيب جسمك',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
