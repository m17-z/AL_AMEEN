import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';

class CustomLoanCard extends StatelessWidget {
  final String loanId;
  final String loanType;
  final String loanAmount;
  final String loanStatus;
  final String loanStartDate;
  final String interestRate;
  final bool isArabic; // Language flag to determine text alignment
  final String installmentNo;
  final String paidAmount;
  final String installmentStatus;

  const CustomLoanCard({
    Key? key,
    required this.loanId,
    required this.loanType,
    required this.loanAmount,
    required this.loanStatus,
    required this.loanStartDate,
    required this.interestRate,
    required this.isArabic,
    required this.installmentNo,
    required this.paidAmount,
    required this.installmentStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: AppColors.backgroundColor,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Loan Amount prominently displayed
            Center(
              child: Text(
                "\$$loanAmount",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
            ),
            //const SizedBox(height: 10),
            // Loan Type
            // Center(
            //   child: Text(
            //     loanType,
            //     style: const TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.w600,
            //       color: Colors.black87,
            //     ),
            //   ),
            // ),
            const Divider(color: Colors.grey, height: 30),
            // Smaller cards section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard("Loan ID", loanId),
                _buildSmallCard("Status", loanStatus),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard("Start Date", loanStartDate),
                _buildSmallCard("Interest Rate", "$interestRate%"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard("Installment No.", installmentNo),
                _buildSmallCard("Paid Amount", "\$$paidAmount"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallCard("Installment Status", installmentStatus),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build small cards
  Widget _buildSmallCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
