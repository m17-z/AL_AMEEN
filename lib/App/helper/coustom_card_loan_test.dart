import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:al_ameen/App/helper/Colors2.dart';

class LoanCard extends StatelessWidget {
  final Map<String, dynamic> loan;
  final ScrollController scrollController;
  final Function(Map<String, String>) onTapLoan;

  const LoanCard({
    Key? key,
    required this.loan,
    required this.scrollController,
    required this.onTapLoan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double loanPercentage = (loan['paid'] as double) / (loan['amount'] as double);
    IconData loanIcon;

    // Set the loan icon based on loan type
    switch (loan['type']) {
      case 'Home':
        loanIcon = Icons.home;
        break;
      case 'Car':
        loanIcon = Icons.directions_car;
        break;
      case 'Personal':
        loanIcon = Icons.person;
        break;
      case 'University':
        loanIcon = Icons.school;
        break;
      default:
        loanIcon = Icons.attach_money;
    }

    return GestureDetector(
      onTap: () => onTapLoan(loan.map((key, value) => MapEntry(key, value.toString()))),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(left: 30 , right: 30),
       // padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.85,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.newa,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(loanIcon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan['type'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Active".tr,
                      style: TextStyle(
                        fontSize: 14,
                  //      color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
              children: [
                _buildInfoRow("Amount".tr, "\$${(loan['amount'] as double).toStringAsFixed(2)}", context),
                _buildInfoRow("Interest".tr, "${loan['interest']}%", context),
                _buildInfoRow("Loan ID".tr, "${loan['ID']}", context),
                _buildInfoRow("Due Date".tr, "${loan['dueDate']}", context),
                const SizedBox(height: 10),
                 Text(

              "Percentage Paid".tr + ": ${(loanPercentage * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                fontSize: 16,
                 fontWeight: FontWeight.bold,
                  color: Colors.black
                  
                  ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: loanPercentage,
            //    backgroundColor: Colors.white.withOpacity(0.3),
                color: AppColors.newa,
                minHeight: 8,
              ),
            ),
              ],
              ),
              
            ),
           
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16,                 color: Colors.black,
),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
                        color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
