import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences? sharedPreferences;
  static final String _userKey = 'user';

  static Future<SharedPreferences> _sharedPreferencesInstance() async {
    if (sharedPreferences == null) {
      return await SharedPreferences.getInstance();
    } else {
      return sharedPreferences!;
    }
  }

  static Future<void> saveUser(String user) async {
    final prefs = await _sharedPreferencesInstance();
    await prefs.setString(_userKey, user);
  }

  static Future<String?> getUser() async {
    final prefs = await _sharedPreferencesInstance();
    return prefs.getString(_userKey);
  }

  static Future<void> deleteUser() async {
    final prefs = await _sharedPreferencesInstance();
    await prefs.remove(_userKey);
  }
}
