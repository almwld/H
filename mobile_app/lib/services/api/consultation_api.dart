import 'api_client.dart';

class ConsultationApi {
  final ApiClient _client = ApiClient();
  Future<List<dynamic>> getConsultations() async => await _client.get('/consultations');
  Future<Map<String, dynamic>> startConsultation(Map<String, dynamic> data) async =>
      await _client.post('/consultations/start', data: data);
}
