import 'dart:convert';
import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Add this import


import '../../../data/api/session.dart';
import '../../../helper/CustomLoanCard.dart';
import '../../../helper/cusoum_snackbar.dart';
import '../../Payment/payment_screen.dart';
import '../../../data/api/storage_helper.dart'; // Add this import


class FinancialOverviewPage extends StatefulWidget {
  final String customerId;    // Added parameter
  final String authToken;     // Added parameter

  FinancialOverviewPage({required this.customerId, required this.authToken});  // Modified constructor

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
    try {
      final loanData = await currentLoan(widget.customerId, widget.authToken); // Retrieve loan data from API

      if (loanData != null && loanData['status'] == 1) {
        final loan = loanData['loanList'][0];
        final totalAmount = double.parse(loan['loanAmount']);
        final paidAmount = loan['loanStatement']
            .map((installment) => double.parse(installment['paidAmount']))
            .fold(0.0, (sum, amount) => sum + amount);
        final remainingAmount = totalAmount - paidAmount;
        final paidPercentage = (paidAmount / totalAmount) * 100;
        final remainingPercentage = 100 - paidPercentage;

        setState(() {
          _paidAmount = '\$${paidAmount.toStringAsFixed(2)}';
          _remainingAmount = '\$${remainingAmount.toStringAsFixed(2)}';
          _paidPercentage = '${paidPercentage.toStringAsFixed(1)}%';
          _remainingPercentage = '${remainingPercentage.toStringAsFixed(1)}%';
          _installments = List<Map<String, dynamic>>.from(
              loan['loanStatement'].map((item) => Map<String, dynamic>.from(item)));
          _filteredInstallments = _installments;
          _availableDates = _installments.map((inst) => inst['installmentDate'] as String).toSet().toList();
          _loanDetails = loan;
          _loanId = loan['loanId'];
          _loanType = loan['loanType'];
          _loanStatus = loan['loanStatus'];
          _interestRate = loan['interestRate'];
        });
      } else {
        setState(() {
          _paidAmount = '\$00.00';
          _remainingAmount = '\$00.00';
          _paidPercentage = '0.0%';
          _remainingPercentage = '0.0%';
          _installments = [];
          _filteredInstallments = [];
          _availableDates = [];
          _loanDetails = null;
          _loanId = '00';
          _loanType = '00';
          _loanStatus = '00';
          _interestRate = '00';
        });
        print('Failed to fetch loan details from API');
      }
    } catch (e) {
      print('Error fetching loan details from API: $e');
      CustomSnackBar.error(message: "Failed to fetch loan details");
    }
  }

  void _searchInstallmentByDate(String date) async {
    if (!_availableDates.contains(date)) { // Validate selected date
      CustomSnackBar.error(message: "Selected date is not available");
      return;
    }
    // Remove fetching from StorageHelper and use _installments directly
    final installments = _installments.where(
      (inst) => inst['installmentDate'] == date,
    ).toList();
    print('Filtered Installments for $date: $installments'); // Debugging line
    setState(() {
      _filteredInstallments = installments;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final String? picked = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Select Installment Date'.tr),
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
      String formattedDate = picked; // Use the picked string directly
      _dateController.text = formattedDate;
      _searchInstallmentByDate(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.newa,
      body: Stack(
        children: [
          Positioned(
            top: 25, // Adjust for the safe area
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back
              },
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
                  color: AppColors.newa,
                ),
              ),
            ),
          ),
          Column(
            children: [
          // Creative Design for Loan Overview Text
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                'Loan ditales'.tr,
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
                      hintText: 'Search Installment Date'.tr,
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
          // Check if there are filtered installments
          if (_filteredInstallments.isNotEmpty) ...[
            // Iterate over all filtered installments
            ..._filteredInstallments.map((installment) => 
              CustomLoanCard(
                loanId: _loanId,
                loanType: _loanType,
                loanAmount: installment['installmentAmount'].toString(),
                loanStatus: _loanStatus,
                loanStartDate: installment['installmentDate'], // Use installmentDate from API
                interestRate: _interestRate,
                isArabic: false,
                installmentNo: installment['installmentNo'].toString(),
                paidAmount: installment['paidAmount'].toString(),
                installmentStatus: installment['installmentStatus'].toString(),
              )
            ).toList(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the payment screen
                  Get.to(PaymentScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.newa, // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Pay Now'.tr,
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
                'No installment found for the selected date.'.tr,
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