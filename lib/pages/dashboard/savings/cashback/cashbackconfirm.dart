import 'dart:convert';

import 'package:flutter/material.dart';
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
import 'package:kwikee1/themes/apptheme.dart';
class ConfirmCashback extends StatefulWidget {
  const ConfirmCashback({ Key? key }) : super(key: key);

  @override
  _ConfirmCashbackState createState() => _ConfirmCashbackState();
}

class _ConfirmCashbackState extends State<ConfirmCashback> {
  
  SavingController saving = Get.find<SavingController>();
  ApplyController applycon = Get.find<ApplyController>();
  dynamic cashbackdata;
  bool isChecked = false;
  bool otheremployer = false;

  @override
  void initState() {
    setState(() {
      cashbackdata = Get.arguments;
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // print(Get.arguments);
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

  submit() async {
    context.loaderOverlay.show();
    final Map params = {
      "end_date": cashbackdata["end_date"],
      "investmentid": cashbackdata["savingid"],
      "amount": cashbackdata["offer_amount"]
    };
    saving.submitCashback(params).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "error", bcolor: error);
      }
      if (value["status"] == "success") {
        Get.toNamed('cashback/confirm', arguments: value);
      }
      // context.loaderOverlay.hide();
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
                    // color: dashboardcard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        Text(
                          "Accept Cashback offer",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? creditwithdark : primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 21
                          ),
                        ),
                        const SizedBox(height: 17),
                        // const Text(
                        //   "Slide through the bar to select your loaning offer and your repayment Period.",
                        //   style: TextStyle(
                        //     color: Color.fromRGBO(53, 49, 48, 1),
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w400
                        //   ),
                        // ),
                        // const SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
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
                            //         color: Color.fromRGBO(247, 92, 53, 1)
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
                                  "Cashback Amount",
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? creditwithdark : primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  stringamount(cashbackdata["offer_amount"].toString()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(247, 92, 53, 1)
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
                                  Text(
                                    "Start Date",
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    dateformater(cashbackdata["start_date"].toString()),
                                    // "213 Months",
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Maximum Interest",
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    stringamount(cashbackdata["max_interest"].toString()),
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                    'End Date',
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    // dateformater(savingsdata["maturity_date"].toString()),
                                    dateformater(cashbackdata["end_date"].toString()),
                                    // '$repaymentstartdate',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Maximum Repayment",
                                    style: TextStyle(
                                      color:Color.fromRGBO(53, 49, 48, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                    ),
                                  ),
                                  Text(
                                    stringamount(cashbackdata["max_repayment"].toString()),
                                    
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
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
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(247, 92, 53, 1),
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

                onTap: () => submit(),
                child: Container(
                  width: 100.w,
                  height: 58,
                  color: const Color.fromRGBO(247, 92, 53, 1),
                  alignment: Alignment.center,
                  child: Text(
                    "Submit Cashback",
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