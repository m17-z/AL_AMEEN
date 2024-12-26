// import 'package:al_ameen/App/helper/Colors2.dart';
// import 'package:al_ameen/App/modules/Home/View/home.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../../helper/Lang/LanguageProvider.dart';
// import '../../helper/Lang/LocalizationService.dart';
// import '../Home/View/home_screen.dart';



// class OnBoardingPage extends StatefulWidget {
//   @override
//   _OnBoardingPageState createState() => _OnBoardingPageState();
// }

// class _OnBoardingPageState extends State<OnBoardingPage> {
//   final PageController _pageController = PageController();
//   int currentPage = 0;

//   final List<Map<String, String>> onBoardingData = [
//     {
//       'image': 'assets/image/logoalameen.png',
//       'title': 'Welcome to App',
//       'description': 'This is the first step to get started.'
//     },
//     {
//       'image': 'assets/image/logoalameen.png',
//       'title': 'Discover Features',
//       'description': 'Explore the features and functionalities.'
//     },
//     {
//       'image': 'assets/image/logoalameen.png',
//       'title': 'Get Started Now',
//       'description': 'Join us and enjoy the journey.'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final languageProvider = Provider.of<LanguageProvider>(context);

//     return Scaffold(
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             alignment: Alignment.topRight,
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     languageProvider.changeLanguage(
//                         languageProvider.languageCode == 'en' ? 'ar' : 'en');
//                   },
//                   style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(
//                         Icons.language,
//                         color: AppColors.accentColor,
//                       ),
//                       const SizedBox(width: 8.0),
                      
//                       Text(
//                       'switchLanguage'.tr,
//                         style: GoogleFonts.cairo(
//                           textStyle: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
                          
//                         ),
                        
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Expanded(
//             child: PageView.builder(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentPage = index;
//                 });
//               },
//               itemCount: onBoardingData.length,
//               itemBuilder: (context, index) {
//                 return OnBoardingContent(
//                   image: onBoardingData[index]['image']!,
//                   title: onBoardingData[index]['title']!,
//                   description: onBoardingData[index]['description']!,
//                 );
//               },
//             ),
//           ),

//           // Bottom navigation
//           Container(
//             padding: const EdgeInsets.all(20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (currentPage != onBoardingData.length - 1)
//                   TextButton(
//                     onPressed: () {
//                       _pageController.jumpToPage(onBoardingData.length - 1);
//                     },
//                     child: Text(
//                       LocalizationService.translate('Skip') ?? '',
//                       style: GoogleFonts.cairo(
//                         textStyle: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 Row(
//                   children: List.generate(onBoardingData.length, (index) {
//                     return buildDot(index, context);
//                   }),
//                 ),
//                 if (currentPage == onBoardingData.length - 1)
//                   ElevatedButton(
//                     onPressed: () async {
//                         Get.offAll(HomeScreen(customerId: '', authToken: '',));
//                       },
//                     // كله النا
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.accentColor,
//                       foregroundColor: Colors.white,
//                       minimumSize: Size(200, 50), // تحديد الحجم الثابت

//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                     ),
//                     child:
//                     Text(
//                       LocalizationService.translate('welcome') ?? '',
//                       style: GoogleFonts.cairo(
//                         textStyle: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container buildDot(int index, BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 5),
//       height: 10,
//       width: currentPage == index ? 20 : 10,
//       decoration: BoxDecoration(
//         // color: currentPage == index ? Colors.blue : Colors.grey,
//         color: currentPage == index ? AppColors.accentColor : Colors.grey,
//         borderRadius: BorderRadius.circular(5),
//       ),
//     );
//   }
// }

// class OnBoardingContent extends StatelessWidget {
//   final String image, title, description;

//   const OnBoardingContent({
//     required this.image,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image, height: 300),
//         const SizedBox(height: 20),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           description,
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }
