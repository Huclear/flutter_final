import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _userLoggedIn = 'user_logged_in';
  static const String _userId = 'user_id';
  static const String _userEmail = 'user_email';
  static const String _userNickname = 'user_nickname';

  static Future<void> saveUser(
    String userId,
    String email,
    String nickname,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userLoggedIn, true);
    await prefs.setString(_userId, userId);
    await prefs.setString(_userEmail, email);
    await prefs.setString(_userNickname, nickname);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userLoggedIn) ?? false;
  }

  static Future<Map<String, String?>> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString(_userId),
      'userEmail': prefs.getString(_userEmail),
      'userNickname': prefs.getString(_userNickname),
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userLoggedIn);
    await prefs.remove(_userId);
    await prefs.remove(_userEmail);
    await prefs.remove(_userNickname);
  }
}
