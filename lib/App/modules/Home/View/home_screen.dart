// import 'package:al_ameen/App/helper/app_image_asset.dart';
// import 'package:al_ameen/App/data/api/constance.dart';
// import 'package:al_ameen/App/helper/extentions.dart';
// import 'package:al_ameen/App/modules/Payment/payment_screen.dart';
// import 'package:al_ameen/App/helper/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
// import '../../../lang/language_view_model.dart';
// import '../../Drawer/about_us_screen.dart';
// import '../../Drawer/company_details_screen.dart';
// import '../../Drawer/contact_us_screen.dart';
// import '../../Drawer/profile_screen.dart';
// import '../../Drawer/settings.dart';
// import '../controller/home_controller.dart';
// import '../../../helper/custom_button.dart';
// import '../../Drawer/loan_screen.dart';
// import '../../splash/splash_screen.dart';
// import 'package:al_ameen/App/data/api/session.dart';

// class HomeScreen extends StatefulWidget {
//   final String customerId;
//   final String authToken;

//   HomeScreen({
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

//   @override
//   void initState() {
//     super.initState();
//     lang = Get.locale == Locale('ar') ? 'عربي' : 'English';
//     fetchLoanData();
//   }

//   Future<void> fetchLoanData() async {
//     try {
//       final data = await currentLoan(widget.customerId, widget.authToken);
//       setState(() {
//         loanData = data;
//       });
//     } catch (e) {
//       setState(() {
//         loanData = {}; // Set loanData to an empty map to ensure the UI is displayed
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         var result = await Get.defaultDialog(
//           title: 'Exit'.tr,
//         //  middleText: 'Do you want to exit the app?'.tr,
//           content: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(),
//               Image.asset(
//                 'assets/icons/alert.png',
//                 width: 35, // Adjust the width as needed
//                 height: 35, // Adjust the height as needed
//               ),
//               Text('Do you want to exit the app?'.tr),
//               SizedBox(),
//               SizedBox(),
//             ],
//           ),

//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Get.back(); // Choose No
//               },
//               child: Text('No'.tr,style: TextStyle(color: Colors.blue[700],fontSize: 18),),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Get.back(); // Choose Yes
//                 // Add your code to exit the app
//                 SystemNavigator.pop();
//               },
//               child: Text('Yes'.tr,style: TextStyle(color: Colors.blue[700],fontSize: 18),),
//             ),
//           ],
//         );
//         // Default to false if result is null
//         return result ?? false; // افتراضيًا، الرجوع للقيمة false (منع الرجوع)
//       },
//       child: Scaffold(
//         drawer: Drawer(
//           backgroundColor: Colors.transparent,
//           width: Get.width*.55,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(Get.locale==Locale('ar') ? 0.0 : 100.0),
//                 topLeft: Radius.circular(Get.locale==Locale('ar') ? 100.0 : 0.0 ),
//               ),
//               color: Colors.white.withOpacity(.9), // يمكنك تغيير اللون هنا
//             ),
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: Get.height*.25,
//                   child: DrawerHeader(child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(child: Image.asset('assets/images/profile.png',)),
//                       20.height,
//                       CustomText(
//                         fontsize: 14,
//                         alignment: Get.locale == Locale('ar') ? Alignment.topRight: Alignment.topLeft,
//                         text: 'Welcome'.tr +'\n '.tr,height: 1.5,
//                       ),
//                     ],
//                   )),
//                 ),
//                 ListTile(
//                   onTap: () {
//                     Get.to(ProfileScreen());
//                   },
//                   leading: CustomText(
//                     text: 'Personal Details'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.person,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
//                 ListTile(
//                   // onTap: () {
//                   //   Get.to(LoanScreen());
//                   // },
//                   leading: CustomText(
//                     text: 'Loan Details'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.description_outlined,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
//                 ListTile(
//                   onTap: () {
//                     Get.to(CompanyInfoScreen());
//                   },
//                   leading: CustomText(
//                     text: 'Company Details'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.description_outlined,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
//                 ListTile(
//                   onTap: () {
//                     Get.to(ContactUsScreen());
//                   },
//                   leading: CustomText(
//                     text: 'Contact Us'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.contact_page_outlined,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
                
//                 Divider(height: 1,color: Colors.grey,),
//                 ListTile(
//                   onTap: () {
//                     Get.to(SettingsScreen());
//                   },
//                   leading: CustomText(
//                     text: 'Settings'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.settings,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
//                 ListTile(
//                   onTap: () {
//                     Get.off(SplashScreen(seconds: 1));
//                   },
//                   leading: CustomText(
//                     text: 'Logout'.tr, fontsize: 14,
//                   ),
//                   trailing: Icon(Icons.logout,size: 21,),
//                 ),
//                 Divider(height: 1,color: Colors.grey,),
//                 10.height,
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1,color: Constants.fontColor),
//                     ),
//                     child: MaterialButton(
//                       onPressed: (){
//                         setState(() {
//                           setState(() {});
//                           if (Get.locale!=Locale('ar')) {
//                             Get.find<LanguageController>().saveLanguage(AppLanguage.Arabic);
//                             Get.updateLocale(const Locale('ar'));
//                             lang = 'English';
//                           } else {
//                             Get.find<LanguageController>().saveLanguage(AppLanguage.English);
//                             Get.updateLocale(const Locale('en', 'us'));
//                              lang = 'عربي';
//                           }
//                         });
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           SizedBox(),
//                           FittedBox(child: Text('$lang')),
//                           Icon(Icons.cached,size: 18,)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         appBar: AppBar(
//           elevation: 10,
//           centerTitle: true,
//           title: CustomText(
//             text: 'Home'.tr,
//             color: Colors.white,
//             fontsize: 21,
//             fontWeight: FontWeight.w400,
//           ),
//           backgroundColor: Constants.primaryColor,
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.white.withOpacity(
//                       .9), // Set the color of the Drawer icon to white
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               );
//             },
//           ),
//         ),
//         body: loanData == null
//             ? Center(child: CircularProgressIndicator())
//             : Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   30.height,
//                   Container(
//                     width: Get.width,
//                     height: Get.height * .4,
//                     margin: EdgeInsets.all(Get.width * .03),
//                     child: Material(
//                       elevation: 10,
//                       child: Padding(
//                         padding: const EdgeInsets.all(18.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                  width: Get.width * .6,
// child: CustomText(
//   fontWeight: FontWeight.w600,
//   text: 'Total loan amount'.tr,
//   fontsize: 14.5,
// ),
// ),
// if (loanData != null && loanData!['loanList'] != null && loanData!['loanList'].isNotEmpty) ...[
//   CustomText(
// text: loanData!['loanList'][0]['totalLoanAmount'] ?? '000',
//   fontWeight: FontWeight.w600,
//   fontsize: 14.5,
// ),
// ] else ...[
//   CustomText( 
//   ),
// ],]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   fontWeight: FontWeight.w600,
//                                   text: 'Payment for remaining'.tr,
//                                   fontsize: 14.5,
//                                 ),
//                                 CustomText(
// text: "000",

//                                   fontWeight: FontWeight.w600,
//                                   fontsize: 14.5,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(  
//                                   fontWeight: FontWeight.w800,
//                                   text: 'The monthly installment is due in'.tr,
//                                   color: Constants.fontColor,
//                                   fontsize: 15.5,
//                                 ),
//                                 CustomText(
// text: "000",

//                                   fontWeight: FontWeight.w800,
//                                   color: Constants.fontColor,
//                                   fontsize: 15.5,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: CustomText(
//                                     text: 'The value of the monthly installment due'.tr,
//                                     color: Constants.fontColor,
//                                     fontsize: 15.5,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                                 CustomText(
// text: "000",

//                                   color: Constants.fontColor,
//                                   fontWeight: FontWeight.w800,
//                                   fontsize: 15.5,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   text: 'deserved amount'.tr,
//                                   color: Constants.fontColor,
//                                   fontWeight: FontWeight.w800,
//                                   fontsize: 15.5,
//                                 ),
//                                 CustomText(
// text: "000",

//                                   color: Constants.fontColor,
//                                   fontWeight: FontWeight.w800,
//                                   fontsize: 15.5,
//                                 ),
//                               ],
//                             ),
//                             Divider(height: 2, color: Colors.black87),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   text: 'Loan code',
//                                   fontsize: 14.5,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                                 CustomText(
//                                  text: "000",
//                                   fontsize: 14.5,
//                                   fontWeight: FontWeight.w300,
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   text: 'The total monthly installment due',
//                                   fontWeight: FontWeight.w300,
//                                   fontsize: 14.5,
//                                 ),
//                                 CustomText(
// text:  '000',
//                                   fontWeight: FontWeight.w300,
//                                   fontsize: 14.5,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   30.height,
//                   CustomButton.buttonStyle(
//                     text: "Pay now".tr,
//                     width: Get.width * .95,
//                     height: Get.height * .07,
//                     colorButton: Color(0xFFFAA84C),
//                     onPressed: () {
//                       Get.defaultDialog(
//                         title: 'Pay now'.tr,
//                         middleText: 'Do you want to pay the monthly installment due?'.tr,
//                         actions: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Get.back(); // Choose No
//                             },
//                             child: Text(
//                               'No'.tr,
//                               style: TextStyle(color: Colors.red[500], fontSize: 18),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {
//                               Get.back();
//                               Get.to(PaymentScreen());
//                             },
//                             child: Text(
//                               'Yes'.tr,
//                               style: TextStyle(color: Colors.blue[700], fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   10.height,
//                   CustomButton.buttonStyle(
//                     text: "Get an account statement".tr,
//                     width: Get.width * .95,
//                     height: Get.height * .07,
//                     onPressed: () async {
//                       setState(() {});
//                       Get.defaultDialog(
//                         title: ''.tr,
//                         content: Obx(() => homeController.error.value
//                             ? Lottie.asset(
//                                 AppImageAsset.try_again,
//                                 width: 100,
//                                 height: 100,
//                               )
//                             : homeController.loading.value
//                                 ? Lottie.asset(
//                                     AppImageAsset.download,
//                                     width: 100,
//                                     height: 100,
//                                   )
//                                 : Text("Get an account statement".tr)),
//                         actions: [
//                           ElevatedButton(
//                             onPressed: () {
//                               Get.back(); // Choose No
//                             },
//                             child: Text(
//                               'Cancel'.tr,
//                               style: TextStyle(color: Colors.red[500], fontSize: 18),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () async {
//                               homeController.loading.value = true;
//                               await homeController.downloadFile(); // Start download process
//                             },
//                             child: Text(
//                               'download'.tr,
//                               style: TextStyle(color: Colors.blue[700], fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   )
//                 ],
//               ),
//       ),
//     );
//   }
// }

