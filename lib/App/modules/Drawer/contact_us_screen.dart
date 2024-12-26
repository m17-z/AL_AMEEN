import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_text.dart';
import '../../helper/custom_wave.dart';
import '../../helper/validators.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String sub = '0';
  String selectedSubject = '';

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
                // Profile Image
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
                  // Subject Dropdown
                  Text('Subject'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedSubject.isEmpty ? null : selectedSubject,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    items: [
                      'General Inquiry'.tr,
                      'Technical Issue'.tr,
                      'Billing Issue'.tr,
                      'Other'.tr,
                    ]
                        .map((subject) => DropdownMenuItem(
                              value: subject,
                              child: Text(subject),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSubject = value ?? '';
                      });
                    },
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please select a subject'.tr
                        : null,
                  ),
                  SizedBox(height: 20),

                  // Mobile Number Field
                  Text('Mobile Number'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: _buildInputDecoration('Enter your mobile number'.tr),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your mobile number'.tr
                        : null,
                  ),
                  SizedBox(height: 20),

                  // Email Field
                  Text('Email'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: _buildInputDecoration('Enter your email address'.tr),
                    validator: (value) => value == null ||
                            value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+\$")
                                .hasMatch(value)
                        ? 'Please enter a valid email address'.tr
                        : null,
                  ),
                  SizedBox(height: 20),

                  // Message Field
                  Text('Message'.tr, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    maxLines: 5,
                    decoration: _buildInputDecoration('Enter your message'.tr),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your message'.tr
                        : null,
                  ),
                  SizedBox(height: 20),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.newa,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Submit'.tr,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Handle form submission
                        }
                      },
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

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: AppColors.newa, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      filled: true,
      fillColor: Colors.grey[200],
    );
  }
}
