// import 'dart:async';
// import 'package:al_ameen/App/modules/log/welcome_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../Home/View/home.dart';
// import 'preferences.dart';
// import '../Home/View/home_screen.dart';



// class SplashServices extends GetxController{

//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   ValueNotifier<bool> get loading =>_loading;


//   splash({required int seconds}){
//     _loading.value=true;
//     Timer(  Duration(seconds: seconds), () async{
//       bool userLoggedIn = await Preferences.getUserLoggedIn();
//       if (userLoggedIn) {
//         // المستخدم مسجل الدخول
//         // انتقل إلى الشاشة الرئيسية أو أي شاشة أخرى المطلوبة
//                         Get.offAll(HomeScreen(customerId: '', authToken: '',));
//       } else {
//         Get.off(const WelcomeScreen());
//       }
//     });
//     _loading.value=false;
//     update();
//   }

// }