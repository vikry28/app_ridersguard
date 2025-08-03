import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}

class SessionHelper {
  static Future<bool> isLoggedIn() async {
    final token = SharedPrefs.getString('accessToken');
    return token != null && token.isNotEmpty;
  }

  static Future<bool> isOnboardingDone() async {
    final flag = SharedPrefs.getString('onboarding_done');
    return flag == 'true';
  }

  static Future<void> logout() async {
    await SharedPrefs.remove('accessToken');
    await SharedPrefs.remove('refreshToken');
    await SharedPrefs.remove('user');
  }
}
