import 'dart:convert';
import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/CustomLoanCard.dart';

class FinancialOverviewPage extends StatefulWidget {
  @override
  _FinancialOverviewPageState createState() => _FinancialOverviewPageState();
}

class _FinancialOverviewPageState extends State<FinancialOverviewPage> {
  String _paidAmount = '\$0.00';
  String _remainingAmount = '\$0.00';
  String _paidPercentage = '0.0%';
  String _remainingPercentage = '0.0%';
  TextEditingController _dateController = TextEditingController();
  Map<String, dynamic>? _searchedInstallment;
  List<Map<String, dynamic>> _installments = [];
  List<Map<String, dynamic>> _filteredInstallments = [];
  List<String> _availableDates = [];
  Map<String, dynamic>? _loanDetails;
  String _loanId = '';
  String _loanType = '';
  String _loanStatus = '';
  String _interestRate = '';

  @override
  void initState() {
    super.initState();
    fetchLoanDetails();
  }

  Future<void> fetchLoanDetails() async {
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
        final loan = responseData['loanList'][0];
        final totalAmount = double.parse(loan['loanAmount']);
        final paidAmount = loan['loanStatement']
            .map((installment) => double.parse(installment['paidAmount']))
            .reduce((a, b) => a + b);
        final remainingAmount = totalAmount - paidAmount;
        final paidPercentage = (paidAmount / totalAmount) * 100;
        final remainingPercentage = 100 - paidPercentage;

        // Store the current loan data in SharedPreferences
        await prefs.setString('currentLoan', json.encode(loan));

        // Update the UI with the calculated values
        setState(() {
          _paidAmount = '\$${paidAmount.toStringAsFixed(2)}';
          _remainingAmount = '\$${remainingAmount.toStringAsFixed(2)}';
          _paidPercentage = '${paidPercentage.toStringAsFixed(1)}%';
          _remainingPercentage = '${remainingPercentage.toStringAsFixed(1)}%';
          _installments = List<Map<String, dynamic>>.from(loan['loanStatement'].map((item) => Map<String, dynamic>.from(item)));
          _filteredInstallments = _installments;
          _availableDates = _installments.map((inst) => inst['installmentDate'] as String).toSet().toList();
          _loanDetails = loan;
          _loanId = loan['loanId'];
          _loanType = loan['loanType'];
          _loanStatus = loan['loanStatus'];
          _interestRate = loan['interestRate'];
        });
      } else {
        // Handle the case where the response status is not success
        print('Failed to fetch loan details');
      }
    } else {
      // Handle the case where the API call fails
      print('Failed to fetch loan details from API');
    }
  }

  void _searchInstallmentByDate(String date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedLoan = prefs.getString('currentLoan');
    if (storedLoan != null) {
      final loan = json.decode(storedLoan);
      final installments = loan['loanStatement'].where(
        (inst) => inst['installmentDate'] == date,
      ).map((item) => Map<String, dynamic>.from(item)).toList();
      setState(() {
        _filteredInstallments = List<Map<String, dynamic>>.from(installments);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final String? picked = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Installment Date'),
          children: _availableDates.map((date) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, date);
              },
              child: Text(date),
            );
          }).toList(),
        );
      },
    );
    if (picked != null) {
      _dateController.text = picked;
      _searchInstallmentByDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.newa,
      body: Column(
        children: [
          // Creative Design for Loan Overview Text
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                'Loan Overview',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                
                ),
              ),
            ),
          ),
          // Paid and Remaining Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Paid'.tr, _paidAmount, _paidPercentage, Colors.green),
                _buildStatCard('Remaining'.tr, _remainingAmount, _remainingPercentage, Colors.orange),
              ],
            ),
          ),
          // Loan Details Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Search Installment Date',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.calendar_today, color: Colors.white),
                //   onPressed: () => _selectDate(context),
                // ),
              ],
            ),
          ),
          // Transactions List
           Expanded(
  child: Container(
    decoration: BoxDecoration(
      color: AppColors.backgroundColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          // Check if there are filtered installments
          if (_filteredInstallments.isNotEmpty) ...[
            CustomLoanCard(
              loanId: _loanId,
              loanType: _loanType,
              loanAmount: _filteredInstallments[0]['installmentAmount']
                  .toString(),
              loanStatus: _loanStatus,
              loanStartDate: _filteredInstallments[0]['installmentDate'],
              interestRate: _interestRate,
              isArabic: false,
              installmentNo: _filteredInstallments[0]['installmentNo']
                  .toString(),
              paidAmount: _filteredInstallments[0]['paidAmount'].toString(),
              installmentStatus: _filteredInstallments[0]['installmentStatus']
                  .toString(),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.newa, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ] else
            Center(
              child: Text(
                'No installment found for the selected date.',
                style: const TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
    ),
  ),
  
)

        ],
      ),
    );
  }

  // Helper widget for stats cards
  Widget _buildStatCard(
      String title, String amount, String percentage, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            percentage,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}