import 'text_theme.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icons;
  final void Function()? onTap;

  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle = '',
    required this.icons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Add rounded corners here
        ),
        elevation: 4, // Optional: Add elevation for shadow
        child: ListTile(
          title: Text(
            title,
            style: AppStyles.headLine6,
          ),
          subtitle: Text(
            subtitle,
            style: AppStyles.headLine6,
          ),
          leading: Icon(
            icons,
            size: 28, // Optional: Adjust icon size
          ),
          trailing: onTap != null
              ? const Icon(Icons.arrow_forward, color: Colors.grey)
              : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
