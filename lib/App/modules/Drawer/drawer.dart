import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/api/constance.dart';
import 'branches_screen.dart';
import 'company_details_screen.dart';
import 'contact_us_screen.dart';
import 'profile_screen.dart';
import 'settings.dart';
import '../OnbordingScreen/splash.dart';
import '../../helper/custom_text.dart';
import '../../lang/language_view_model.dart';

class CustomDrawer extends StatefulWidget {
  final VoidCallback? onLogout;
  final Color color;
  final String customerId;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String address;

  const CustomDrawer({
    Key? key,
    this.onLogout,
    required this.color,
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.address,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? lang;
  bool isGuest = false;

  @override
  void initState() {
    super.initState();
    print('customerId: ${widget.customerId}');
    print('firstName: ${widget.firstName}');
    print('lastName: ${widget.lastName}');
    print('mobileNo: ${widget.mobileNo}');
    print('address: ${widget.address}');
    lang = Get.locale == Locale('ar') ? 'English' : 'عربي';
  }

  Future<void> handleProfileTap() async {
    print('Profile tapped');
    if (widget.customerId.isEmpty) {
      Get.snackbar(
        'Guest Mode',
        'You are in guest mode. Please log in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.7),
        colorText: Colors.black,
      );
    } else {
      Get.to(ProfilePage(
        customerId: widget.customerId,
        firstName: widget.firstName,
        lastName: widget.lastName,
        mobileNo: widget.mobileNo,
        address: widget.address,
      ));
    }
  }

  Future<void> handleSettingsTap() async {
    print('Settings tapped');
    if (isGuest) {
      Get.snackbar(
        'Guest Mode',
        'You are in guest mode. Please log in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white.withOpacity(0.7),
        colorText: Colors.black,
      );
    } else {
      Get.to(SettingsScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      width: Get.width * .55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Get.locale == Locale('ar') ? 0.0 : 100.0),
            topLeft: Radius.circular(Get.locale == Locale('ar') ? 100.0 : 0.0),
          ),
          color: Colors.white.withOpacity(.9),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * .25,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/splash.png"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildDrawerItem(
              title: 'Personal Details'.tr,
              icon: Icons.person,
              onTap: handleProfileTap,
            ),
            _buildDrawerItem(
              title: 'Company Details'.tr,
              icon: Icons.description_outlined,
              onTap: () => Get.to(CompanyInfoScreen()),
            ),
            _buildDrawerItem(
              title: 'Branches'.tr,
              icon: Icons.location_on,
              onTap: () => Get.to(BranchesScreen()),
            ),
            _buildDrawerItem(
              title: 'Contact Us'.tr,
              icon: Icons.contact_page_outlined,
              onTap: () => Get.to(ContactUsScreen()),
            ),
            _buildDrawerItem(
              title: 'Settings'.tr,
              icon: Icons.settings,
              onTap: handleSettingsTap,
            ),
            _buildDrawerItem(
              title: 'Logout'.tr,
              icon: Icons.logout,
              onTap: widget.onLogout ?? () => Get.off(OnboardingScreen2()),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Constants.fontColor),
                ),
                child: MaterialButton(
                  onPressed: _toggleLanguage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(),
                      FittedBox(child: Text(lang!)),
                      const Icon(Icons.cached, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('Tapped on: $title');
        onTap();
      },
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 21),
            title: CustomText(
              text: title,
              fontsize: 14,
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }

  void _toggleLanguage() {
    setState(() {
      if (Get.locale == Locale('ar')) {
        Get.find<LanguageController>().saveLanguage(AppLanguage.English);
        Get.updateLocale(const Locale('en', 'us'));
        lang = 'عربي';
      } else {
        Get.find<LanguageController>().saveLanguage(AppLanguage.Arabic);
        Get.updateLocale(const Locale('ar'));
        lang = 'English';
      }
    });
  }
}
