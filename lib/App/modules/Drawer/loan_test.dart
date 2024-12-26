import 'package:al_ameen/App/helper/Colors2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import '../../helper/colors.dart';
import 'drawer.dart';
import 'loan_screen.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({Key? key}) : super(key: key);

  @override
  _LoanPageState createState() => _LoanPageState();
}
 final List<Map<String, Object>> loans = [
      {'type': 'Home','ID':2506078221, 'amount': 2000.0, 'paid': 2000.0, 'interest': 5.0, 'dueDate': '2024-12-31'},
      {'type': 'Car','ID':6606078221, 'amount': 3000.0, 'paid': 3000.0, 'interest': 5.0, 'dueDate': '2024-12-31'},
      {'type': 'Personal','ID':5506078221, 'amount': 1500.0, 'paid': 1500.0, 'interest': 5.0, 'dueDate': '2024-12-31'},
      {'type': 'University','ID':3306078221, 'amount': 2500.0, 'paid': 1250.0, 'interest': 5.0, 'dueDate': '2024-12-31'},
      {'type': 'Other', 'ID':2506458221,'amount': 1000.0, 'paid': 500.0, 'interest': 5.0, 'dueDate': '2024-12-31'},
    ];

    double totalBorrowed = loans.fold(0, (sum, loan) => sum + (loan['amount'] as num));
    double totalPaid = loans.fold(0, (sum, loan) => sum + (loan['paid'] as num));
    double totalPercentage = totalPaid / totalBorrowed;
    String currentDate = DateFormat('MMM d, yyyy').format(DateTime.now());

class _LoanPageState extends State<LoanPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  Map<String, String>? _selectedLoan;
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
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

  void _showMakePaymentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Make Payment'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<Map<String, Object>>(
                hint: Text('Select Loan'.tr),
                value: _selectedLoan,
                onChanged: (Map<String, Object>? newValue) {
                  setState(() {
                    _selectedLoan = newValue?.map((key, value) => MapEntry(key, value.toString()));
                  });
                },
                items: loans.map<DropdownMenuItem<Map<String, Object>>>((Map<String, Object> loan) {
                  return DropdownMenuItem<Map<String, Object>>(
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
                    sectionTitle: 'Loan Details',
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
    // Example loan data
   
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(
        onLogout: () {
        },
        color: Colors.white,
      ),
      body: SingleChildScrollView(
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
                    Text(
                      "Welcome \n dawood baidas",
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
                const Text(
                  "Amount Borrowed",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Available", style: TextStyle(color: Colors.white70)),
                        Text("\$8,653.01",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Your Limit", style: TextStyle(color: Colors.white70)),
                        Text("\$10,000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Last Payment", style: TextStyle(color: Colors.white70)),
                        Text("May 31, 2020",
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
                  child: const Text("Make Payment"),
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
          // Loan Details Section with percentage
      Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(
    height: 200, // Set a fixed height for the container
    child: SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: loans.map((loan) {
          double loanPercentage = (loan['paid'] as double) / (loan['amount'] as double);
          IconData loanIcon;
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
            onTap: () => _navigateToLoanDetails(loan.map((key, value) => MapEntry(key, value.toString()))),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              width: 350, // Provide a fixed width to avoid layout issues
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
                          Icon(loanIcon, color: AppColors.newa),
                          const SizedBox(width: 10),
                          Text(
                            ' ${loan['type']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Active",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.newa,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount: \$${(loan['amount'] as double).toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Interest: ${loan['interest']}%",
                          style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text("Due Date: ${loan['dueDate']}",
                      //     style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Loan ID :${loan['ID']}",
                      textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16, 
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                          
                          )
                          ),
                    ],
                  ),
                                    const SizedBox(height: 5),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       Text("Due Date: ${loan['dueDate']}",
                         style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    
                    ],
                  ),
                   const SizedBox(height: 10),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      Text("Percentage: ${(loanPercentage * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(fontSize: 16, color: AppColors.newa)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity, // Make sure the LinearProgressIndicator has defined width
                    child: LinearProgressIndicator(
                      value: loanPercentage,
                      backgroundColor: Colors.grey.withOpacity(0.3),
                      color: AppColors.newa,
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  ),
),


        ],
      ),
    ),
  );
}
}
