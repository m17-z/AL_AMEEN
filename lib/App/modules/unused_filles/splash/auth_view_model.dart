import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Home/View/home.dart';
import '../home.dart';
import '../../register/login_screen.dart';
import '../home_screen.dart';
import '../../../helper/status_request.dart';
import '../../../data/model/user_model.dart';
import 'preferences.dart';
class AuthViewModel extends GetxController {
  late Rx<UserModel?> user;
  UserModel? userModel;
  SharedPreferences? prefs;
  Future<void> login({required String Username,required String PinCode }) async {
    prefs = await SharedPreferences.getInstance();
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'action': 'login',
      };
      final response = await http.post(
        Uri.parse(""+"User.php"),
        headers: headers,
        body: {'Username': Username, 'PinCode': PinCode},
      );
    print('response false: ${response.body}');
      if (response.statusCode == 200) {

        print('response : ${response.body}');
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic>) {
          userModel = UserModel.fromJson(responseData);
          if (userModel!.success == true) {
            Get.snackbar("${userModel!.success}", "${userModel!.message}");
            await prefs?.setString('name', userModel!.login!.name.toString());
            await prefs?.setString('typeID', userModel!.login!.typeID.toString());
            await prefs?.setString('userID', userModel!.login!.userID.toString());
            await prefs?.setString('urlImage', userModel!.login!.urlImage.toString());
          // حفظ حالة تسجيل الدخول
            await Preferences.saveUserLoggedIn(true);
                        Get.offAll((loanshome(authToken: '', customerId: '', firstName: '', lastName: '', mobileNo: '', address: '',)));
          } else {
            Get.snackbar("Failure", userModel!.message ?? "An error occurred during login.");
          }
        }

        else if (responseData is bool) {
          if (responseData == true) {
            Get.snackbar("Success", "Login Successful");
                        Get.offAll((loanshome(authToken: '', customerId: '', firstName: '', lastName: '', mobileNo: '', address: '',)));
          } else {
            Get.snackbar("Failure", "Login failed");
          }
        } else {
          Get.snackbar("Error", "Response is not in the expected format.");
        }
      } else if (response.statusCode == 404) {
        Get.snackbar("Error", "The page was not found.");
      } else {
        print("API request encountered an error: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }
    } catch (error) {
      Get.snackbar("Failure", "Login failed");
    }
  }

  Future<dynamic> logout() async {
    prefs = await SharedPreferences.getInstance();
 //   cashViewModel.prefs = await SharedPreferences.getInstance();

    prefs!.clear();
   // cashViewModel.prefs!.clear();

    try {
      await Preferences.saveUserLoggedIn(false);
      Get.offAll( LoginScreen());
      return (StatusRequest.success);
    } catch (error) {
      return (StatusRequest.serverException);
    }
  }
}