import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/Colors2.dart';
import '../../helper/custom_wave.dart';
import '../../helper/custom_divider_with_text.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  String? selectedBranch;

  final Map<String, Map<String, String>> branchDetails = {
    'Headquarters'.tr: {
      'location'.tr: 'DABOUQ-Mohammad Khair Amaano St.- above Arab Bank - building 62 1st floor'.tr,
      'phone'.tr: '06-5338908'.tr,
      'fax'.tr: '06-5338908'.tr,
      'poBox'.tr: '3434 Amman 11821 Jordan'.tr,
    },
    'Sweileh'.tr: {
      'location'.tr: 'Sweileh Queen Rania Al Abdullah St. opposite of Sameh Mall - building 436 3rd floor'.tr,
      'phone'.tr: '06-5345522'.tr,
      'fax'.tr: '06-5338909'.tr,
    },
    'Nazal'.tr: {
      'location'.tr: 'Nazal - opposite of Nazal Al-Kabeer Mosque - Aswaq Mo\'th block - building 2 first floor'.tr,
      'phone'.tr: '06-4377889'.tr,
      'fax'.tr: '06-4377883'.tr,
    },
    'Al-Zarqa': {
      'location'.tr: 'Al-Zarqa - King Talal St. - Salon St. (Nzoor Albareed) next to Salon Hanan'.tr,
      'phone'.tr: '05-3939334'.tr,
      'fax'.tr: '05-3939335'.tr,
    },
    'Irbid'.tr: {
      'location'.tr: 'New Amman Complex - Next to Jet Company'.tr,
      'phone'.tr: '02-7032120'.tr,
      'fax'.tr: '02-7032125'.tr,
    },
    'Al-Baqaa'.tr: {
      'location'.tr: 'Al-Baqaa - Alquds - Next to Housing Bank – Ground Floor'.tr,
      'phone'.tr: '06-4728585'.tr,
      'fax'.tr: '06-4728586'.tr,
    },
    'Al-Hiteen'.tr: {
      'location'.tr: 'Prince Ali St.'.tr,
      'phone'.tr: '06-4750506'.tr,
      'fax'.tr: '06-4750508'.tr,
    },
    'Al-Rusaifa'.tr: {
      'location'.tr: 'Al-Rusaifa – Yajouz St. – Ground Floor'.tr,
      'phone'.tr: '05-3742090'.tr,
    },
  };

  @override
  void initState() {
    super.initState();
    selectedBranch = 'Headquarters'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Wave Background
                ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.newa,
              ),
            ),
          ),
                // Back Button Positioned
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
           Positioned(
            top: 70,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.location_on,
                size: 50,
                color: AppColors.newa,
              ),
            ),
          ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DividerWithText(
                    text: 'Choose the branch'.tr,
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.newa, width: 1),
                    ),
                    child:DropdownButton<String>(
  value: selectedBranch,
  isExpanded: true,
  underline: SizedBox(),
  onChanged: (String? newValue) {
    setState(() {
      selectedBranch = newValue;
    });
  },
  items: branchDetails.keys.map<DropdownMenuItem<String>>((String branch) {
    return DropdownMenuItem<String>(
      value: branch, // Use untranslated key here
      child: Padding(
        padding: EdgeInsets.only(
          right: Get.locale?.languageCode == 'ar' ? 16.0 : 0.0,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            branch.tr, // Translate for display purposes only
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }).toList(),
  dropdownColor: Colors.white, // Optional: style the dropdown menu
  icon: Icon(Icons.arrow_drop_down, color: AppColors.newa), // Customize dropdown arrow
)
                  ),
                  SizedBox(height: 20),
                  if (selectedBranch != null) ...[
                    DividerWithText(
                      text: selectedBranch!.tr,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: AppColors.newa),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Location:'.tr +' ${branchDetails[selectedBranch]!['location'.tr]}'.tr,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                      Row(
                     children: [
                 Icon(Icons.phone, color: AppColors.newa),
                  SizedBox(width: 10),
                     Expanded(
                      child:Text(
                      'Phone:'.tr+' ${branchDetails[selectedBranch]!['phone'.tr]}'.tr,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300  ),
                     
                    ),
                     ),
                    ],
                    ),
                    if (branchDetails[selectedBranch]!.containsKey('fax'.tr)) ...[
                      SizedBox(height: 10),
                       Row(
                     children: [
                 Icon(Icons.print, color: AppColors.newa),
                  SizedBox(width: 10),
                     Expanded(
                      child: Text(
                        'Fax:'.tr+' ${branchDetails[selectedBranch]!['fax'.tr]}'.tr,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                       )],
                  
                    ),
                    ],
                    if (branchDetails[selectedBranch]!.containsKey('poBox'.tr)) ...[
                      SizedBox(height: 10),
                        Row(
                     children: [
                 Icon(Icons.mail, color: AppColors.newa),
                  SizedBox(width: 10),
                     Expanded(
                      child:Text(
                     
                        'P.O Box:'.tr+' ${branchDetails[selectedBranch]!['poBox'.tr]}'.tr,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                         ) ],
                    ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
