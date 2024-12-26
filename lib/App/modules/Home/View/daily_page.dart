// import '../../../controllers/login_controller.dart';
// import '../../../helper/CustomLoanCard.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:icon_badge/icon_badge.dart';
// import 'package:intl/intl.dart';

// import '../../../helper/colors.dart';
// import '../../../helper/custom.dart';
// import '../../Drawer/loan_screen.dart';

// class DailyPage extends StatefulWidget {
//   final String customerId;

//   const DailyPage({super.key, required this.customerId});

//   @override
//   State<DailyPage> createState() => _DailyPageState();
// }

// class _DailyPageState extends State<DailyPage> {
//   void navigateToLoanScreen(Map<String, String> loanData) {
//     Get.to(() => LoanScreen(loanDetails: [loanData],), arguments: loanData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     String currentDate = DateFormat('MMM d, yyyy').format(DateTime.now());

//     // Get the current language (Arabic or English)
//     bool isArabic = Get.locale?.languageCode == 'ar';

//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile Container
//             Container(
//               margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
//               decoration: BoxDecoration(
//                 color: white,
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: [
//                   BoxShadow(
//                     color: grey.withOpacity(0.03),
//                     spreadRadius: 10,
//                     blurRadius: 3,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20, bottom: 25, right: 20, left: 20),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: 70,
//                           height: 70,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               image: AssetImage("assets/images/profile.jpg"),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           width: (size.width - 40) * 0.6,
//                           child: Column(
//                             children: [
//                               Text(
//                                 "Dawood baidas",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: mainFontColor,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     // Loan summary row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Column(
//                           children: [
//                             Text(
//                               "8900",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: mainFontColor,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Total loan amount".tr,
//                               style: TextStyle(
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w100,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           width: 0.5,
//                           height: 40,
//                           color: black.withOpacity(0.3),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "5500",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: mainFontColor,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Total paid Amount".tr,
//                               style: TextStyle(
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w100,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           width: 0.5,
//                           height: 40,
//                           color: black.withOpacity(0.3),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "890",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600,
//                                 color: mainFontColor,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               "Total Remaining".tr,
//                               style: TextStyle(
//                                 fontSize: 9,
//                                 fontWeight: FontWeight.w100,
//                                 color: black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 25, right: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Title for "All Loans Details"
//                   Text(
//                     "All Loans Details".tr,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: mainFontColor,
//                     ),
//                   ),
//                   // Date & Calendar icon
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         currentDate,
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                           color: mainFontColor,
//                         ),
//                       ),
//                       SizedBox(width: 5),
//                       Icon(
//                         Icons.calendar_today,
//                         color: mainFontColor,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       navigateToLoanScreen({
//                         'loanId': '121212',
//                         'loanType': 'Car Loan',
//                         'loanAmount': '5000',
//                         'loanStatus': 'Pending',
//                         'loanStartDate': '12/12/2021',
//                         'interestRate': '5%',
//                         'loanTenure': '12',
//                       });
//                     },
//                     child: CustomLoanCard(
//                       loanId: "${widget.customerId}",
//                       loanType: "Car Loan",
//                       loanAmount: "5000",
//                       loanStatus: "Pending",
//                       loanStartDate: "12/12/2021",
//                       interestRate: "5%",
//                       isArabic: isArabic,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       navigateToLoanScreen({
//                         'loanId': '121212',
//                         'loanType': 'Personal Loan',
//                         'loanAmount': '5000',
//                         'loanStatus': 'Pending',
//                         'loanStartDate': '12/12/2021',
//                         'interestRate': '5%',
//                         'loanTenure': '12',
//                       });
//                     },
//                     child: CustomLoanCard(
//                       loanId: "121212",
//                       loanType: "Personal Loan",
//                       loanAmount: "5000",
//                       loanStatus: "Pending",
//                       loanStartDate: "12/12/2021",
//                       interestRate: "5%",
//                       isArabic: isArabic,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       navigateToLoanScreen({
//                         'loanId': '121212',
//                         'loanType': 'Home Loan',
//                         'loanAmount': '5000',
//                         'loanStatus': 'Pending',
//                         'loanStartDate': '12/12/2021',
//                         'interestRate': '5%',
//                         'loanTenure': '12',
//                       });
//                     },
//                     child: CustomLoanCard(
//                       loanId: "121212",
//                       loanType: "Home Loan",
//                       loanAmount: "5000",
//                       loanStatus: "Pending",
//                       loanStartDate: "12/12/2021",
//                       interestRate: "5%",
//                       isArabic: isArabic, installmentNo: '', paidAmount: '', installmentStatus: '',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
