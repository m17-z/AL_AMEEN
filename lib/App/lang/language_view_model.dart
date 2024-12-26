import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum AppLanguage { Arabic, English }

class LanguageController extends GetxController {
  var selectedLanguage = AppLanguage.Arabic.obs; // Observable variable to track selected language

  // Function to save the selected language to GetStorage
  void saveLanguage(AppLanguage language) {
    selectedLanguage.value = language;
    GetStorage().write('appLanguage', language.toString());
  }

  // Function to load the selected language from GetStorage
  void loadLanguage() {
    String? languageString = GetStorage().read('appLanguage');
    selectedLanguage.value = languageString == null
        ? AppLanguage.Arabic
        : AppLanguage.values.firstWhere((language) => language.toString() == languageString);
  }
}