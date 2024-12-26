import 'package:flutter/material.dart';

import 'Colors2.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 36,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.newa,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 36,
          ),
        ),
      ],
    );
  }
}
