import 'dart:async';
import 'package:al_ameen/App/modules/register/formfields.dart';
import '../Home/View/home.dart';
import '../unused_filles/splash/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/api/data from user.dart' as dataFromUser;
import '../../data/api/session.dart';
import '../../helper/Colors2.dart';
import '../../helper/cusoum_snackbar.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_text.dart';

import '../OnbordingScreen/splash.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  bool isLoading = false; // Add loading state

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
        print("Customer ID not found");
      }
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
      print(e.toString());
    }
  }

  /// Handle Next button press
  Future<void> handleNext() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate delay for loading

      if (loginPage == 0) {
        // Step 1: Fetch customer details using the entered customer ID
        final response = await openSession(controller0.text.trim());
        if (response != null && response['status'] == 1) {
          final userDetails = response['userDetails'];
          final authToken = userDetails['authToken'];
          final customerId = userDetails['customerId'];
          final firstName = userDetails['firstName']; // Extract first name
          final lastName = userDetails['lastName'];   // Extract last name
          setState(() {
            loginPage = 1;
            controller1.text = '';  // Clear mobile field so it's not editable
            customAddress = userDetails['address'].substring(userDetails['address'].length - 3);  // Store the last 3 digits for display
          });
        } else {
          CustomSnackBar.warning(message: "Customer ID not found");
          print("Customer ID not found");
        }
      } else if (loginPage == 1) {
        // Step 2: Start timer and move to next screen for the identification code
        String phone = controller1.text.trim();
        String customerId = controller0.text.trim();
        final response = await fetchOtp(phone, customerId);  // Fetch OTP from API
        if (response != null && response['status'] == 'success') {
          setState(() {
            loginPage = 2;
          });
        } else {
          CustomSnackBar.error(message: 'Failed to send OTP');
          print('Failed to send OTP');
        }
      } else if (loginPage == 2) {
        // Step 3: Verify the OTP entered by the user
        String customerId = controller0.text.trim();
        String otp = pinCode.text.trim();
        final response = await verifyOtp(customerId, otp);
        if (response != null && response['status'] == 'success' && response['otp'] == otp) {
          setState(() {
            loginPage = 3;  // Proceed to password creation
          });
        } else {
          CustomSnackBar.error(message: 'Failed to verify OTP');
          print('Failed to verify OTP');
        }
      } else if (loginPage == 3) {
        // Step 4: Create a 6-digit password
        if (_formKey.currentState!.validate()) {
          setState(() {
            loginPage = 4;
          });
        } else {
          CustomSnackBar.error(message: 'Please create a valid password');
          print('Please create a valid password');
        }
      } else if (loginPage == 4) {
        // Step 5: Confirm the entered password matches the confirmed password
        if (controllerTextForm.join() == conformTextForm.join()) {
          // Step 6: Update the password
          String customerId = controller0.text.trim();
          String password = controllerTextForm.join();
          final response = await updatePassword(customerId, password);
          if (response != null && response['status'] == 'success') {
            // If password update is successful, proceed to the HomeScreen
            final openSessionResponse = await openSession(customerId);
            final authToken = openSessionResponse['userDetails']['authToken'];
            final firstName = openSessionResponse['userDetails']['firstName']; // Extract first name
            final lastName = openSessionResponse['userDetails']['lastName']; 
            final  mobileNo= openSessionResponse['userDetails']['mobileNo']; 
            final address = openSessionResponse['userDetails']['address']; 

            Get.offAll(() => loanshome(authToken: authToken, customerId: customerId, firstName: firstName, lastName: lastName, mobileNo: mobileNo, address: address,));
          } else {
            CustomSnackBar.error(message: 'Failed to update password');
            print('Failed to update password');
          }
        } else {
          Get.snackbar('Error', 'Passwords do not match');
          print('Passwords do not match');
        }
      }
    } catch (e) {
      // Handle error without changing the page
      Get.snackbar('Error', e.toString());
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => canPop,
      child: Scaffold(
        backgroundColor:  Color(0xFFEBEBEB),
        body: Stack(
          alignment: Alignment.center, // Center the stack's children
          children: [
            // Background Container
            Positioned(
              top: 0,
              child: Container(
                height: Get.height * 0.5,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.newa,
                ),
                child: SafeArea(
                  bottom: false,
                  child: _buildHeader(),
                ),
              ),
            ),

            // Positioned Card
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: _buildCard(context),
              ),
            ),

            // Loading Indicator
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),

            // Back Button
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

            // Interactable Area in Lower Page
            Positioned(
              bottom: 20, // Adjust as needed
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // ...existing code...
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Form( // Wrap the card with Form widget
      key: _formKey,
      child: Container(
        width: Get.width * 0.95,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _buildCardContent(),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
          pinCode: pinCode,
          setState: setState,
          controllerTextForm: controllerTextForm,
          conformTextForm: conformTextForm,
          maxLength: maxLength,
        ),
        SizedBox(height: 25),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomButton.buttonStyle(
              text: "Next".tr,
              width: Get.width * 0.4,
              height: Get.height * 0.08,
              onPressed: isLoading ? null : handleNext, // Disable button when loading
            ),
            if (isLoading)
              Container(
                width: Get.width * 0.4,
                height: Get.height * 0.08,
                color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
              ),
          ],
        ),
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
                
              });
            },
            child: Container(
              width: Get.width * 0.3,
              height: Get.height * 0.08,
              padding: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  border: Border.all(width: 2, color: Colors.blue.shade800)),
              child: FittedBox(child: CustomText(text: 'Resend'.tr)),
            ),
          ),
        SizedBox(height: 50),
      ],
    );
  }

  Widget _buildBackButton(VoidCallback onTap) {
    return Positioned(
      top: 40,
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
            color: loginPage > 0 ? Colors.black : AppColors.textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Colors.white,
                ),
              ),
            ],
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