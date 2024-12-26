import 'package:flutter/material.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_wave.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Wave Background
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 150,
                color: AppColors.newa,
              ),
            ),
            Positioned(
              top: 40, // Adjust for the safe area
              right: 16,
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
                SizedBox(height: 70),
                // Profile Image
                Center(
                  child: CircleAvatar(
                    radius:50,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                    backgroundColor: Colors.white,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey[800],
                            child: Icon(Icons.edit, size: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Form Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildTextField("Name", nameController, Icons.person),
                      SizedBox(height: 20),
                      buildTextField("Mobile Number", mobileController, Icons.phone),
                      SizedBox(height:20  ),
                      buildTextField("Email", emailController, Icons.email),
                          SizedBox(height:20  ),
                      buildTextField("Address", addressController, Icons.home),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          print("Profile Updated");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.newa,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}