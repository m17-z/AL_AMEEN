import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'storage_helper.dart'; // Add this import

import '../model/user_model.dart';

Future<Map<String, dynamic>> openSession(String customerId) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/OpenSession");
  
  final response = await http.post(url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'customerId': customerId}),
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);  // إعادة الاستجابة بصيغة JSON
  } else {
    throw Exception('فشل الاتصال بالخادم');
  }
  
}

Future<Map<String, dynamic>> closeSession(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CloseSession");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('فشل في تسجيل الخروج');
  }
}

Future<Map<String, dynamic>> currentLoan(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/CurrentLoan");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
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
    final data = json.decode(response.body);
    final loanList = (data['loanList'] as List)
        .map((loan) => Loan.fromJson(loan))
        .toList();
    return loanList;
  } else {
    throw Exception('Failed to load loans');
  }
}
Future<Map<String, dynamic>> nextEMI(String customerId, String authToken) async {
  final url = Uri.parse("http://192.168.0.45:7005/RestfulApp/resources/generatetoken/NextEMI");

  final response = await http.post(url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'customerId': customerId, 'authToken': authToken}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('فشل في جلب تفاصيل القسط التالي');
  }
}
