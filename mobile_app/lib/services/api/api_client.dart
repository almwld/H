import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class ApiClient {
  late Dio _dio;
  final StorageService _storage = StorageService();
  static const String baseUrl = 'https://api.sehtak.com/v1';

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await _storage.clear();
        }
        String errorMessage = 'حدث خطأ في الاتصال';
        if (error.response != null) {
          errorMessage = error.response?.data['message'] ?? 'خطأ في الخادم';
        } else if (error.type == DioExceptionType.connectionTimeout) {
          errorMessage = 'انتهت مهلة الاتصال';
        } else if (error.type == DioExceptionType.unknown) {
          errorMessage = 'لا يوجد اتصال بالإنترنت';
        }
        return handler.reject(DioException(requestOptions: error.requestOptions, message: errorMessage));
      },
    ));
  }

  Dio get dio => _dio;

  Future<Map<String, dynamic>> get(String path) async {
    final response = await _dio.get(path);
    return response.data;
  }

  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    final response = await _dio.post(path, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> put(String path, {dynamic data}) async {
    final response = await _dio.put(path, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> delete(String path) async {
    final response = await _dio.delete(path);
    return response.data;
  }
}
