import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:google_fonts/google_fonts.dart';

class Cashbacklist extends StatefulWidget {
  const Cashbacklist({ Key? key }) : super(key: key);

  @override
  State<Cashbacklist> createState() => _CashbacklistState();
}

// cashback/repayment

class _CashbacklistState extends State<Cashbacklist> {
  dynamic savings;
  List? cashbackloans = [];
  dynamic investmentid;
  SavingController saving = Get.put(SavingController());

  showmodel({required Map data}) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    // Get.toNamed("cashback/repayment", arguments: data);
                    // print(data["status"]);
                    if (data["status"].toString() == "0") {
                      snackbar(message: "Error", header: "Cashback is still awaiting approval", bcolor: error);
                      return;
                    }
                    if (data["status"].toString() == "1") {
                      Get.toNamed("cashback/repayment", arguments: data); 
                    }
                    
                  },
                  child: const Text(
                    'Repay',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                height: 60,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Future startCashback(String id) async {
    context.loaderOverlay.show();
    await saving.applycashback(id).then((value) {
      context.loaderOverlay.hide();
      print(value);
      // if (value?["status"] == "success") {
      //   Get.toNamed("cashback/home", arguments: value); 
      // }
      // if (value?["status"] == "error") {
      //   snackbar(message: value?["message"], header: "Error", bcolor: error); 
      // }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
    });
  }

  @override
  void initState() {
    setState(() {
      savings = Get.arguments;
      cashbackloans = savings["data"];
      investmentid = savings["savings"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            // color: black,
            child: Icon(
              FontAwesome.angle_left,
              size: 20,
              color: CustomTheme.presntstate ? white : black,
            ),
          ),
        ),
        title: Text(
          "Cashback",
          style: TextStyle(
            color: CustomTheme.presntstate ? white : primary 
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Visibility(
              visible: cashbackloans!.isNotEmpty,
              // visible: false,
              child: Card(
                shadowColor: primary.withOpacity(0.5),
                // color: primary.withOpacity(0.5),
                borderOnForeground: false,
                child: Container(
                  height: 75.h,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CustomTheme.presntstate ? primary.withOpacity(0.5) : white,
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          // investmentid["savings_name"].toString(),
                          "WITHDRAWAL HISTORY",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : primary 
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: cashbackloans!.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              height: 65,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(10),
                              
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Amount",
                                              style: TextStyle(
                                                color: CustomTheme.presntstate ? white : black,
                                                fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "2",
                                              child: Text(
                                                // '₦1,500',
                                                stringamount(cashbackloans![index]["amount"]),
                                                style: TextStyle(
                                                  color: listmoneylight,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "4",
                                              child: Text(
                                                // '₦1,500',
                                                stringamount(cashbackloans![index]["amount"]),
                                                style: TextStyle(
                                                  color: listmoneylight,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "1",
                                              child: Text(
                                                // '₦1,500',
                                                stringamount(cashbackloans![index]["amount"]),
                                                style: TextStyle(
                                                  color: error,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "3",
                                              child: Text(
                                                // '₦1,500',
                                                stringamount(cashbackloans![index]["amount"]),
                                                style: TextStyle(
                                                  color: error,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),

                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "2",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     stringamount(cashbackloans![index]["amount"]),
                                            //     style: TextStyle(
                                            //       color: listmoneylight,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "1",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     stringamount(cashbackloans![index]["amount"]),
                                            //     style: TextStyle(
                                            //       color: listmoneylight,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                          
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "3",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     stringamount(cashbackloans![index]["amount"]),
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "4",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     stringamount(cashbackloans![index]["amount"]),
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "5",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     stringamount(cashbackloans![index]["amount"]),
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // )
                                            
                                          ],
                                        ),
                          
                          
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Date",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: CustomTheme.presntstate ? white : black,
                                                fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "2",
                                              child: Text(
                                                // '₦1,500',
                                                dateformater(cashbackloans![index]["transaction_date"]),
                                                style: TextStyle(
                                                  color: listmoneylight,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "4",
                                              child: Text(
                                                // '₦1,500',
                                                dateformater(cashbackloans![index]["transaction_date"]),
                                                style: TextStyle(
                                                  color: listmoneylight,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "1",
                                              child: Text(
                                                // '₦1,500',
                                                dateformater(cashbackloans![index]["transaction_date"]),
                                                style: TextStyle(
                                                  color: error,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: cashbackloans![index]["transaction_type"] == "3",
                                              child: Text(
                                                // '₦1,500',
                                                dateformater(cashbackloans![index]["transaction_date"]),
                                                style: TextStyle(
                                                  color: error,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  fontFamily: GoogleFonts.roboto().toString(),
                                                ),
                                              ),
                                            ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "2",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     dateformater(cashbackloans![index]["transaction_date"]),
                                            //     textAlign: TextAlign.right,
                                            //     style: TextStyle(
                                            //       color: listmoneylight,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "1",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     dateformater(cashbackloans![index]["transaction_date"]),
                                            //     textAlign: TextAlign.right,
                                            //     style: TextStyle(
                                            //       color: listmoneylight,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                          
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "3",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     dateformater(cashbackloans![index]["transaction_date"]),
                                            //     textAlign: TextAlign.right,
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "4",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     dateformater(cashbackloans![index]["transaction_date"]),
                                            //     textAlign: TextAlign.right,
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // ),
                                            // Visibility(
                                            //   visible: cashbackloans![index]["transaction_type"] == "5",
                                            //   child: Text(
                                            //     // '₦1,500',
                                            //     dateformater(cashbackloans![index]["transaction_date"]),
                                            //     textAlign: TextAlign.right,
                                            //     style: TextStyle(
                                            //       color: error,
                                            //       fontWeight: FontWeight.w600,
                                            //       fontSize: 15,
                                            //       fontFamily: GoogleFonts.roboto().toString(),
                                            //     ),
                                            //   ),
                                            // )
                                            
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                        
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cashbackloans!.isEmpty,
              // visible: true,
              child: SizedBox(
                height: 75.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investmentid["savings_name"].toString(),
                      style: TextStyle(
                        color: CustomTheme.presntstate ? white : primary 
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "No Cashback Repayment.",
                                style: TextStyle(
                                  color: white
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // print(investmentid["cash_back_loans"][0]);
                if (investmentid["cash_back_loans"].length != 0) {
                  Get.toNamed("cashback/repayment", arguments: investmentid["cash_back_loans"][0]); 
                } else {
                  snackbar(message: "", header: "No cashback available", bcolor: error);
                }
                
              },
              child: Container(
                height: 44,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: registerActioncolor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  "Repay",
                  style: TextStyle(
                    color: white,
                    fontSize: 18
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}