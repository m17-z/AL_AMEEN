import '../../helper/Colors2.dart';
import '../Home/View/loan_test.dart';
import '../unused_filles/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../helper/Lang/LanguageProvider.dart';
import '../../helper/Lang/LocalizationService.dart';
import '../../lang/language_view_model.dart';
import '../register/login_screen.dart';

class OnboardingScreen2 extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen2> {
  late VideoPlayerController _controller;
  late PageController _pageController;
  int _currentPage = 0;
  String? lang;
  @override
  void initState() {
    super.initState();
    lang = Get.locale == Locale('ar') ? 'عربي' : 'English';
    // تحميل الفيديو من الأصول
    _controller = VideoPlayerController.asset('assets/Video/splash.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // تشغيل الفيديو فورًا بعد التهيئة
        // إضافة مستمع لمراقبة نهاية الفيديو
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _controller.seekTo(Duration.zero); // العودة إلى البداية
            _controller.play(); // تشغيل الفيديو مرة أخرى
          }
        });
      });
    _pageController = PageController();
  }

void _toggleLanguage() {
  setState(() {
    if (Get.locale != Locale('ar')) {
      Get.find<LanguageController>().saveLanguage(AppLanguage.Arabic);
      Get.updateLocale(const Locale('ar'));
      lang = 'English';
    } else {
      Get.find<LanguageController>().saveLanguage(AppLanguage.English);
      Get.updateLocale(const Locale('en', 'us'));
      lang = 'عربي';
    }
  });
}

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    if (index == 1 || index == 2) {
      _controller.pause(); // إيقاف الفيديو عند التبديل إلى الصفحة الثانية أو الثالثة
    } else {
      _controller.play(); // تشغيل الفيديو مرة أخرى عند العودة إلى الصفحة الأولى
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الفيديو في الخلفية
          _controller.value.isInitialized
              ? SizedBox.expand(
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),

          // صفحة العرض
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              // الصفحة الأولى: فيديو
              Stack(
                children: [
                  // Center(child: Text("صفحة 1", style: TextStyle(color: Colors.white, fontSize: 24))),
                ],
              ),
              // الصفحة الثانية
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16), // بادنج من اليمين واليسار
                color: AppColors.newa.withOpacity(0.9), // لون مع شفافية
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Al Amin 👋'.tr,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Open your account and apply for your stylish green card. Enjoy complete control of your account, manage your savings, pay your bills, track your spending and much more!'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // الصفحة الثالثة
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16), // بادنج من اليمين واليسار
                color: AppColors.newa.withOpacity(0.9), // لون مع شفافية
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // العنوان
                      Text(
                         'Control in Your Hands 100%'.tr,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // قائمة الميزات مع 5 نقاط
                      SizedBox(height: 30),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.red),
                              SizedBox(width: 10),
                              Text(
                                'Login as a guest'.tr,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.money_rounded, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                'Loan details'.tr,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.security, color: Colors.blue),
                              SizedBox(width: 10),
                              Text(
                               "Secure and Fast Login".tr,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.support_agent, color: Colors.yellow),
                              SizedBox(width: 10),
                              Text(
                               "24/7 Support".tr,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.settings, color: Colors.purple),
                              SizedBox(width: 10),
                              Text(
                                'Custom Settings'.tr,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

          // زر تسجيل الدخول
          Positioned(
            bottom: 30,
            left: 50,
            right: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min, // استخدام العمود لتكديس الأزرار
              children: [
                // إضافة النقاط هنا فوق الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      width: _currentPage == index ? 12.0 : 8.0,
                      height: _currentPage == index ? 12.0 : 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index ? AppColors.newa2 : Colors.grey,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20), // مسافة بين النقاط والأزرار
                ElevatedButton(
                  onPressed: () {
                    // تنفيذ إجراء تسجيل الدخول هنا
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.newa,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fixedSize: Size(380, 50), // تحديد الحجم الثابت للزر
                  ),
                  child: Text(
                    'Create an Account'.tr,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10), // مسافة بين الزرين
               ElevatedButton(
                  onPressed: () {
                    // تنفيذ إجراء تسجيل الدخول هنا
                    Get.to(LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.newa,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    fixedSize: Size(380, 50), // تحديد الحجم الثابت للزر
                  ),
                  child: Text(
                    'Login'.tr,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // زر تغيير اللغة
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
               TextButton(
  onPressed: _toggleLanguage, // Call the function here
  style: TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(
        Icons.language,
        color: AppColors.newa2,
      ),
      const SizedBox(width: 8.0),
      Text(
        'Switch Language'.tr,
        style: GoogleFonts.cairo(
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ],
  ),
),

// Define the function outside of the onPressed callback

                  Spacer(),
                  TextButton(
                    onPressed: () async {
                        Get.to(loanshome()) ;
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.person,
                          color: AppColors.newa2,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Login as a guest'.tr,
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
