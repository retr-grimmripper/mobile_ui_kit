import 'package:hive_ce_flutter/hive_flutter.dart';

class AuthService {
  static const String _boxName = 'authBox';
  static const String _tokenKey = 'authToken';

  // Initialize Hive and open the authentication box
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  // Check if the user is currently logged in
  static bool get isLoggedIn {
    return Hive.box(_boxName).containsKey(_tokenKey);
  }

  // Simulate a login request
  static Future<bool> login(String email, String password) async {
    // Simulate network delay for a REST API call
    await Future.delayed(const Duration(seconds: 2));

    // Basic validation
    if (email.isNotEmpty && password.isNotEmpty) {
      final box = Hive.box(_boxName);
      await box.put(_tokenKey, 'dummy_secure_token_123');
      return true;
    }
    return false;
  }

  // Clear the token to log out
  static Future<void> logout() async {
    final box = Hive.box(_boxName);
    await box.delete(_tokenKey);
  }
}