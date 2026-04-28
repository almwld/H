import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/user_model.dart';
import '../../models/subscription_model.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // Token
  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  String? getToken() {
    return _prefs.getString('token');
  }

  Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  // User
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString('user', jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final String? userJson = _prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  Future<void> removeUser() async {
    await _prefs.remove('user');
  }

  // Subscription
  Future<void> saveSubscription(SubscriptionModel subscription) async {
    await _prefs.setString('subscription', jsonEncode(subscription.toJson()));
  }

  SubscriptionModel? getSubscription() {
    final String? subJson = _prefs.getString('subscription');
    if (subJson != null) {
      return SubscriptionModel.fromJson(jsonDecode(subJson));
    }
    return null;
  }

  // Cart
  Future<void> saveCart(List<Map<String, dynamic>> cart) async {
    await _prefs.setString('cart', jsonEncode(cart));
  }

  List<Map<String, dynamic>> getCart() {
    final String? cartJson = _prefs.getString('cart');
    if (cartJson != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(cartJson));
    }
    return [];
  }

  Future<void> clearCart() async {
    await _prefs.remove('cart');
  }

  // Settings
  Future<void> setThemeMode(bool isDark) async {
    await _prefs.setBool('isDarkMode', isDark);
  }

  bool isDarkMode() {
    return _prefs.getBool('isDarkMode') ?? false;
  }

  Future<void> setLanguage(String languageCode) async {
    await _prefs.setString('language', languageCode);
  }

  String getLanguage() {
    return _prefs.getString('language') ?? 'ar';
  }

  // Clear all
  Future<void> clearAll() async {
    await _prefs.clear();
  }

  bool isLoggedIn() {
    return getToken() != null;
  }
}
