import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class StorageService {
  final SharedPreferences _prefs = GetIt.instance<SharedPreferences>();

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _prefs.setString(_userKey, user.toString());
  }

  Future<void> clear() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
  }

  bool isLoggedIn() {
    return getToken() != null;
  }
}
