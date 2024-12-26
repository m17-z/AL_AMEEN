import 'dart:async';
import '../modules/Home/View/home_screen.dart';
import '../modules/splash/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/api/session.dart';
import '../helper/custom_snack.dart';
import '../data/api/storage_helper.dart';
import '../modules/Home/View/home.dart'; // Add this import

class LoginController extends GetxController {
  // Form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String customMobileNo = ''; // To store the last 3 digits

  // Controllers for different fields
  final TextEditingController controller0 = TextEditingController(); // Customer ID
  final TextEditingController controller1 = TextEditingController(); // Mobile Number
  final TextEditingController controller2 = TextEditingController(); // Identification Number
  final TextEditingController pinCode = TextEditingController();

  // Controllers for 6-digit password
  List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());
  List<TextEditingController> conform = List.generate(6, (_) => TextEditingController());

  // FocusNodes for 6-digit password
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  // Timer variables
  var count = 30;
  Timer? timer;

  // ViewModel
  final AuthViewModel authController = Get.put(AuthViewModel());

  // Page navigation states
  var loginPage = 0.obs;
  bool isOnline = true;
  bool canPop = false;

  // Text field lists for validation
  List<String> controllerTextForm = [];
  List<String> conformTextForm = [];

  // Max length for phone number
  var maxLength = 10;

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers and focus nodes
    controllers = List.generate(6, (_) => TextEditingController());
    conform = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void onClose() {
    // Dispose all controllers and focus nodes
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var conform in conform) {
      conform.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    controller0.dispose();
    controller1.dispose();
    controller2.dispose();
    pinCode.dispose();
    timer?.cancel();
    super.onClose();
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
        await StorageHelper.saveUserDetails(userDetails);
        // Extract the last 3 digits of the mobile number
        String mobileNo = userDetails['mobileNo'];
        String last3Digits = mobileNo.substring(mobileNo.length - 3);

        customMobileNo = last3Digits;  // Store the last 3 digits for display
        controller1.text = '';  // Clear mobile field so it's not editable
        loginPage.value = 1;  // Show next page
      } else {
        CustomSnackBar.warning(message: "Customer ID not found");
      }
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
    }
  }

  /// Handle Next button press
  Future<void> handleNext() async {
    if (formKey.currentState!.validate()) {
      try {
        if (loginPage.value == 0) {
          // Step 1: Fetch customer details using the entered customer ID
          await fetchCustomerDetails();
          if (controller1.text.isNotEmpty) {
            loginPage.value = 1;
          }
        } else if (loginPage.value == 1) {
          // Step 2: Start timer and move to next screen for the identification code
          loginPage.value = 2;
        } else if (loginPage.value == 2) {
          // Step 3: Verification of identification code (integrate your logic here)
          // Add your verification logic if needed, currently proceeding to next page
          loginPage.value = 3;
        } else if (loginPage.value == 3) {
          // Step 4: Logic to create a 6-digit password
          // Make sure user is creating a valid password (you can add any additional password strength logic here)
          loginPage.value = 4;
        } else if (loginPage.value == 4) {
          // Step 5: Confirm the entered password matches the confirmed password
          if (controllerTextForm.join() == conformTextForm.join()) {
            // If passwords match, proceed to the HomeScreen
            Get.offAll(HomeScreen(customerId: '', authToken: '',));
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
}