import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LocalizationService.dart';


class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';

  LanguageProvider() {
    _loadLanguage();
  }

  String get languageCode => _languageCode;

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language_code') ?? 'en';
    await LocalizationService.load(_languageCode);
    notifyListeners();
  }

  Future<void> changeLanguage(String languageCode) async {
    if (_languageCode != languageCode) {
      _languageCode = languageCode;
      await LocalizationService.load(languageCode);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('language_code', languageCode);
      notifyListeners();
    }
  }
}
