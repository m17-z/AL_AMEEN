// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'splash_services.dart';



// class SplashScreen extends StatefulWidget {
//   final seconds;
//   const SplashScreen({Key? key, required this.seconds,}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   bool isOnline=true;
//   SplashServices splashServices = Get.put(SplashServices());

//   @override
//   void initState() {
//     super.initState();
//     splashServices.splash(seconds: widget.seconds ?? 3);
//   }



//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: GetBuilder<SplashServices>(
//         init: SplashServices(),
//         builder:(controller)=> Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//              Center(
//                child: ClipOval(
//                   child:   Image.asset('assets/images/logo.png',
//                     width: Get.width*.6,height: Get.height*.6,
//                     ),
//              ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

