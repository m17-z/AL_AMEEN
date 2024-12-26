import 'package:flutter/material.dart';
import '../../helper/custom_wave.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_divider_with_text.dart';

class PrivacySecurityPage extends StatelessWidget {
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
          // Privacy & Security Icon
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.newa,
              child: Icon(
                Icons.lock,
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
                DividerWithText(text: 'Privacy & Security'),
                SizedBox(height: 20),
                Text(
                  'Manage your privacy and security settings to keep your account safe.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                DividerWithText(text: 'Privacy Settings'),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.visibility_off, color: AppColors.newa),
                  title: Text('Profile Visibility'),
                  subtitle: Text('Control who can see your profile information.'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // Handle switch change
                    },
                  ),
                ),
                SizedBox(height: 20),
                DividerWithText(text: 'Security Settings'),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.lock, color: AppColors.newa),
                  title: Text('Change Password'),
                  subtitle: Text('Update your account password.'),
                  onTap: () {
                    // Handle change password
                  },
                ),
                ListTile(
                  leading: Icon(Icons.security, color: AppColors.newa),
                  title: Text('Two-Factor Authentication'),
                  subtitle: Text('Enable or disable two-factor authentication.'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // Handle switch change
                    },
                  ),
                ),
                SizedBox(height: 20),
                DividerWithText(text: 'Data Protection'),
                SizedBox(height: 20),
                Text(
                  'Learn how we protect your data and what measures we take to ensure your privacy.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}