import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/custom_wave.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_divider_with_text.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Wave Background
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.newa,
              ),
            ),
          ),
          // Back Button Positioned
          Positioned(
            top: 40, // Adjust for the safe area
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.newa,
                ),
              ),
            ),
          ),
          // About Icon
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
               backgroundColor: Colors.white,
              child: Icon(
                Icons.info,
                size: 50,
                color: AppColors.newa,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                DividerWithText(text: 'About App'.tr),
                SizedBox(height: 20),
                Text(
                  'This app provides various features and functionalities to help you manage your loans efficiently.'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                DividerWithText(text: 'Version'.tr),
                SizedBox(height: 20),
                Text(
                  'Version: 1.0.0'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                DividerWithText(text: 'Updates'.tr),
                SizedBox(height: 20),
                Text(
                  'Stay tuned for upcoming updates and new features.'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                // DividerWithText(text: 'Contact Us'.tr),
                // SizedBox(height: 20),
                // Text(
                //   'For support, contact us at \n Phone: +962 6 5338908\nEmail: info@alameenjo.com '.tr,
                //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}