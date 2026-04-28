import 'api_client.dart';

class AuthApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _client.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    return await _client.post('/auth/register', data: data);
  }

  Future<void> forgotPassword(String email) async {
    await _client.post('/auth/forgot-password', data: {'email': email});
  }

  Future<void> logout() async {
    await _client.post('/auth/logout');
  }
}
