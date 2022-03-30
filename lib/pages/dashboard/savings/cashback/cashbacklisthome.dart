import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';

class Cashbacklist extends StatefulWidget {
  const Cashbacklist({ Key? key }) : super(key: key);

  @override
  State<Cashbacklist> createState() => _CashbacklistState();
}

// cashback/repayment

class _CashbacklistState extends State<Cashbacklist> {
  dynamic savings;
  List? cashbackloans = [];
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
                    print(data["status"]);
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
      cashbackloans = savings["cash_back_loans"];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // print(savings["amount_saved"]);
          // if (int.parse(savings["amount_saved"])  999.99) {
            startCashback(savings["investmentid"]);
          // } else {
          //   snackbar(message: "Low Balance", header: "Cashback minimum amount is N1000", bcolor: error);
          // }
        },
        child: Icon(
          Ionicons.add,
          color: white,
        ),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 100.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                savings["savings_name"].toString(),
                style: TextStyle(
                  color: CustomTheme.presntstate ? white : primary 
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: cashbackloans!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return GestureDetector(
                      onTap: () => showmodel(data: cashbackloans![index]),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                // color: dates![i]["status"].toString() == '1' ? primary : error,
                                color: primary,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Day",
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    cashbackloans![index]["max_days_between"].toString(),
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    // stringamount(amount),
                                    "Start Date",
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    dateformaterY_M_D(cashbackloans![index]["start_date"].toString()),
                                    // "ceijekd",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    // stringamount(amount),
                                    "End Date",
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    dateformaterY_M_D(cashbackloans![index]["end_date"].toString()),
                                    // "ceijekd",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                ),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}