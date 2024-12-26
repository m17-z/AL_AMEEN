import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/colors.dart';
import '../../helper/coustom_card_loan_test.dart';
import '../../helper/cusoum_snackbar.dart';
import 'drawer.dart';
import 'loan_screen.dart';
import '../../data/api/session.dart'; // Import the session API

class LoanPage extends StatefulWidget {
  const LoanPage({Key? key}) : super(key: key);

  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
    fetchLoanDetails(); // Fetch loan details on init
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
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
        ).then((_) {
          _startAutoScroll();
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchLoanDetails() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final customerId = prefs.getString('customerId');
      final authToken = prefs.getString('authToken');
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';

      // Debugging prints
      print('Fetching loan details...');
      print('SharedPreferences contents:');
      print('customerId: $customerId');
      print('authToken: $authToken');
      print('firstName: $firstName');
      print('lastName: $lastName');

      if (customerId == null || authToken == null) {
        CustomSnackBar.error(message: 'Customer ID or Auth Token not found');
        return;
      }

      // Print the values before making the request
      print('Making request with:');
      print('customerId: $customerId');
      print('authToken: $authToken');

      final response = await currentLoan(customerId, authToken);

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
        CustomSnackBar.warning(message: "Failed to fetch loan details");
      }
    } catch (e) {
      CustomSnackBar.error(message: e.toString());
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
                  Navigator.of(context).pop();
                  LoanScreen.navigateToLoanScreen(
                    imagePath: 'assets/images/splash.png',
                    sectionTitle: 'Loan Details'.tr,
                    loanDetails: [_selectedLoan!],
                  );
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
    Get.to(() => LoanScreen(loanDetails: [loan]), arguments: loan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(
        onLogout: () {},
        color: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Combined Header and Top Section with Loan Details
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.newa,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: CircleAvatar(
                              radius: 30, // تكبير حجم الصورة
                              backgroundImage: AssetImage("assets/images/profile.jpg"),
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Circular percentage indicator
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: CircularProgressIndicator(
                            value: totalPercentage, // Total borrowed percentage
                            backgroundColor: Colors.white.withOpacity(0.3),
                            color: Colors.white,
                            strokeWidth: 10,
                          ),
                        ),
                        Text(
                          "${(totalPercentage * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontSize: 24,
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
                        fontSize: 32,
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Loan Status".tr, style: TextStyle(color: Colors.white70)),
                            Text(loans.isNotEmpty ? loans[0]['status'] : "N/A",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total loan amount'.tr, // .tr resolves the key to the translation
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
                            Text("Loan Start Date".tr, style: TextStyle(color: Colors.white70)),
                            Text(loans.isNotEmpty ? loans[0]['startDate'] : "N/A",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
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
                    SizedBox(
                      width: 20,
                    ),
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
              SizedBox(height: 10),
              // Loan Details Section with percentage
              SizedBox(
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: loans.length,
                  itemBuilder: (context, index) {
                    return LoanCard(
                      loan: loans[index],
                      scrollController: _scrollController,
                      onTapLoan: (Map<String, String> loan) {
                        _navigateToLoanDetails(loan);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
