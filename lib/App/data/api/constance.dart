
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
//rgb(120, 254, 253)
class Constants {
  static const primaryColor = Color.fromRGBO(84, 25, 17, 1.0);
  static const fontColor = Color.fromRGBO(93, 63, 5, 1.0);
  // static const yellowColor = Color.fromRGBO(255, 220, 96,1);
  // static const blackColor = Color.fromRGBO(40, 43, 51,1);
  // static const wightColor = Color.fromRGBO(255, 255, 255, 1.0);
}


 class API {
  static final String ANDROID_DEVICE_TYPE = "0";
  // Live Server
  static final String BASE_URL = "http://212.35.73.173/webservice//index.php/api/";
  static final String PAYMENT_URL = "http://212.35.73.173/paymentRequest.php?loanId=%1\$s&amount=%2\$s&customerId=%3\$s";
  static final String userRegistration = BASE_URL + "userRegistration";
  static final String userAutantication = BASE_URL + "userAutantication";
  static final String sendOtp = BASE_URL + "sendOtp";
  static final String getNews = BASE_URL + "getNews";
  static final String changeMpin = BASE_URL + "changeMpin";
  static final String contactUs = BASE_URL + "contactUs";
  static final String getOffer = BASE_URL + "getOffer";
  static final String offerApply = BASE_URL + "offerApply";
  static final String updateDeviceToken = BASE_URL + "updateDeviceToken";
  static final String OpenSession_2 = "http://192.168.0.45:7005/RestfulApp/resources/generatetoken/OpenSession";
  // Client Delta Server API
  static final String BASE_CLIENT_URL = "http://212.35.73.172:7003/RestfulApp/jersey/generatetoken/";
  static final String OpenSession = BASE_CLIENT_URL + "OpenSession";
  static final String CurrentLoan = BASE_CLIENT_URL + "CurrentLoan";
  static final String NextEMI = BASE_CLIENT_URL + "NextEMI";
  static final String CloseSession = BASE_CLIENT_URL + "CloseSession";
  static final String DownloadStatement = BASE_CLIENT_URL + "DownloadStatement?";

  // eWF Server API
  static final String BASE_EWF_URL = "http://212.35.73.172:8181/Service1.asmx";
}
