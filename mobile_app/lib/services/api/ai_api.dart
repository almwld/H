import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class AiApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> triage(Map<String, dynamic> symptoms) async {
    return await _client.post(ApiEndpoints.aiTriage, data: symptoms);
  }

  Future<Map<String, dynamic>> checkSymptoms(Map<String, dynamic> symptoms) async {
    return await _client.post(ApiEndpoints.aiSymptoms, data: symptoms);
  }

  Future<Map<String, dynamic>> chatbot(String message, {String? context}) async {
    return await _client.post(ApiEndpoints.aiChatbot, data: {
      'message': message,
      'context': context,
    });
  }

  Future<Map<String, dynamic>> followUp(String consultationId) async {
    return await _client.post('${ApiEndpoints.aiFollowup}/$consultationId');
  }

  Future<Map<String, dynamic>> generatePrescription(Map<String, dynamic> diagnosis) async {
    return await _client.post(ApiEndpoints.aiPrescription, data: diagnosis);
  }
}
