import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_wave.dart';
import '../../helper/custom_waves.dart'; // Assuming this contains your wave designs

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController coustomerid = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final firstName = prefs.getString('firstName') ?? '';
    final lastName = prefs.getString('lastName') ?? '';
    final mobileNo = prefs.getString('mobileNo') ?? '';
    final address = prefs.getString('address') ?? '';
    final customerId = prefs.getString('customerId') ?? '';

    setState(() {
      nameController.text = '$firstName $lastName';
      mobileController.text = mobileNo;
      addressController.text = address;
      coustomerid.text = customerId;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

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
            Container(
              child: Column(
                children: [
                  SizedBox(height: 70),
                  // Profile Image
                  Center(
                    child: GestureDetector(
                      onTap: () => _showImagePickerOptions(context),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/splash.png'),
                        backgroundColor: Colors.white,
                        child: Stack(
                          children: [],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Form Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        buildTextField("Name".tr, nameController, Icons.person),
                        SizedBox(height: 20),
                        buildTextField("Mobile Number".tr, mobileController, Icons.phone),
                        SizedBox(height: 20),
                        buildTextField("Customer ID".tr, coustomerid, Icons.numbers),
                        SizedBox(height: 20),
                        buildTextField("Address".tr, addressController, Icons.home),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),

                  // Custom Waves Section

                  SizedBox(height: 20),
                  // Custom Waves Section

                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
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