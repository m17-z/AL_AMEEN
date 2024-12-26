import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomLoanCard extends StatelessWidget {
  final String loanId;
  final String loanType;
  final String loanAmount;
  final String loanStatus;
  final String loanStartDate;
  final String interestRate;
  final String loanTenure;
  final bool isArabic; // Language flag to determine text alignment

  const CustomLoanCard({
    Key? key,
    required this.loanId,
    required this.loanType,
    required this.loanAmount,
    required this.loanStatus,
    required this.loanStartDate,
    required this.interestRate,
    required this.loanTenure,
    required this.isArabic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 3,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with amount and type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loanType,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$$loanAmount",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Details section
            Column(
              children: [
                _buildDetailRow(" Loan ID :".tr, loanId),
                _buildDetailRow(" Status :".tr, loanStatus),
                _buildDetailRow(" Start Date :".tr, loanStartDate),
                _buildDetailRow(" Interest Rate :".tr, "$interestRate%"),
                _buildDetailRow(" Tenure  :".tr, "$loanTenure",),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build rows with dynamic alignment
 Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  // If isArabic is true, place the value first, otherwise the label
  if (isArabic) ...[
   
    Expanded(
      child: Text(
        label,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
     Expanded(
      child: Text(
        value,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.blue
        ),
      ),
    ),
  ] else ...[
    
    Expanded(
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    Expanded(
      child: Text(
        value,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  ],
],
    ),
  );
}
}
