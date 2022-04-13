import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:intl/intl.dart';
import 'package:kwikee1/themes/apptheme.dart';

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
  bool otheremployer = true;
  dynamic message;
  bool loading = false;

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
    setState(() {
      loading = true;
    });
    context.loaderOverlay.show();
    applycon.loanoffer(data: data).then((value) {
      setState(() {
        loading = false;
      });
      print('ds ${value?["other_employer"]} ');
      context.loaderOverlay.hide();
      if (value?["other_employer"] == 1) {
        setState(() {
          otheremployer = false;
        });
        setState(() {
          message = value["message"];
          loanamount = value["loan_amount"];
          repaymentstartdate = dateformater(value["repayment_start_date"]);
          loantenor = value["loan_tenor"];
          monthlyrepayment = value["monthly_repayment"];
          rate = value["rate"];
        });
        snackbar(message: value["message"], header: "Informaion", bcolor: error);
        return;
      }
      setState(() {
        message = value["message"];
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
      print(vlue);
      if (vlue["status"] == "error") {
        snackbar(message: vlue["message"], header: "Informaion", bcolor: error);
        
      }
      if (vlue["status"] == "success") {
        dynamic data = jsonEncode({"loanamount": loanamount, "loanrepayment": repaymentstartdate}); 
        Get.toNamed('credit/final', arguments: data);
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
    // if (otheremployer == false) {
    //   snackbar(message: "No loan offer for you.", header: "Informaion", bcolor: error);
    //   return;
    // }
    context.loaderOverlay.show();
    applycon.acceptloanoffer(data: {
      "loan_id": Get.arguments,
      "loan_amount": loanamount,
      "loan_tenor": loantenor,
      "monthly_repayment": monthlyrepayment
    }).then((value) {
      context.loaderOverlay.hide();
      submitacceptloanoffer();
      // print('ds $value');
      // if (value["status"] == "success") {
      //   submitacceptloanoffer();
      // }
      // if (value["status"] == "error") {
      //   snackbar(message: value["message"], header: "Informaion", bcolor: error);
      // }
    }).catchError((onError) {
      snackbar(message: "Error occoured.", header: "Error", bcolor: error);
      // print(onError);
      
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: ,
      backgroundColor: CustomTheme.presntstate ? applydark : dashboardcard,
      body: SizedBox(
        height: 100.h,
        child: Column(
          children: [   
            Topbar(),   
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 23, right: 23, top: 18),
                width: 100.w,
                child: Visibility(
                  visible: !loading,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Credit Offer",
                        style: TextStyle(
                          color: CustomTheme.presntstate ? creditwithdark : primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 30
                        ),
                      ),
                      // const SizedBox(height: 17),
                      const SizedBox(height: 10),
                      Text(
                        "Link Your bank card to access your available credit.\n\nKindly verify your official email to access your credit.",
                        style: TextStyle(
                          color: CustomTheme.presntstate ? HexColor("#CBD1D8") :const Color.fromRGBO(53, 49, 48, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 27),
                      Visibility(
                        visible: otheremployer,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Credit Limit",
                                  style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  stringamount(monthlyrepayment.toString()),
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(66, 213, 121, 1)
                                  ),
                                )  
                              ],
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Visibility(
                      //   visible: otheremployer,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Column(
                      //         children: [
                      //           Text(
                      //             "Credit Limit",
                      //             style: TextStyle(
                      //               color: primary,
                      //               fontWeight: FontWeight.w600,
                      //               fontSize: 18
                      //             ),
                      //           ),
                      //           const SizedBox(height: 5),
                      //           Text(
                      //             // "₦4,000,000",
                      //             stringamount(loanamount.toString()),
                      //             style: TextStyle(
                      //               fontSize: 36,
                      //               fontWeight: FontWeight.w600,
                      //               color:const Color.fromRGBO(66, 213, 121, 1),
                      //               fontFamily: GoogleFonts.roboto().toString(),
                      //             ),
                      //           )  
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Visibility(
                        visible: otheremployer,
                        child: const SizedBox(height: 20)
                      ),
                      Visibility(
                        visible: otheremployer,
                        child: Container(
                          width: 100.w,
                          height: 166,
                          decoration: BoxDecoration(
                            color: CustomTheme.presntstate ? HexColor("#212845") : const Color.fromRGBO(62, 64, 149, 0.03),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children:  [
                                  // Text(
                                  //   "TENOR",
                                  //   style: TextStyle(
                                  //     color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 11
                                  //   ),
                                  // ),
                                  // Text(
                                  //   // '${savingsdata["duration"].toString()} Days',
                                  //   "$loantenor Months",
                                  //   style: TextStyle(
                                  //     color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 18
                                  //   ),
                                  // ),
                                  Text(
                                    "INTEREST RATE",
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // savingsdata["rate"].toString(),
                                    "$rate % Per Day",
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  Text(
                                    'CREDIT REPAYMENT DATE',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // dateformater(savingsdata["maturity_date"].toString()),
                                    '$repaymentstartdate',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                  // const SizedBox(height: 30),
                                  // const Text(
                                  //   "Monthly Repayment",
                                  //   style: TextStyle(
                                  //     color:Color.fromRGBO(53, 49, 48, 1),
                                  //     fontWeight: FontWeight.w500,
                                  //     fontSize: 11
                                  //   ),
                                  // ),
                                  // Text(
                                  //   stringamount(monthlyrepayment.toString()),
                                  //   style: const TextStyle(
                                  //     color:Color.fromRGBO(53, 49, 48, 0.6),
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 18
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 27),
                
                      Visibility(
                        visible: !otheremployer,
                        child: Container(
                          width: 100.w,
                          height: 166,
                          decoration: BoxDecoration(
                            color: CustomTheme.presntstate ? HexColor("#212845") : const Color.fromRGBO(62, 64, 149, 0.03),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // dateformater(savingsdata["maturity_date"].toString()),
                                message.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 4,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? HexColor("#CBD1D8") : const Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                
                          
                          
                          
                          
                          
                    ],
                  ),
                ),
                
              ),
            ),
            Align( 
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     // print(otheremployer);
                  //     // if (otheremployer) {
                  //     //   acceptloanoffer();
                  //     // }
                  //     Get.offAllNamed("home");
                  //   },
                  //   // onTap: () => acceptloanoffer(),
                  //   child: Container(
                  //     width: 100.w,
                  //     height: 58,
                  //     color: primary,
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Dashboard",
                  //       style: TextStyle(
                  //         color: white,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      print(otheremployer);
                      acceptloanoffer();
                      // if (otheremployer) {
                      //   acceptloanoffer();
                      // } else {
                      //   snackbar(message: "", header: "No Credit Offer Available", bcolor: error);
                      // }
                    },
                    // onTap: () => acceptloanoffer(),
                    child: Container(
                      width: 100.w,
                      height: 58,
                      color: const Color.fromRGBO(66, 213, 121, 1),
                      alignment: Alignment.center,
                      child: Text(
                        "Apply for Credit",
                        style: TextStyle(
                          color: white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Topbar extends StatelessWidget {
  const Topbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomTheme.presntstate ? applydark : dashboardcard,
      child: Stack(
        children: [
          SizedBox(height: 25.h),
          Container(
            height: 20.h,
            width: 100.w,
            // child: Text("fiosa"),  
            decoration: BoxDecoration(
              color: primary,
              image: const DecorationImage(image: AssetImage("assets/image/credithome.png"), 
                fit: BoxFit.cover
              ),
            ),
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
            child: InkWell(
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
        ],
      ),
    );
  }
}