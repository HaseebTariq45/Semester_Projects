import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // Prevent making instances
  MySharedPref._();

  // SharedPreferences storage instance
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _lightThemeKey = 'is_theme_light';

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Allow setting SharedPreferences manually (useful for testing)
  static void setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// Set theme as light
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// Get the current theme type (light or dark)
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ??
      true; // Default to light theme if not set

  /// Save generated FCM token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// Get generated FCM token
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);

  /// Clear all data from SharedPreferences
  static Future<void> clear() async => await _sharedPreferences.clear();
}
