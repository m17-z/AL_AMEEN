import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_text.dart';
import '../../helper/custom_wave.dart';
import '../../helper/custom_divider_with_text.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({Key? key}) : super(key: key);

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                  right: 16,
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
                // Logo Image
              Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/splash.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.01),
                  DividerWithText(
                    text: 
                    'Al-Ameen Micro-finance Co'.tr,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Financing households for education, consumer needs, and projects'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, ),
                  ),
                  SizedBox(height: 20),

                  // Company Overview Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerWithText(text: 'Company Overview'.tr),
                        SizedBox(height: 10),
                        Text(
                          'Al-Ameen Micro-finance Co. is a Jordanian LLC focused on providing financing for households in the areas of consumer needs, education, and project financing'.tr,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),

                  // Services Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerWithText(text: 'Our Services'.tr),
                        SizedBox(height: 10),
                        Text(
                          'We provide micro-finance solutions for households, including consumer loans, educational financing, and project-based funding.'.tr,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),

                  // Branches Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerWithText(text: 'Our Branches'.tr),
                        SizedBox(height: 10),
                        Text(
                          'We operate across 8 branches in Jordan, providing comprehensive services to various regions.'.tr,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),

                  // Values Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DividerWithText(text: 'Our Values'.tr),
                        SizedBox(height: 10),
                        Text(
                          'Transparency, ethics, and excellence in service delivery are at the core of Al-Ameen Micro-finance Co.'.tr,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}