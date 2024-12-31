import 'dart:async';
import 'package:al_ameen/App/modules/register/formfields.dart';

import '../Home/View/home.dart';
import '../unused_filles/splash/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../data/api/data from user.dart' as dataFromUser;
import '../../data/api/session.dart';
import '../../helper/Colors2.dart';
import '../../helper/cusoum_snackbar.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_text.dart';
import '../../helper/custom_textformfield.dart';
import '../../helper/custom_wave.dart';
import '../OnbordingScreen/splash.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginScreen extends StatefulWidget {
  final String? baseUrlGet;
const LoginScreen({
    Key? key,
    this.baseUrlGet,
  }) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  // Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String customAddress = ''; // To store the last 3 digits of the address
  // Controllers for different fields
  final TextEditingController controller0 = TextEditingController(); // Customer ID
  final TextEditingController controller1 = TextEditingController(); // Mobile Number
  final TextEditingController controller2 = TextEditingController(); // Identification Number
  final TextEditingController pinCode = TextEditingController();
  // Controllers for 6-digit password
  List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  List<TextEditingController> _conform =
      List.generate(6, (_) => TextEditingController());
  // FocusNodes for 6-digit password
  List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  // Timer variables
  var count = 30;
  Timer? _timer;

  // ViewModel
  final AuthViewModel authController = Get.put(AuthViewModel());

  // Page navigation states
  var loginPage = 0;
  bool isOnline = true;
  bool canPop = false;

  // Text field lists for validation
  List<String> controllerTextForm = [];
  List<String> conformTextForm = [];

  // Max length for phone number
  var maxLength = 10;

  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes
    _controllers = List.generate(6, (_) => TextEditingController());
    _conform = List.generate(6, (_) => TextEditingController());
    _focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var conform in _conform) {
      conform.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    controller0.dispose();
    controller1.dispose();
    controller2.dispose();
    pinCode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// Fetch customer details from API
  Future<void> fetchCustomerDetails() async {
    try {
      final customerId = controller0.text.trim();
      // Show loading dialog

      // Fetch customer data
      final response = await openSession(customerId)
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception('Request timed out');
      });

      if (response['status'] == 1) {
        final userDetails = response['userDetails'];
        await dataFromUser.StorageHelper.saveUserDetails(userDetails);

        // Extract the last 3 digits of the mobile number

        // Extract the last 3 digits of the address
        String address = userDetails['address'];
        String last3DigitsAddress = address.substring(address.length - 3);

        setState(() {
          // Set the last 3 digits as CustomText
          loginPage = 1;  // Show next page
          controller1.text = '';  // Clear mobile field so it's not editable
          customAddress = last3DigitsAddress;  // Store the last 3 digits for display
        });
      } else {
        CustomSnackBar.warning(message: "Customer ID not found");
      }
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
    }
  }

  /// Handle Next button press
  Future<void> handleNext() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (loginPage == 0) {
          // Step 1: Fetch customer details using the entered customer ID
          await fetchCustomerDetails();
        } else if (loginPage == 1) {
          // Step 2: Start timer and move to next screen for the identification code
          setState(() {
            loginPage = 2;
          });
        } else if (loginPage == 2) {
          // Step 3: Verification of identification code (integrate your logic here)
          // Add your verification logic if needed, currently proceeding to next page
          setState(() {
            loginPage = 3;
          });
        } else if (loginPage == 3) {
          // Step 4: Logic to create a 6-digit password
          // Make sure user is creating a valid password (you can add any additional password strength logic here)
          setState(() {
            loginPage = 4;
          });
        } else if (loginPage == 4) {
          // Step 5: Confirm the entered password matches the confirmed password
          if (controllerTextForm.join() == conformTextForm.join()) {
            // If passwords match, proceed to the HomeScreen
            Get.offAll(loanshome());
          } else {
            // If passwords don't match, show an error
            Get.snackbar('Error', 'Passwords do not match');
          }
        }
      } catch (e) {
        // Handle error without changing the page
        Get.snackbar('Error', e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Custom Waves Decoration
                   
                    if (loginPage > 0)
                      _buildBackButton(() {
                        setState(() {
                          loginPage--;
                        });
                      })
                    else
                      _buildBackButton(() {
                        Get.offAll(OnboardingScreen2());
                      }),
                    Column(
                      
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        CustomText(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          text: _getHeaderText(),
                          fontsize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.8,
                        ),
                        SizedBox(height: 20),
                        FormFields.build(
                          loginPage: loginPage,
                          context: context,
                          formKey: _formKey,
                          controller0: controller0,
                          controller1: controller1,
                          controller2: controller2,
                          controllers: _controllers,
                          conform: _conform,
                          focusNodes: _focusNodes,
                          setState: setState,
                          controllerTextForm: controllerTextForm,
                          conformTextForm: conformTextForm,
                          maxLength: maxLength,
                        ),
                        SizedBox(height: 50),
                        isOnline
                            ? CustomButton.buttonStyle(
                                text: "Next".tr,
                                width: Get.width * 0.4,
                                height: Get.height * 0.08,
                                onPressed: handleNext,
                              )
                            : Lottie.asset('assets/lottie/offline.json',
                                width: 100, height: 100),
                        SizedBox(height: 10),
                        if (loginPage == 0 || loginPage == 2)
                          TextButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: CustomText(
                              text: _getResendText(),
                              fontsize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.brown[700],
                            ),
                          ),
                        SizedBox(height: 10),
                        if (count == 0 && loginPage == 2)
                          InkWell(
                            onTap: () {
                              setState(() {
                                // Resend the identification code here
                                // Integrate your resend API call
                              });
                            },
                            child: Container(
                              width: Get.width * 0.3,
                              height: Get.height * 0.08,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  border: Border.all(
                                      width: 2, color: Colors.blue.shade800)),
                              child: FittedBox(
                                  child: CustomText(text: 'Resend'.tr)),
                            ),
                          ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(VoidCallback onTap) {
    return Positioned(
      top: 40, // Adjust for the safe area
      left: 16,
      child: GestureDetector(
        onTap: onTap,
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
            color: loginPage > 0 ? Colors.black : AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.newa,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  alignment: Alignment.topRight,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 15),
                  Center(
                    // ...existing code...
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: Get.width * 0.26,
            height: Get.height * 0.26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getHeaderText() {
    switch (loginPage) {
      case 0:
        return 'Enter your customer number'.tr;
      case 1:
        return 'Please enter your mobile phone number ending with'.tr +
            '  ' +
            customAddress +
            '\n';
      case 2:
        return 'We have sent the identification number to your phone number, please enter the code'
            .tr;
      case 3:
        return 'Please create your own 6-digit password'.tr;
      case 4:
        return 'Please confirm your 6-digit password'.tr;
      default:
        return '';
    }
  }

  String _getResendText() {
    if (loginPage == 0) {
      return ''.tr;
    } else if (loginPage == 2) {
      return 'You did not receive the identification code? Send again later'.tr +
          '   $count   ' +
          'second'.tr;
    }
    return '';
  }
}
