import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<void> saveUserLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLoggedIn', isLoggedIn);
  }

  static Future<bool> getUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('userLoggedIn') ?? false;
  }
}
