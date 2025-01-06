import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_helper.dart'; // Add this import

import '../model/user_model.dart';

Future<Map<String, dynamic>> openSession(String customerId) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/OpenSession");
      print('ID : ${customerId}');

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': customerId}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);
    if (responseData['status'] == 1) {
      final userDetails = responseData['userDetails'];
      await StorageHelper.saveUserDetails(userDetails);

      // Print the saved response to the console
      print('authToken: ${userDetails['authToken']}');
      print('customerId: ${userDetails['customerId']}');
      print('firstName: ${userDetails['firstName']}');
      print('lastName: ${userDetails['lastName']}');
      print('address: ${userDetails['address']}');
      print('mobileNo: ${userDetails['mobileNo']}');
      print('userDetails: ${json.encode(userDetails)}');
    }
    return responseData;
  } else {
    throw Exception('فشل الاتصال بالخادم');
  }
}

Future<Map<String, dynamic>> closeSession(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CloseSession");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    return json.decode(responseBody);
  } else {
    throw Exception('فشل في تسجيل الخروج');
  }
}

Future<Map<String, dynamic>> currentLoan(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CurrentLoan");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);

    if (responseData['status'] == 1) {
      // Print the saved response to the console
      print('currentLoan: ${json.encode(responseData)}');
    }

    return responseData;
  } else {
    throw Exception('فشل في جلب تفاصيل القرض');
  }
}

Future<List<Loan>> fetchLoans(String customerId, String authToken) async {
  final response = await http.get(
    Uri.parse('http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CurrentLoan'),
    headers: {
      'Authorization': 'Bearer $authToken',
      'Customer-Id': customerId,
    },
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final data = json.decode(responseBody);
    final loanList = (data['loanList'] as List)
        .map((loan) => Loan.fromJson(loan))
        .toList();
    return loanList;
  } else {
    throw Exception('فشل في تحميل القروض');
  }
}

Future<Map<String, dynamic>> nextEMI(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/NextEMI");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    return json.decode(responseBody);
  } else {
    throw Exception('فشل في جلب تفاصيل القسط التالي');
  }
}

Future<Map<String, dynamic>> fetchOtp(String phone, String customerId) async {
  // Check if the first number is '0' and replace it with '962'
  if (phone.startsWith('0')) {
    phone = '962' + phone.substring(1);
  }

  final url = Uri.parse("http://192.168.1.143:8099/alameen/otp?phone=$phone&name=$customerId");

  // Print the phone to the console
  print('Phone: $phone');
  print('customerId: $customerId');

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);
    final otp = responseData['otp'].toString();

    // Print the saved OTP to the console
    print('otp: $otp');
    return responseData; // Return the response data
  } else {
    throw Exception('Failed to fetch OTP');
  }
}

Future<Map<String, dynamic>> verifyOtp(String customerId, String otp) async {
  final url = Uri.parse("http://192.168.1.143:8099/alameen/showotp?customerid=$customerId&otp=$otp");

  try {
    final response = await http.get(url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    print('customerId: $customerId');

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
      final responseData = json.decode(responseBody);

      if (responseData['status'] == 'success') {
        // Print the response data to the console
        print('Response Data: $responseData');
        return responseData;
      } else {
        // Print the error message to the console
        print('Error: OTP does not match');
        throw Exception('OTP does not match');
      }
    } else {
      // Print the error message to the console
      print('Error: Failed to verify OTP, Status Code: ${response.statusCode}');
      throw Exception('Failed to verify OTP, Status Code: ${response.statusCode}');
    }
  } catch (e) {
    // Print the error message to the console
    print('Error: $e');
    throw Exception('Failed to verify OTP: $e');
  }
}

Future<Map<String, dynamic>> updatePassword(String customerId, String password) async {
  final url = Uri.parse("http://192.168.1.143:8099/alameen/seendpassword?customerid=$customerId&password=$password");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);

    // Print the response data to the console
    print('Response Data: $responseData');

    if (responseData['status'] == 'success') {
      return responseData;
    } else {
      throw Exception('Failed to update password');
    }
  } else {
    throw Exception('Failed to update password');
  }
}
