import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        width: 350, // Fixed width for the container
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(loanIcon, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      '${loan['type']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Active".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount:".tr + "\$${(loan['amount'] as double).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey)),
                Text("Interest:".tr + " ${loan['interest']}%",
                    style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Loan ID:".tr + "${loan['ID']}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Due Date:".tr + " ${loan['dueDate']}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Percentage:".tr + " ${(loanPercentage * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 16, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Linear progress indicator width
              child: LinearProgressIndicator(
                value: loanPercentage,
                backgroundColor: Colors.grey.withOpacity(0.3),
                color: Colors.blue,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
