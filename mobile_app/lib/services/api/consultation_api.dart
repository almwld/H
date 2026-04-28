import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class ConsultationApi {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> getConsultations() async {
    return await _client.get(ApiEndpoints.consultations);
  }

  Future<Map<String, dynamic>> getConsultationDetails(String id) async {
    return await _client.get('${ApiEndpoints.consultationDetails}/$id');
  }

  Future<Map<String, dynamic>> startConsultation(Map<String, dynamic> data) async {
    return await _client.post(ApiEndpoints.startConsultation, data: data);
  }

  Future<Map<String, dynamic>> sendMessage(String consultationId, String message) async {
    return await _client.post(ApiEndpoints.sendMessage, data: {
      'consultationId': consultationId,
      'message': message,
    });
  }

  Future<Map<String, dynamic>> endConsultation(String consultationId) async {
    return await _client.post('${ApiEndpoints.endConsultation}/$consultationId');
  }

  Future<Map<String, dynamic>> rateConsultation(String consultationId, double rating, String review) async {
    return await _client.post(ApiEndpoints.rateConsultation, data: {
      'consultationId': consultationId,
      'rating': rating,
      'review': review,
    });
  }

  Future<List<dynamic>> getDoctors({String? specialization}) async {
    final queryParams = specialization != null ? {'specialization': specialization} : null;
    return await _client.get(ApiEndpoints.doctors, queryParams: queryParams);
  }

  Future<Map<String, dynamic>> getDoctorDetails(String doctorId) async {
    return await _client.get('${ApiEndpoints.doctorDetails}/$doctorId');
  }

  Future<List<dynamic>> getDoctorSchedule(String doctorId, DateTime date) async {
    return await _client.get(ApiEndpoints.doctorSchedule, queryParams: {
      'doctorId': doctorId,
      'date': date.toIso8601String(),
    });
  }

  Future<List<dynamic>> getDoctorReviews(String doctorId) async {
    return await _client.get('${ApiEndpoints.doctorReviews}/$doctorId');
  }
}
