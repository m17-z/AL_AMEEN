class UserModel {
  bool? success;
  String? message;
  Login? login;

  UserModel({this.success, this.message, this.login});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    message = json['message'];
    login = json['login'] != null ? Login.fromJson(json['login']) : null;
  }
}

class Login {
  String? userID;
  String? name;
  String? urlImage;
  String? typeID;
  String? pHPSESSID;

  Login({this.userID, this.name, this.urlImage, this.typeID, this.pHPSESSID});

  Login.fromJson(Map<String, dynamic> json) {
    userID = json['UserID'];
    name = json['Name'];
    urlImage = json['UrlImage'];
    typeID = json['TypeID'];
    pHPSESSID = json['PHPSESSID'];
  }
}
class Loan {
  final String loanId;
  final String loanType;
  final String loanAmount;
  final String loanStatus;
  final String loanStartDate;
  final String interestRate;
  final String loanTenure;

  Loan({
    required this.loanId,
    required this.loanType,
    required this.loanAmount,
    required this.loanStatus,
    required this.loanStartDate,
    required this.interestRate,
    required this.loanTenure,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      loanId: json['loanId'],
      loanType: json['loanType'],
      loanAmount: json['loanAmount'],
      loanStatus: json['loanStatus'],
      loanStartDate: json['loanStartDate'],
      interestRate: json['interestRate'],
      loanTenure: json['loanTenure'],
    );
  }
}
