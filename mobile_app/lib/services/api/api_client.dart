import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late Dio _dio;
  final SharedPreferences _prefs = GetIt.instance<SharedPreferences>();
  static const String baseUrl = 'https://api.sehtak.com/v1';

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = _prefs.getString('token');
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }

  Dio get dio => _dio;
  Future<Map<String, dynamic>> get(String path) async => await _dio.get(path);
  Future<Map<String, dynamic>> post(String path, {dynamic data}) async => await _dio.post(path, data: data);
  Future<Map<String, dynamic>> put(String path, {dynamic data}) async => await _dio.put(path, data: data);
  Future<Map<String, dynamic>> delete(String path) async => await _dio.delete(path);
}
