import 'dart:io';
import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class UserApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> getProfile() async {
    return await _client.get(ApiEndpoints.profile);
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    return await _client.put(ApiEndpoints.updateProfile, data: data);
  }

  Future<Map<String, dynamic>> getMedicalHistory() async {
    return await _client.get(ApiEndpoints.medicalHistory);
  }

  Future<Map<String, dynamic>> updateMedicalHistory(Map<String, dynamic> data) async {
    return await _client.put(ApiEndpoints.medicalHistory, data: data);
  }

  Future<Map<String, dynamic>> uploadAvatar(File image) async {
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(image.path),
    });
    return await _client.post(ApiEndpoints.uploadAvatar, data: formData);
  }

  Future<void> deleteAccount() async {
    await _client.delete(ApiEndpoints.deleteAccount);
  }
}
