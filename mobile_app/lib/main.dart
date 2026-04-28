import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasources/remote/api_service.dart';
import 'data/datasources/local/storage_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/consultation/consultation_bloc.dart';
import 'presentation/screens/splash_screen.dart';
import 'core/themes/app_theme.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);

  // Register Services
  sl.registerLazySingleton(() => StorageService(sl<SharedPreferences>()));
  sl.registerLazySingleton(() => ApiService(sl<SharedPreferences>()));

  // Register BLoCs
  sl.registerFactory(() => AuthBloc());
  sl.registerFactory(() => ConsultationBloc());

  runApp(const SehtakApp());
}

class SehtakApp extends StatelessWidget {
  const SehtakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صحتك',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
