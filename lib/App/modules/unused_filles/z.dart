// import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // شعار التطبيق
//               Image.asset('assets/ila_logo.png'), // استبدل بمسار شعارك

//               // العنوان
//               Text(
//                 '100% control at your fingertips',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               // مؤشرات الصفحة
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   for (int i = 0; i < 5; i++)
//                     Container(
//                       width: 8,
//                       height: 8,
//                       margin: EdgeInsets.symmetric(horizontal: 4),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: i == 2 ? Colors.blue : Colors.grey, // اللون النشط
//                       ),
//                     ),
//                 ],
//               ),

//               // قائمة الميزات
//               SizedBox(height: 30),
//               Column(
//                 children: [
//                   // مثال على عنصر واحد من القائمة
//                   Row(
//                     children: [
//                       Icon(Icons.money),
//                       SizedBox(width: 10),
//                       Text('Fund your account in seconds'),
//                     ],
//                   ),
//                   // أضف عناصر أخرى بنفس الشكل
//                 ],
//               ),

//               // أزرار الحركة
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Open your Account'),
//               ),
//               ElevatedButton(
//                 onPressed: () {},
//                 child: Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }