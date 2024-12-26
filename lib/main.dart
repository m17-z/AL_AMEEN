import 'App/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'App/lang/language_view_model.dart';
import 'App/helper/binding.dart';
import 'App/lang/languages.dart';
import 'App/modules/OnbordingScreen/splash.dart';

//import 'package:device_preview/device_preview.dart';

void main() async {

  // Get.put(LocalStorageData())
  await GetStorage.init();
  LanguageController languageController = Get.put(LanguageController());
  languageController.loadLanguage(); // Load the selected language
  //  QrCodeController qrCodeController = Get.put(QrCodeController());
  // await qrCodeController.LoadBaseUrl();
  //
  // print('main  $baseUrLink');
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,])
  //     .then((_) {
    runApp(MyApp());
  //});
}
// in main method

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      translations: Languages(),
      locale: Get.find<LanguageController>().selectedLanguage.value
          == AppLanguage.Arabic
          ? const Locale('ar')
          : const Locale('en','us'),
      fallbackLocale: const Locale('en', 'US'),
      home: OnboardingScreen2(),
   );
  }
 }


