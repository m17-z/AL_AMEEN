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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userDetails', json.encode(userDetails));
  }

  static Future<Map<String, dynamic>?> getUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userDetails = prefs.getString('userDetails');
    if (userDetails != null) {
      return json.decode(userDetails);
    }
    return null;
  }

  static Future<void> saveCurrentLoan(Map<String, dynamic> loanData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentLoan', json.encode(loanData));
  }

  static Future<Map<String, dynamic>?> getCurrentLoan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? loanData = prefs.getString('currentLoan');
    if (loanData != null) {
      return json.decode(loanData);
    }
    return null;
  }
}