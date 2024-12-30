// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../data/api/session.dart';
// import '../../../helper/Colors2.dart';
// import '../../Drawer/drawer.dart';
// import '../../OnbordingScreen/splash.dart';
// import '../../splash/splash_screen.dart';
// import '../controller/home_controller.dart';
// import 'daily_page.dart';
// import '../../../helper/colors.dart';
// import '../../../helper/custom_wave.dart';

// class HomeScreen extends StatefulWidget {
//   final String customerId;
//   final String authToken;

//   const HomeScreen({
//     Key? key,
//     required this.customerId,
//     required this.authToken,
//   }) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final HomeController homeController = Get.put(HomeController());
//   String? lang;
//   Map<String, dynamic>? loanData;
//   int pageIndex = 0; // Index for BottomNavigationBar

//   // Define your pages
//   late List<Widget> pages;

//   @override
//   void initState() {
//     super.initState();
//     lang = Get.locale == const Locale('ar') ? 'عربي' : 'English';
//     fetchLoanData();
//     pages = [
//    //   DailyPage(customerId: widget.customerId), // First Page
//       // Third Page (Profile)
//     ];
//   }


//   Future<void> fetchLoanData() async {
//     try {
//       final data = await currentLoan(widget.customerId, widget.authToken);
//       setState(() {
//         loanData = data;
//       });
//     } catch (e) {
//       setState(() {
//         loanData = {};
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primary,
//       drawer: CustomDrawer(
//         color: Colors.white,
//         onLogout: () {
//           Get.offAll(OnboardingScreen2());
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             ClipPath(
//               clipper: WaveClipper(),
//               child: Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: AppColors.newa,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 40,
//               left: Get.locale == const Locale('ar') ? null : 16,
//               right: Get.locale == const Locale('ar') ? 16 : null,
//               child: Builder(
//                 builder: (context) => GestureDetector(
//                   onTap: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 1,
//                           blurRadius: 4,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.menu,
//                       color: AppColors.newa,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 40.0),
//               child: getBody(),
//             ),
//           ],
//         ),
//       ),
     
//     );
//   }

//   Widget getBody() {
//     return IndexedStack(
//       index: pageIndex,
//       children: pages,
//     );
//   }
// }

