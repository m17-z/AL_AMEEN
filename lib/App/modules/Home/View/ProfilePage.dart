
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final String customerId;
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String address;

  ProfilePage({
    required this.customerId,
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.badge),
              title: Text('Customer ID'.tr),
              subtitle: Text(customerId),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('First Name'.tr),
              subtitle: Text(firstName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Last Name'.tr),
              subtitle: Text(lastName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Mobile No'.tr),
              subtitle: Text(mobileNo),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Address'.tr),
              subtitle: Text(address),
            ),
            // Add more profile details as needed
          ],
        ),
      ),
    );
  }
}