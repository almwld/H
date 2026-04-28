import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'services/api/storage_service.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/main_screen.dart';

final sl = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  runApp(const SehtakApp());
}

class SehtakApp extends StatelessWidget {
  const SehtakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صحتك',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: GoogleFonts.cairo().fontFamily,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService();
    if (storage.isLoggedIn()) {
      return const MainScreen();
    } else {
      return const LoginScreen();
    }
  }
}
