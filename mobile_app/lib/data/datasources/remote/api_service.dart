import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../models/user_model.dart';
import '../../models/consultation_model.dart';
import '../../models/doctor_model.dart';
import '../../models/pharmacy_model.dart';
import '../../models/order_model.dart';
import '../../models/prescription_model.dart';

class ApiService {
  late Dio _dio;
  final SharedPreferences _prefs;

  ApiService(this._prefs) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = _prefs.getString('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await _prefs.clear();
        }
        return handler.next(error);
      },
    ));
  }

  // Auth
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _dio.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final response = await _dio.post(ApiEndpoints.register, data: userData);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> verifyOtp(String otp) async {
    final response = await _dio.post(ApiEndpoints.verifyOtp, data: {'otp': otp});
    return response.data as Map<String, dynamic>;
  }

  // User
  Future<UserModel> getProfile() async {
    final response = await _dio.get(ApiEndpoints.profile);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> data) async {
    final response = await _dio.put(ApiEndpoints.updateProfile, data: data);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  // Consultations
  Future<List<ConsultationModel>> getConsultations() async {
    final response = await _dio.get(ApiEndpoints.consultations);
    final List data = response.data as List;
    return data.map((json) => ConsultationModel.fromJson(json)).toList();
  }

  Future<ConsultationModel> startConsultation(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.startConsultation, data: data);
    return ConsultationModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ConsultationModel> getConsultationDetails(String id) async {
    final response = await _dio.get('${ApiEndpoints.consultationDetails}/$id');
    return ConsultationModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> sendMessage(String consultationId, String message) async {
    final response = await _dio.post(ApiEndpoints.sendMessage, data: {
      'consultationId': consultationId,
      'message': message,
    });
    return response.data as Map<String, dynamic>;
  }

  // Doctors
  Future<List<DoctorModel>> getDoctors({String? specialization}) async {
    final queryParams = specialization != null ? {'specialization': specialization} : null;
    final response = await _dio.get(ApiEndpoints.doctors, queryParameters: queryParams);
    final List data = response.data as List;
    return data.map((json) => DoctorModel.fromJson(json)).toList();
  }

  // Pharmacies
  Future<List<PharmacyModel>> getNearbyPharmacies(double lat, double lng) async {
    final response = await _dio.get(ApiEndpoints.nearbyPharmacies, queryParameters: {
      'lat': lat,
      'lng': lng,
    });
    final List data = response.data as List;
    return data.map((json) => PharmacyModel.fromJson(json)).toList();
  }

  // Orders
  Future<OrderModel> createOrder(Map<String, dynamic> data) async {
    final response = await _dio.post(ApiEndpoints.orders, data: data);
    return OrderModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<OrderModel> trackOrder(String orderId) async {
    final response = await _dio.get('${ApiEndpoints.trackOrder}/$orderId');
    return OrderModel.fromJson(response.data as Map<String, dynamic>);
  }

  // Prescriptions
  Future<PrescriptionModel> getPrescription(String id) async {
    final response = await _dio.get('${ApiEndpoints.prescriptions}/$id');
    return PrescriptionModel.fromJson(response.data as Map<String, dynamic>);
  }

  // Subscriptions
  Future<Map<String, dynamic>> getCurrentSubscription() async {
    final response = await _dio.get(ApiEndpoints.currentSubscription);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> upgradeSubscription(String planId) async {
    final response = await _dio.post(ApiEndpoints.upgradeSubscription, data: {'planId': planId});
    return response.data as Map<String, dynamic>;
  }

  // AI
  Future<Map<String, dynamic>> aiTriage(Map<String, dynamic> symptoms) async {
    final response = await _dio.post(ApiEndpoints.aiTriage, data: symptoms);
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> aiChatbot(String message) async {
    final response = await _dio.post(ApiEndpoints.aiChatbot, data: {'message': message});
    return response.data as Map<String, dynamic>;
  }

  // Notifications
  Future<List<Map<String, dynamic>>> getNotifications() async {
    final response = await _dio.get(ApiEndpoints.notifications);
    return (response.data as List).cast<Map<String, dynamic>>();
  }

  Future<void> markNotificationAsRead(String id) async {
    await _dio.post('${ApiEndpoints.markAsRead}/$id');
  }
}
