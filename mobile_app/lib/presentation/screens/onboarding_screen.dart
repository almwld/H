import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _onboardingData = [
    OnboardingModel(
      title: 'استشارة فورية',
      description: 'تحدث مع طبيب مختص في دقائق',
      icon: Icons.medical_services,
      color: Colors.teal,
    ),
    OnboardingModel(
      title: 'توصيل العلاج',
      description: 'استلم أدويتك في منزلك',
      icon: Icons.local_shipping,
      color: Colors.blue,
    ),
    OnboardingModel(
      title: 'متابعة ذكية',
      description: 'تتبع حالتك الصحية بذكاء اصطناعي',
      icon: Icons.psychology,
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return _buildOnboardingPage(data);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage < _onboardingData.length - 1)
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_onboardingData.length - 1);
                    },
                    child: const Text('تخطي'),
                  )
                else
                  const SizedBox(width: 60),
                Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.teal
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                if (_currentPage < _onboardingData.length - 1)
                  FloatingActionButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    mini: true,
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.arrow_forward),
                  )
                else
                  ElevatedButton(
                    onPressed: _completeOnboarding,
                    child: const Text('ابدأ الآن'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingModel data) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: data.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: 100,
              color: data.color,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            data.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
