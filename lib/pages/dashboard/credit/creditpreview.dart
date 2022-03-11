import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class Creditpreview extends StatefulWidget {
  const Creditpreview({ Key? key }) : super(key: key);

  @override
  _CreditpreviewState createState() => _CreditpreviewState();
}

class _CreditpreviewState extends State<Creditpreview> {
  

  ApplyController applycon = Get.find<ApplyController>();
  dynamic loanamount = '0';
  dynamic monthlyrepayment = '0';
  dynamic loantenor = '0';
  dynamic repaymentstartdate = '0';
  dynamic rate = 0.0;
  bool isChecked = false;
  bool otheremployer = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getloanoffer(data: {"loan_id": Get.arguments});
    });
    super.initState();
  }
  String dateformater(String datestring) {
    return DateFormat('MMM dd, yyyy').format(DateTime.parse(datestring)).toString();
  }

  String stringamount (String value) { 
    var newPrice = double.parse(value);
    String actualPrice =  newPrice.toStringAsFixed(0);
    return NumberFormat.currency(name: '₦').format(int.parse(actualPrice)).toString();
  }

  getloanoffer({required Map data}) async {
    context.loaderOverlay.show();
    applycon.loanoffer(data: data).then((value) {
      // print('ds $value');
      context.loaderOverlay.hide();
      if (value["other_employer"] == "1") {
        otheremployer = true;
        snackbar(message: value["message"], header: "Informaion", bcolor: error);
        return;
      }
      setState(() {
        loanamount = value["loan_amount"];
        repaymentstartdate = dateformater(value["repayment_start_date"]);
        loantenor = value["loan_tenor"];
        monthlyrepayment = value["monthly_repayment"];
        rate = value["rate"];
      });
      // context.loaderOverlay.hide();
    });
  }

  submitacceptloanoffer() async {
    context.loaderOverlay.show();
    applycon.submitloanoffer(data: {
      "loan_id": Get.arguments,
      "loan_amount": loanamount,
      "loan_tenor": loantenor,
      "monthly_repayment": monthlyrepayment
    }).then((vlue) {
      // print(vlue);
      if (vlue["status"] == "error") {
        snackbar(message: vlue["message"], header: "Informaion", bcolor: error);
        
      }
      if (vlue["status"] == "success") {
        // print(vlue["redirect_url"]);
        // dynamic link = vlue["redirect_url"].toString();
        // Get.offAllNamed('dashboard/home');
        dynamic data = jsonEncode({"loanamount": loanamount, "loanrepayment": repaymentstartdate}); 
        Get.toNamed('credit/final', arguments: data);
        // Get.snackbar(
        //   "Successful.", // title
        //   "Credit Application Successful. Kindly expect a feedback from our team.", // message
        //   // icon: const Icon(Icons.arrow_right),
        //   backgroundColor: Colors.green.shade500,
        //   colorText: grey6,
        //   shouldIconPulse: true,
        //   // onTap:(){},
        //   barBlur: 20,
        //   isDismissible: true,
        //   snackPosition: SnackPosition.BOTTOM,
        //   duration: const Duration(seconds: 2),
        // );
        
      }
      context.loaderOverlay.hide();
    }).catchError((onError) {
      // print('$onError second');
      context.loaderOverlay.hide();
      snackbar(message: "Error occoured.", header: "Error", bcolor: error);
      
      context.loaderOverlay.hide();
    });
  }

  acceptloanoffer() async {
    context.loaderOverlay.show();
    applycon.acceptloanoffer(data: {
      "loan_id": Get.arguments,
      "loan_amount": loanamount,
      "loan_tenor": loantenor,
      "monthly_repayment": monthlyrepayment
    }).then((value) {
      context.loaderOverlay.hide();
      // print('ds $value');
      if (value["status"] == "success") {
        submitacceptloanoffer();
      }
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Informaion", bcolor: error);
      }
    }).catchError((onError) {
      snackbar(message: "Error occoured.", header: "Error", bcolor: error);
      // print(onError);
      
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: ,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 20.h,
                  width: 100.w,
                  // child: Text("fiosa"),  
                  decoration: BoxDecoration(
                    color: primary,
                    image: const DecorationImage(image: AssetImage("assets/image/credithome.png"), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 23, right: 23, top: 28),
                    width: 100.w,
                    color: dashboardcard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "Select your loan offering",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 21
                          ),
                        ),
                        const SizedBox(height: 17),
                        const Text(
                          "Slide through the bar to select your loaning offer and your repayment Period.",
                          style: TextStyle(
                            color: Color.fromRGBO(53, 49, 48, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Column(
                            //   children: [
                            //     Text(
                            //       "Loan Amount",
                            //       style: TextStyle(
                            //         color: primary,
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 18
                            //       ),
                            //     ),
                            //     const SizedBox(height: 5),
                            //     const Text(
                            //       "₦4,000,000",
                            //       style: TextStyle(
                            //         fontSize: 36,
                            //         fontWeight: FontWeight.w600,
                            //         color: Color.fromRGBO(66, 213, 121, 1)
                            //       ),
                            //     )  
                            //   ],
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Loan Amount",
                                  style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  // "₦4,000,000",
                                  stringamount(loanamount.toString()),
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                    color:const Color.fromRGBO(66, 213, 121, 1),
                                    fontFamily: GoogleFonts.roboto().toString(),
                                  ),
                                )  
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: 100.w,
                          height: 166,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(62, 64, 149, 0.03),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children:  [
                                  const Text(
                                    "TENURE",
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // '${savingsdata["duration"].toString()} Days',
                                    "$loantenor Months",
                                    style:const TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 0.6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "INTEREST RATE",
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // savingsdata["rate"].toString(),
                                    "$rate % Per Day",
                                    style: const TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 0.6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'CREDIT REPAYMENT DATE',
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // dateformater(savingsdata["maturity_date"].toString()),
                                    '$repaymentstartdate',
                                    style: const TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 0.6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Monthly Repayment",
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    stringamount(monthlyrepayment.toString()),
                                    style: const TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 0.6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 27),





                      ],
                    ),
                    
                  ),
                )
              ],
            ),
           
            Positioned(
              top: 16.h,
              right: 7.w,
              child: Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/image/Iconmoney-bill.svg",
                  semanticsLabel: 'Acme Logo',
                  width: 40,
                  height: 20,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle
                ),
              )
            ),

            Positioned(
              top: 6.h,
              left: 3.w,
              child: GestureDetector(
                onTap: () =>  Get.back(),
                child: Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    FontAwesome.angle_left,
                    color: black,
                  ),
                 
                ),
              )
            ),
            Align( 
              alignment: Alignment.bottomCenter,
              child: GestureDetector(

                onTap: () => acceptloanoffer(),
                child: Container(
                  width: 100.w,
                  height: 58,
                  color: const Color.fromRGBO(66, 213, 121, 1),
                  alignment: Alignment.center,
                  child: Text(
                    "Apply for Loan",
                    style: TextStyle(
                      color: white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),
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