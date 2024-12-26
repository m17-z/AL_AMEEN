import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_helper.dart'; // Add this import

import '../model/user_model.dart';

Future<Map<String, dynamic>> openSession(String customerId) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/OpenSession");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': customerId}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);
    if (responseData['status'] == 1) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userDetails = responseData['userDetails'];
      await prefs.setString('authToken', userDetails['authToken']);
      await prefs.setString('customerId', userDetails['customerId']);
      await prefs.setString('firstName', userDetails['firstName']);
      await prefs.setString('lastName', userDetails['lastName']);
      await prefs.setString('address', userDetails['address']);
      await prefs.setString('mobileNo', userDetails['mobileNo']);
      await prefs.setString('userDetails', json.encode(userDetails));

      // Print the saved response to the console
      print('authToken: ${prefs.getString('authToken')}');
      print('customerId: ${prefs.getString('customerId')}');
      print('firstName: ${prefs.getString('firstName')}');
      print('lastName: ${prefs.getString('lastName')}');
      print('address: ${prefs.getString('address')}');
      print('mobileNo: ${prefs.getString('mobileNo')}');
      print('userDetails: ${prefs.getString('userDetails')}');
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
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final storedCustomerId = prefs.getString('customerId');
  final storedAuthToken = prefs.getString('authToken');

  if (storedCustomerId == null || storedAuthToken == null) {
    throw Exception('Customer ID or Auth Token not found');
  }

  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CurrentLoan");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: json.encode({'customerId': storedCustomerId, 'authToken': storedAuthToken}),
  );

  if (response.statusCode == 200) {
    final responseBody = utf8.decode(response.bodyBytes); // Ensure correct decoding to UTF-8
    final responseData = json.decode(responseBody);

    if (responseData['status'] == 1) {
      await prefs.setString('currentLoan', json.encode(responseData));
      // Print the saved response to the console
      print('currentLoan: ${prefs.getString('currentLoan')}');
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
