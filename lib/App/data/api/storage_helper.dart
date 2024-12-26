
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageHelper {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  static Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userDetails', userDetails.toString());
  }

  static Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('userDetails');
    if (userDetailsString != null) {
      return Map<String, dynamic>.from(json.decode(userDetailsString));
    }
    return null;
  }
}