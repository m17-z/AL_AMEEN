import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String userDetailsKey = 'userDetails';
  static const String tokenKey = 'token'; // Add a key for the token

  static Future<void> saveUserDetails(Map<String, dynamic> userDetails) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userDetailsKey, json.encode(userDetails));
  }

  static Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString(userDetailsKey);
    if (userDetailsString != null) {
      return json.decode(userDetailsString);
    }
    return null;
  }

  static Future<void> clearUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(userDetailsKey);
  }

  // Add the getToken method
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Optionally, add a method to save the token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(tokenKey, token);
  }
}