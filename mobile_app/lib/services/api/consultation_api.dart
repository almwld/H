import 'api_client.dart';

class ConsultationApi {
  final ApiClient _client = ApiClient();

  Future<List<dynamic>> getConsultations() async {
    final response = await _client.get('/consultations');
    return response['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getConsultationDetails(String id) async {
    return await _client.get('/consultations/$id');
  }

  Future<Map<String, dynamic>> startConsultation(Map<String, dynamic> data) async {
    return await _client.post('/consultations/start', data: data);
  }

  Future<Map<String, dynamic>> sendMessage(String consultationId, String message) async {
    return await _client.post('/consultations/messages', data: {
      'consultationId': consultationId,
      'message': message,
    });
  }

  Future<Map<String, dynamic>> endConsultation(String consultationId) async {
    return await _client.post('/consultations/end/$consultationId');
  }

  Future<Map<String, dynamic>> rateConsultation(String consultationId, double rating, String review) async {
    return await _client.post('/consultations/rate', data: {
      'consultationId': consultationId,
      'rating': rating,
      'review': review,
    });
  }

  Future<List<dynamic>> getDoctors({String? specialization}) async {
    final queryParams = specialization != null ? {'specialization': specialization} : null;
    final response = await _client.get('/doctors');
    return response['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> getDoctorDetails(String doctorId) async {
    return await _client.get('/doctors/$doctorId');
  }

  Future<List<dynamic>> getDoctorSchedule(String doctorId, DateTime date) async {
    final response = await _client.get('/doctors/$doctorId/schedule');
    return response['data'] as List<dynamic>;
  }

  Future<List<dynamic>> getDoctorReviews(String doctorId) async {
    final response = await _client.get('/doctors/$doctorId/reviews');
    return response['data'] as List<dynamic>;
  }
}
