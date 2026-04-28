import 'api_client.dart';

class UserApi {
  final ApiClient _client = ApiClient();
  Future<Map<String, dynamic>> getProfile() async => await _client.get('/user/profile');
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async =>
      await _client.put('/user/profile', data: data);
}
