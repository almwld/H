import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../services/api/storage_service.dart';
import '../../../widgets/icons/platform_icon.dart';
import '../../../widgets/icons/doctor_icon.dart';
import '../../../widgets/icons/pharmacy_icon.dart';
import '../../../widgets/icons/consultation_icon.dart';
import '../../../widgets/icons/profile_icon.dart';
import '../../../widgets/icons/ai_icon.dart';
import '../../../widgets/icons/history_icon.dart';
import '../auth/login_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Map<String, dynamic>> _features = const [
    {'icon': 'doctor', 'title': 'استشارة فورية', 'desc': 'تحدث مع طبيب في دقائق', 'color': Colors.teal},
    {'icon': 'consultation', 'title': 'مكالمات فيديو', 'desc': 'استشارات مرئية عالية الجودة', 'color': Colors.blue},
    {'icon': 'pharmacy', 'title': 'توصيل الأدوية', 'desc': 'استلم أدويتك في المنزل', 'color': Colors.green},
    {'icon': 'history', 'title': 'سجل طبي', 'desc': 'تتبع تاريخك الصحي', 'color': Colors.orange},
    {'icon': 'ai', 'title': 'ذكاء اصطناعي', 'desc': 'تشخيص أولي ذكي', 'color': Colors.purple},
    {'icon': 'profile', 'title': 'باقات مرنة', 'desc': 'اختر الخطة المناسبة', 'color': Colors.red},
  ];

  Widget _buildFeatureIcon(String type, Color color) {
    switch (type) {
      case 'doctor': return DoctorIcon(color: color);
      case 'consultation': return ConsultationIcon(color: color);
      case 'pharmacy': return PharmacyIcon(color: color);
      case 'history': return HistoryIcon(color: color);
      case 'ai': return AiIcon(color: color);
      case 'profile': return ProfileIcon(color: color);
      default: return DoctorIcon(color: color);
    }
  }

  void _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('تسجيل خروج')),
        ],
      ),
    );
    if (confirmed == true) {
      final storage = sl<StorageService>();
      await storage.clear();
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صحتك'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'تسجيل الخروج',
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const PlatformIcon(size: 80),
                  const SizedBox(height: 10),
                  Text(
                    'مرحباً بك في صحتك',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: _features.length,
                    itemBuilder: (context, index) {
                      final f = _features[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildFeatureIcon(f['icon'] as String, f['color'] as Color),
                              const SizedBox(height: 12),
                              Text(f['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(f['desc'] as String, style: TextStyle(fontSize: 12, color: Colors.grey.shade600), textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(16)),
                    child: const Column(
                      children: [
                        PlatformIcon(size: 40),
                        SizedBox(height: 8),
                        Text('صحتك - رعاية صحية للجميع', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
