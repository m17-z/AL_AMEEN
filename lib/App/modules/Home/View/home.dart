import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async'; // Add this import at the top
import '../../../helper/colors.dart';
import '../../../helper/coustom_card_loan_test.dart';
import '../../../helper/cusoum_snackbar.dart';
import '../../Drawer/drawer.dart';
import '../../../data/api/session.dart';
import '../../OnbordingScreen/splash.dart';

import 'FinancialOverviewPage.dart';

class loanshome extends StatefulWidget {
  final String authToken;
  final String customerId;
  final String firstName; // Add first name
  final String lastName;
final String mobileNo;
  final String address;
  loanshome({
    required this.authToken,
    required this.customerId,
    required this.firstName, 
    required this.lastName,
    required this.mobileNo,
    required this.address,  
  });

  @override
  _loanshomeState createState() => _loanshomeState();
}

class _loanshomeState extends State<loanshome> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  Map<String, String>? _selectedLoan;
  List<Map<String, dynamic>> loans = [];
  double totalBorrowed = 0.0;
  double totalPaid = 0.0;
  double totalPercentage = 0.0;
  String currentDate = DateFormat('MMM d, yyyy').format(DateTime.now());
  String firstName = '';
  String lastName = '';
  Timer? _autoScrollTimer; // Add this line

  @override
  void initState() {
    super.initState();
    firstName = widget.firstName; // Set first name
    lastName = widget.lastName;   // Set last name
    print('customerId: ${widget.customerId}');    // Added for debugging
    print('firstName: ${widget.firstName}');      // Added for debugging
    print('lastName: ${widget.lastName}');        // Added for debugging
    print('mobileNo: ${widget.mobileNo}');        // Added for debugging
    print('address: ${widget.address}');          // Added for debugging
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll(); // Start the auto-scroll after the build is complete
    });
    fetchLoans();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double cardWidth = 350.0 + 16.0; // Card width + margin
        double nextOffset = (_currentIndex + 1) * cardWidth;

        if (nextOffset > maxScrollExtent) {
          nextOffset = 0;
          _currentIndex = 0;
        } else {
          _currentIndex++;
        }

        _scrollController.animateTo(
          nextOffset,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

   @override
  void dispose() {
    _autoScrollTimer?.cancel(); // Add this line
    _scrollController.dispose();
    super.dispose();
  }

 

  Future<void> fetchLoans() async {
    try {
      if (widget.customerId.isEmpty || widget.authToken.isEmpty) {
        CustomSnackBar.success(message: 'Welcome as guest');
        return;
      }

      final response = await currentLoan(widget.customerId, widget.authToken);

      // Print the response for debugging
      print('Response: $response');

      if (response['status'] == 1) {
        final List<dynamic> loanList = response['loanList'];
        setState(() {
          loans = loanList.map((loan) {
            return {
              'type': loan['loanType'],
              'ID': loan['loanId'],
              'amount': double.parse(loan['loanAmount']),
              'paid': loan['loanStatement'].fold(0.0, (sum, installment) => sum + double.parse(installment['paidAmount'])),
              'interest': double.parse(loan['interestRate']),
              'dueDate': loan['nextEMIDueDate'],
              'status': loan['loanStatus'], // Add loan status
              'startDate': loan['loanStartDate'], // Add loan start date
            };
          }).toList();
          totalBorrowed = loans.fold(0, (sum, loan) => sum + (loan['amount'] as double));
          totalPaid = loans.fold(0, (sum, loan) => sum + (loan['paid'] as double));
          totalPercentage = totalPaid / totalBorrowed;
        });
      } else {
        CustomSnackBar.success(message: "Welcome as guest");
      }
    } catch (e) {
      CustomSnackBar.success(message: "Welcome as guest");
    }
  }

  void _showMakePaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Payment'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Map<String, dynamic>>(
                hint: Text('Select Loan'.tr),
                value: _selectedLoan,
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    _selectedLoan = newValue?.map((key, value) => MapEntry(key, value.toString()));
                  });
                },
                items: loans.map<DropdownMenuItem<Map<String, dynamic>>>((Map<String, dynamic> loan) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: loan,
                    child: Text('${loan['ID']}: ${loan['type']}'),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.tr),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedLoan != null) {
                 
                  Get.to(FinancialOverviewPage(
                    customerId: widget.customerId,       // Added parameter
                    authToken: widget.authToken,         // Added parameter
                  ));
                  setState(() {
                    _selectedLoan = null;
                  });
                }
              },
              child: Text('Proceed'.tr),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLoanDetails(Map<String, String> loan) {
    Get.to(() => FinancialOverviewPage(
      customerId: widget.customerId,           // Added parameter
      authToken: widget.authToken,             // Added parameter
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50], // Subtle background color
        drawer: CustomDrawer(

          onLogout: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear(); // Clear shared preferences
            Get.off(OnboardingScreen2());
          },
          color: Colors.white,
          customerId: widget.customerId,      // Added parameter
          firstName: widget.firstName,        // Added parameter
          lastName: widget.lastName,          // Added parameter
          mobileNo: widget.mobileNo,          // Added parameter
          address: widget.address,            // Added parameter
        ),
        
        body: SingleChildScrollView(
            child: Column(
              children: [
                // Combined Header and Top Section with Loan Details
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.newa,
                         AppColors.newa.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30), // Rounded corners
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(
                              builder: (context) => IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                             Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                                    const SizedBox(height: 15),

                              Text(
                                
                                "Welcome".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'catamaran',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "$firstName $lastName".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'catamaran',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                             SizedBox(width: 40,),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Circular percentage indicator
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: totalPercentage,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                color: Colors.white,
                                strokeWidth: 8,
                              ),
                            ),
                            Text(
                              "${(totalPercentage * 100).toStringAsFixed(0)}%",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "\$${totalBorrowed.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Amount Borrowed".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Loan Status".tr,
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                      Text(
                                        loans.isNotEmpty
                                            ? loans[0]['status']
                                            : "N/A",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                  ],
                                ),
                              
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total loan amount'.tr,
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  Text(
                                    "\$${totalBorrowed.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Loan Start Date".tr,
                                      style: TextStyle(color: Colors.white70)),
                                  Text(
                                    loans.isNotEmpty
                                        ? loans[0]['startDate']
                                        : "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _showMakePaymentDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.newa,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Make Payment".tr),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Title for "All Loans Details"
                      Text(
                        "All Loans Details".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: mainFontColor,
                        ),
                      ),
                      // Date & Calendar icon
                       Row(
                      children: [
                        Text(
                          currentDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: mainFontColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.calendar_today,
                          color: mainFontColor,
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Loan Details Section with percentage
                  Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.39,
                         child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                            itemCount: loans.length,
                            itemBuilder: (context, index) {
                            return Center(
                                child: LoanCard(
                                  loan: loans[index],
                                   scrollController: _scrollController,
                                  onTapLoan: (Map<String, String> loan) {
                                   _navigateToLoanDetails(loan);
                                  },
                                ),
                              );
                            },
                         ),
                       ),
                  ),
                   ],
            ),
        ),
      );
  
  }
}