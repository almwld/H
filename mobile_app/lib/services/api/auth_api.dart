import '../../core/constants/api_endpoints.dart';
import 'api_client.dart';

class AuthApi {
  final ApiClient _client = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _client.post(ApiEndpoints.login, data: {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    return await _client.post(ApiEndpoints.register, data: userData);
  }

  Future<Map<String, dynamic>> verifyOtp(String otp, String verificationId) async {
    return await _client.post(ApiEndpoints.verifyOtp, data: {
      'otp': otp,
      'verificationId': verificationId,
    });
  }

  Future<Map<String, dynamic>> resendOtp(String phone) async {
    return await _client.post(ApiEndpoints.resendOtp, data: {'phone': phone});
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    return await _client.post(ApiEndpoints.forgotPassword, data: {'email': email});
  }

  Future<Map<String, dynamic>> resetPassword(String token, String newPassword) async {
    return await _client.post(ApiEndpoints.resetPassword, data: {
      'token': token,
      'newPassword': newPassword,
    });
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    return await _client.post(ApiEndpoints.refreshToken, data: {
      'refreshToken': refreshToken,
    });
  }

  Future<void> logout() async {
    await _client.post(ApiEndpoints.logout);
  }
}
