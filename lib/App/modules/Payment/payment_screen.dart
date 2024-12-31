import 'dart:async';
import '../../data/api/constance.dart';
import '../../helper/extentions.dart';
import '../Home/View/home.dart';
import '../../helper/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'grid_fixed_items_height.dart';
import '../../lang/language_view_model.dart';
import '../../helper/custom_button.dart';
import '../../helper/custom_textformfield.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var BankId = '0';
  String? lang;
  var payment = 0;
  var count = 60;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController Identification = TextEditingController();
  TextEditingController verification = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<int> bankNumbers = List.generate(23, (index) => index + 1); // List of bank numbers
  List<int> filteredBankNumbers = [];
  List<String> language = ['Arabic', 'English'];
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    lang = Get.locale==Locale('ar') ? 'عربي' : 'English';
    filteredBankNumbers = bankNumbers; // Initialize with all bank numbers
  }
  // final now = DateTime.now();
  // var formattedDate;
  void startTimer() {
    _timer != null ? _timer!.cancel() : null;
    _timer = Timer(Duration(seconds: 1), () {
      if (count > 0) {
        setState(() {
          count--;
        });
        startTimer(); 
      }else{
        _timer!.cancel();
        count =60;

      }
    });
  }

  void filterBanks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredBankNumbers = bankNumbers;
      } else {
        filteredBankNumbers = bankNumbers
            .where((number) => number.toString().contains(query))
            .toList();
      }
    });
  }

  int indexValue = 0;
  bool canPop = false;
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        setState(() {
          if (payment > 0) {
            payment--;
          } else {
            payment = 0;
            canPop = true;
                        Get.offAll(loanshome());
            //  didPop = canPop;
          }
        });
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   width: Get.width,
                //   height: Get.height*.06,
                //   color: Constants.primaryColor,
                // ),
                // 10.height,
                SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width : Get.width * .35,
                        height: Get.height*.08,
                        child: PopupMenuButton(
                          onSelected: (value) {
                            setState(() {});
                            if (value == 'Arabic'.tr) {
                              Get.find<LanguageController>().saveLanguage(AppLanguage.Arabic);
                              Get.updateLocale(const Locale('ar'));
                              lang = 'عربي';
                            } else {
                              Get.find<LanguageController>().saveLanguage(AppLanguage.English);
                              Get.updateLocale(const Locale('en', 'us'));
                              lang = 'English';
                            }
                          },
                          itemBuilder: (context) {
                            return List<PopupMenuEntry<String>>.generate(
                              language.length,
                                  (index) {
                                return PopupMenuItem<String>(
                                  value: language[index].tr,
                                  child: Text('${language[index].tr}'),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.blue.shade800,),

                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_drop_down_sharp),
                                FittedBox(
                                  child: CustomText(
                                    fontsize: 14,
                                    text:
                                    '$lang  -  ${Get.locale != const Locale('ar') ? ' en ' : ' ar '}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Image.asset('assets/images/madfooatCom.png',
                                        width: Get.width * .5,
                                        height: Get.height * .15,
                                      ),
                      SizedBox(),

                    ],
                  ),
                ),
                payment == 2 || payment == 3 ?  (Get.height * .1).height :  SizedBox(),
                Container(
                  width: Get.width,
                  height: payment == 2 ||  payment == 3 ?  Get.height * .5 : Get.height * .7,
                  margin: EdgeInsets.all(Get.width * .03),
                  child: Material(
                    elevation: 10,
                    child: payment == 0
                        ? Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Payment summary',
                                  fontWeight: FontWeight.w600,
                                  fontsize: 18,
                                ),
                                10.height,
                                SizedBox(
                                  height: Get.height * .15,
                                  child: Material(
                                    elevation: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: 'madfooat-com commission'.tr,
                                                fontWeight: FontWeight.w800,
                                                fontsize: 16,
                                              ),
                                              CustomText(
                                                text: '0000',
                                                fontWeight: FontWeight.w800,
                                                fontsize: 16,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                text: 'The total amount of payment'
                                                    .tr,
                                                fontWeight: FontWeight.w800,
                                                fontsize: 16,
                                              ),
                                              CustomText(
                                                text: '0000',
                                                fontWeight: FontWeight.w800,
                                                fontsize: 16,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                10.height,
                                Expanded(
                                  child: SizedBox(
                                    height: Get.height * .2,
                                    child: Material(
                                      elevation: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: 'Payment through'.tr,
                                                fontWeight: FontWeight.w800,
                                                fontsize: 16,
                                              ),
                                              10.height,
                                              TextButton(
                                                onPressed: () {},
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.account_balance,
                                                      size: 18,
                                                      color: Colors.blue[800],
                                                    ),
                                                    10.width,
                                                    CustomText(
                                                      text: 'Bank account'.tr,
                                                      fontWeight: FontWeight.w800,
                                                      fontsize: 16,
                                                      color: Colors.blue[800],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              Center(
                                                child: SizedBox(
                                                  height: Get.height * .3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/empty-box.png',
                                                        width: Get.width * .18,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            'You do not have any bank account maintained'
                                                                .tr,
                                                        fontsize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            payment = 1;
                                                          });
                                                        },
                                                        child: CustomText(
                                                          text: 'Add'.tr,
                                                          color: Colors.blue,
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                  vertical: 3),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color:
                                                                      Colors.blue)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        :  payment == 1
                        ?  Material(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      CustomText(
                                        text: 'Choose your bank'.tr,
                                        fontWeight: FontWeight.w800,
                                        fontsize: 16,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            payment = 0;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                
                                  SizedBox(height:Get.height * 0.02),
                                    SizedBox(
                                  height: Get.height * .55,
                                   child: GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
    crossAxisCount: 3, // 4 columns for better fitting 24 items
    height: Get.height * .19,
    
  ),
  itemCount: filteredBankNumbers.length, // Update item count to 24
  itemBuilder: (BuildContext context, int index) {
    int bankNumber = filteredBankNumbers[index];
    bool isSelected = bankNumber == indexValue;
    return InkWell(
      onTap: () {
        setState(() {
          indexValue = bankNumber;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected ? 3 : 2,
            color: isSelected ? Colors.blue.shade800 : Colors.grey,
          ),
        ),
        width: Get.width * .35,
        child: Image.asset(
          'assets/bank/bank_$bankNumber.png', 
          // Dynamically load images
          width: Get.width * .5,
          height: Get.height * .2,
        ),
      ),
    );
  },
),

                                    ),
                                     
                                ],
                              ),
                            ),
                          ),
                        ) :   payment == 2
                        ?  Material(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      CustomText(
                                        text: 'Account Information'.tr,
                                        fontWeight: FontWeight.w800,
                                        fontsize: 16,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            payment = 1;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  //Bank ID
                                  CustomText(
                                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                    text: 'Bank ID'.tr,
                                  ),
                                  PopupMenuButton(
                                    onSelected: (value) {
                                      setState(() {});
                                      BankId = value;
                                    },
                                    itemBuilder: (context) {
                                      return List<PopupMenuEntry<String>>.generate(
                                        5,
                                            (index) {
                                          return PopupMenuItem<String>(
                                            value: index.toString(),
                                            child: Text('${index}'),
                                          );
                                        },
                                      );
                                    },
                                    child:  Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      height: Get.height*.08,
                                      width: Get.width,
                                      // color: Colors.white.withOpacity(.98),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.grey),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          FittedBox(
                                            child: CustomText(
                                              fontsize: 14,
                                              text:
                                              '$BankId',
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down_sharp),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                    text: 'Identification Number'.tr,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: CustomTextFormField.textFieldStyle(
                                        controller: Identification,
                                        hintText: 'Identification Number'.tr,
                                        width: Get.width,
                                        height: Get.height * .08,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter The'.tr +
                                                ' ' +
                                                'Identification Number'.tr;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          value != null
                                              ? _formKey.currentState!.validate()
                                              : null;
                                        }
                                      // keyboardType: TextInputType.emailAddress,
                                      // border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ) : payment == 3 ? Material(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  CustomText(
                                    text: 'Confirm the payment process'.tr,
                                    fontWeight: FontWeight.w800,
                                    fontsize: 16,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        payment = 2;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              30.height,
                              FittedBox(child: CustomText(text: 'Please enter the verification code sent to you through the bank'.tr,fontWeight: FontWeight.w400,fontsize: 14,)),
                              30.height,
                              CustomText(text: 'verification code',),
                              10.height,
                              CustomTextFormField.textFieldStyle(
                                  controller: verification,
                                  hintText: 'verification code'.tr,
                                  width: Get.width,
                                  height: Get.height * .08,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter The'.tr +
                                          ' ' +
                                          'verification'.tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    value != null
                                        ? _formKey.currentState!.validate()
                                        : null;
                                  }
                                // keyboardType: TextInputType.emailAddress,
                                // border: InputBorder.none,
                              ),
                              CustomText(
                                padding: EdgeInsets.all(10),
                                text: '${count}'+' : 00 : 00',fontWeight: FontWeight.w600,),
                              50.height,
                              Row(children: [
                                Checkbox(value: checkBox, onChanged: (value){
                                  value != value;
                                  checkBox = value!;
                                  setState(() {
                                  });
                                }),
                                TextButton(
                                  onLongPress: () {

                                  },
                                  onPressed:  () {

                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'I agree to the bank\'s'.tr + "  ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: 'terms and conditions'.tr,
                                          style: TextStyle(
                                            color: Colors.blue, // اللون الأصلي
                                            decoration: TextDecoration.underline,
                                            decorationColor: Colors.blue, // لون التأثير (التحديد أو التضليل)
                                            decorationStyle: TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],),
                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox(),
                  ),
                ),
                30.height,
                CustomButton.buttonStyle(
                  text: payment == 0 ? "Pay now".tr : payment ==1 ?  "Choose".tr : payment == 2 ? "Next".tr : payment == 3 ? "verification".tr: "",
                  width: Get.width * .3,
                  height: Get.height * .06,
                  colorButton:  payment != 1
                      ? Colors.grey
                      : Constants.primaryColor,
                  onPressed: (payment == 3 && checkBox == false) ?  null :  () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                      payment == 0 ? payment = 0 : payment == 1 ? payment = 2 : payment == 2 ? payment = 3 : payment == 3 ?  payment= 4:  payment == 0;
                      if(payment == 4 ){
                        Get.offAll(PaymentScreen());
                      }else if(payment == 3){
                        count =60;
                        startTimer();

                      }
                      }

                    });
                  },
                ),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Cancel the timer in the dispose method
    _timer?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
