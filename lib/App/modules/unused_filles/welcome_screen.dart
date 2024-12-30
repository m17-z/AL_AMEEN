// import 'package:al_ameen/App/modules/splash/auth_view_model.dart';
// import 'package:al_ameen/App/helper/extentions.dart';
// import 'package:al_ameen/App/helper/custom_waves.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';

// import '../register/login_screen.dart';
// import '../Home/View/home_screen.dart';
// import '../../data/api/constance.dart';
// import '../../lang/language_view_model.dart';
// import '../../helper/custom_button.dart';
// import '../../helper/custom_text.dart';
// import '../../helper/custom_textformfield.dart';

// class WelcomeScreen extends StatefulWidget {
//   final baseUrlGet;

//   const WelcomeScreen({Key? key, this.baseUrlGet}) : super(key: key);

//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }

// class _WelcomeScreenState extends State<WelcomeScreen> {
//   AuthViewModel controller = Get.put(AuthViewModel());
//   String lang = '';

//   @override
//   void initState() {
//     super.initState();
//     lang = Get.locale == Locale('ar') ? 'عربي' : 'English';
//   }

//   bool isOnline = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           width: Get.width,
//           height: Get.height,
//           child: SingleChildScrollView(
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   width: Get.width,
//                   height: Get.height,
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: MaterialButton(
//                         onPressed: () {
//                           setState(() {
//                             if (Get.locale != const Locale('ar')) {
//                               Get.find<LanguageController>().saveLanguage(AppLanguage.Arabic);
//                               Get.updateLocale(const Locale('ar'));
//                               lang = 'عربي';
//                             } else {
//                               Get.find<LanguageController>().saveLanguage(AppLanguage.English);
//                               Get.updateLocale(const Locale('en', 'us'));
//                               lang = 'English';
//                             }
//                           });
//                         },
//                         child: CustomText(
//                           text: '$lang  -  ${Get.locale != const Locale('ar') ? ' en ' : ' ar '}',
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image.asset(
//                       'assets/images/logo.png',
//                       width: Get.width * .4,
//                       height: Get.height * .3,
//                     ),
//                     CustomText(
//                       text: 'Welcome to Al-Amin'.tr,
//                       fontsize: 18,
//                       fontWeight: FontWeight.w600,
//                       height: 2,
//                     ),
//                     FittedBox(
//                       child: CustomText(
//                         text: 'If you are our client, please register using your client code'.tr,
//                         fontsize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     30.height,
                   
//                     CustomButton.buttonStyle(
//                       text: "SIGN_UP".tr,
//                       width: Get.width * .4,
//                       height: Get.height * .08,
//                       onPressed: () async {
//                         Get.to(LoginScreen());
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Column(
//                         children: [
//                           CustomText(
//                             text: 'OR'.tr,
//                             fontWeight: FontWeight.w600,
//                             fontsize: 18,
//                             height: 1.5,
//                           ),
//                           CustomText(
//                             text: 'Login as a visitor'.tr,
//                             fontWeight: FontWeight.w500,
//                             fontsize: 15,
//                           ),
//                         ],
//                       ),
//                     ),
//                     CustomButton.buttonStyle(
//                       text: "GUEST".tr,
//                       width: Get.width * .4,
//                       height: Get.height * .08,
//                       onPressed: () async {
//                         Get.offAll(HomeScreen(customerId: '', authToken: '',));
//                       },
//                     ),
//                     100.height,
//                   ],
//                 ),
//                 CustomWaves.waveStyle(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
