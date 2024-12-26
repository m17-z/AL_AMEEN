import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_text.dart';
import '../../helper/custom_wave.dart';
import '../../helper/Colors2.dart';
import 'about_app_page.dart';
import 'fingerprint_page.dart';
import 'notifications_page.dart';
import 'privacy_security_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
              height: 159,
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
            top: 30,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.settings,
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
                _buildSettingsOption(
                  context,
                  icon: Icons.fingerprint,
                  title: 'Fingerprint Unlock'.tr,
                  subtitle: 'Enable fingerprint authentication'.tr,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FingerprintPage()),
                    );
                  },
                ),
                // Divider(),
                // _buildSettingsOption(
                //   context,
                //   icon: Icons.notifications_active,
                //   title: 'Notifications'.tr,
                //   subtitle: 'Manage notification settings'.tr,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => NotificationsPage()),
                //     );
                //   },
                // ),
                // Divider(),
                // _buildSettingsOption(
                //   context,
                //   icon: Icons.lock,
                //   title: 'Privacy & Security'.tr,
                //   subtitle: 'Adjust privacy settings'.tr,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => PrivacySecurityPage()),
                //     );
                //   },
                // ),
                Divider(),
                _buildSettingsOption(
                  context,
                  icon: Icons.info, 
                  title: 'About App'.tr,
                  subtitle: 'App version, updates, and information'.tr,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutAppPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build individual settings options
  Widget _buildSettingsOption(BuildContext context,
      {required IconData icon, required String title, String? subtitle, required Function() onTap}) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 28,
          color: AppColors.newa,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}