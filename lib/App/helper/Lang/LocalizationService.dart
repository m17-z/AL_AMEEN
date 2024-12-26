import 'dart:convert';
import 'package:flutter/services.dart';

class LocalizationService {
  static Map<String, String>? _localizedStrings;

  static Future<void> load(String languageCode) async {
    String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
    _localizedStrings = json.decode(jsonString).cast<String, String>();
  }

  static String? translate(String key) {
    return _localizedStrings?[key];
  }
}
