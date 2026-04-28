import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

// ==================== Service Locator ====================
final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const SehtakApp());
}

Future<void> initDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
}

// ==================== App Constants ====================
class AppColors {
  static const primary = Color(0xFF0D9488);
  static const secondary = Color(0xFF14B8A6);
  static const error = Color(0xFFEF4444);
  static const success = Color(0xFF10B981);
  static const white = Color(0xFFFFFFFF);
  static const dark = Color(0xFF1F2937);
  static const grey = Color(0xFF6B7280);
  static const background = Color(0xFFF9FAFB);
}

class AppStrings {
  static const appName = 'صحتك';
  static const welcome = 'مرحباً بك في صحتك';
  static const startConsultation = 'تحدث مع طبيب الآن';
  static const loading = 'جاري التحميل...';
  static const error = 'حدث خطأ، حاول مرة أخرى';
  static const noInternet = 'لا يوجد اتصال بالإنترنت';
  static const login = 'تسجيل الدخول';
  static const register = 'إنشاء حساب';
  static const email = 'البريد الإلكتروني';
  static const password = 'كلمة المرور';
  static const phone = 'رقم الجوال';
  static const name = 'الاسم كاملاً';
}

// ==================== Models ====================
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String userType;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        userType: json['userType'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'userType': userType,
      };
}

// ==================== API Service ====================
class ApiService {
  static const String baseUrl = 'https://api.sehtak.com/v1';

  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'token': 'fake_token_123',
      'user': {
        'id': '1',
        'name': 'أحمد',
        'email': email,
        'phone': '0500000000',
        'userType': 'patient',
      },
    };
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'token': 'fake_token_123',
      'user': {
        'id': '1',
        'name': data['name'],
        'email': data['email'],
        'phone': data['phone'],
        'userType': 'patient',
      },
    };
  }
}

// ==================== Main App ====================
class SehtakApp extends StatelessWidget {
  const SehtakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.cairo().fontFamily,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.dark,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==================== Splash Screen ====================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.health_and_safety, size: 80, color: AppColors.primary),
            const SizedBox(height: 20),
            Text(
              AppStrings.appName,
              style: GoogleFonts.cairo(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}

// ==================== Login Screen ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _apiService = ApiService();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      final token = response['token'] as String;
      final prefs = sl<SharedPreferences>();
      await prefs.setString('token', token);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تسجيل الدخول')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.health_and_safety, size: 64, color: AppColors.primary),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppStrings.email,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'البريد مطلوب' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: AppStrings.password,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'كلمة المرور مطلوبة' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(AppStrings.login, style: const TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text('ليس لديك حساب؟ ${AppStrings.register}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== Register Screen ====================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _apiService = ApiService();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.register({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'password': _passwordController.text,
      });
      final token = response['token'] as String;
      await sl<SharedPreferences>().setString('token', token);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل إنشاء الحساب')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.health_and_safety, size: 64, color: AppColors.primary),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: AppStrings.name,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'الاسم مطلوب' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: AppStrings.email,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'البريد مطلوب' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: AppStrings.phone,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'رقم الجوال مطلوب' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    validator: (v) => v == null || v.length < 6 ? 'كلمة المرور 6 أحرف على الأقل' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(AppStrings.register, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('لديك حساب؟ ${AppStrings.login}'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== Home Screen ====================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.welcome,
              style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.startConsultation,
              style: TextStyle(color: AppColors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SymptomsSelectorScreen()),
                  );
                },
                child: Text(AppStrings.startConsultation, style: const TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'الاستشارات'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// ==================== Symptoms Selector Screen ====================
class SymptomsSelectorScreen extends StatefulWidget {
  const SymptomsSelectorScreen({super.key});

  @override
  State<SymptomsSelectorScreen> createState() => _SymptomsSelectorScreenState();
}

class _SymptomsSelectorScreenState extends State<SymptomsSelectorScreen> {
  final _symptomsController = TextEditingController();
  String? _selectedBodyPart;

  final Map<String, String> bodyParts = {
    'head': 'الرأس',
    'chest': 'الصدر',
    'abdomen': 'البطن',
    'back': 'الظهر',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حدد الأعراض')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('أين تشعر بالألم؟', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: bodyParts.entries.map((entry) {
                return FilterChip(
                  label: Text(entry.value),
                  selected: _selectedBodyPart == entry.key,
                  onSelected: (selected) {
                    setState(() {
                      _selectedBodyPart = selected ? entry.key : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('صف الأعراض', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            TextField(
              controller: _symptomsController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'مثال: أعاني من ألم حاد في البطن...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_symptomsController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('جاري بدء الاستشارة...')),
                  );
                }
              },
              child: const Text('ابدأ الاستشارة', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
