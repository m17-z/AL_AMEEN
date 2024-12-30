// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import '../../helper/Colors2.dart';
// import '../../helper/app_image_asset.dart';
// import '../../helper/custom_wave.dart';
// import '../Home/controller/home_controller.dart';
// import '../../helper/custom_button.dart';
// import '../../helper/custom_text.dart';
// import '../Payment/payment_screen.dart';
// import '../test/testofloan.dart';

// class LoanScreen extends StatelessWidget {
//   final HomeController homeController = Get.put(HomeController());
 
//   final List<Map<String, String>> loanDetails;

//   LoanScreen({

//     required this.loanDetails,
//   });

//   static void navigateToLoanScreen({
//     required String imagePath,
//     required String sectionTitle,
//     required List<Map<String, String>> loanDetails,
//   }) {
//     Get.to(() => FinancialOverviewPage(
    
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//           child: Column(
//             children: [
//                 Stack(
//               children: [
//                 ClipPath(
//                   clipper: WaveClipper(),
//                   child: Container(
//                     height: 150,
//                     decoration: BoxDecoration(
//                       color: AppColors.newa,
                      
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 50,
//                   left: MediaQuery.of(context).size.width / 2 - 50,
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage('assets/images/splash.png'),
//                     backgroundColor: Colors.white,
//                   ),
//                 ),
//                 Positioned(
//                   top: 40, // Adjust for the safe area
//                   right: 16,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context); // Navigate back
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 1,
//                             blurRadius: 4,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: AppColors.newa,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//               Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 20), // Padding for left and right
//   child: Column(
//     children: [
//       const SizedBox(height: 20),
//       CustomSectionTitle(title: "Loan details".tr),
//       const SizedBox(height: 10),
//       CustomDetailsSection(details: loanDetails),
//       const SizedBox(height: 20),
//       CustomButton.buttonStyle(
//         text: "Pay now".tr,
//         width: Get.width * 0.95,
//         height: Get.height * 0.07,
//         colorButton: Color(0xFFFAA84C),
//         onPressed: () => _handlePayNow(),
//       ),
//       const SizedBox(height: 15),
//       CustomButton.buttonStyle(
//                 text: "Get an account statement".tr,
//                 width: Get.width * 0.95,
//                 height: Get.height * 0.07,
//                 onPressed: () => _handleGetAccountStatement(),
//               ),
//     ],
//   ),
// ),            
//             ],
//           ),
//         ),
//       );
   
//   }

//   void _handlePayNow() {
//     Get.defaultDialog(
//       title: 'Pay now'.tr,
//       middleText: 'Do you want to pay the monthly installment due?'.tr,
//       actions: [
//         ElevatedButton(
//           onPressed: Get.back,
//           child: Text(
//             'No'.tr,
//             style: TextStyle(color: Colors.red[500], fontSize: 16),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Get.back(); // Close dialog
//             Get.to(() => PaymentScreen());
//           },
//           child: Text(
//             'Yes'.tr,
//             style: TextStyle(color: Colors.blue[700], fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }

//   void _handleGetAccountStatement() {
//     Get.defaultDialog(
//       title: 'Account Statement'.tr,
//       content: Obx(
//         () {
//           if (homeController.error.value) {
//             return Lottie.asset(AppImageAsset.try_again, width: 100, height: 100);
//           } else if (homeController.loading.value) {
//             return Lottie.asset(AppImageAsset.download, width: 100, height: 100);
//           } else {
//             return Text("Get an account statement".tr);
//           }
//         },
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: Get.back,
//           child: Text(
//             'Cancel'.tr,
//             style: TextStyle(color: Colors.red[500], fontSize: 16),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             homeController.loading.value = true;
//             await homeController.downloadFile();
//             homeController.loading.value = false;
//           },
//           child: Text(
//             'Download'.tr,
//             style: TextStyle(color: Colors.blue[700], fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CustomSectionTitle extends StatelessWidget {
//   final String title;

//   const CustomSectionTitle({required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(Icons.info_outline, color: AppColors.newa),
//         const SizedBox(width: 8),
//         CustomText(
//           text: title,
//           fontWeight: FontWeight.bold,
//           fontsize: 18,
//           color: Colors.black87,
//         ),
//       ],
//     );
//   }
// }

// class CustomDetailsSection extends StatelessWidget {
//   final List<Map<String, String>> details;

//   const CustomDetailsSection({required this.details});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20  ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 6,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: details.expand((detailMap) {
//           return detailMap.entries.map((entry) => CustomDetailRow(
//                 label: entry.key,
//                 value: entry.value,
//               ));
//         }).toList(),
//       ),
//     );
//   }
// }

// class CustomDetailRow extends StatelessWidget {
//   final String label;
//   final String value;

//   const CustomDetailRow({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CustomText(
//             text: label,
//             fontWeight: FontWeight.w600,
//             fontsize: 15,
//           ),
//           CustomText(
//             text: value,
//             fontWeight: FontWeight.w600,
//             fontsize: 15,
//             color: Colors.blue[800],
//           ),
//         ],
//       ),
//     );
//   }
// }
