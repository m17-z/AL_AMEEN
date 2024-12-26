import 'custom_text.dart';
import 'package:flutter/material.dart';

class LoanDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const LoanDetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontWeight: FontWeight.w600,
            fontsize: 15,
          ),
          CustomText(
            text: value,
            fontWeight: FontWeight.w600,
            fontsize: 15,
            color: Colors.blue[800],
          ),
        ],
      ),
    );
  }
}
