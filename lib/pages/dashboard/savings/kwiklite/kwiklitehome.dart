import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:clipboard/clipboard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class Litehome extends StatefulWidget {
  const Litehome({ Key? key }) : super(key: key);

  @override
  _LitehomeState createState() => _LitehomeState();
}

class _LitehomeState extends State<Litehome> {
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  SavingController saving = Get.put(SavingController());
  bool showamount = true;
  changeamoun(bool presentstate){
    setState(() {
      showamount = !presentstate;
    });
  }
  dynamic savings =  {
    "target_amount": "0",
    "deposit_amount": "0",
    "savings_name": "",
    "withdrawn": "0",
    "amount_saved": "0",
    "month_spent": " ",
    "matures_in": "",
    "payment_account_number": ""
  };  

  String? investmentid;
  dynamic transactions = [];
  bool loading = false;
  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  Future moveKwimax() async {
    context.loaderOverlay.show();
    await saving.kwikmaxsinglesave(savings["investmentid"]).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "error") {
        snackbar(message: value?["message"], header: "Error", bcolor: error);
        return;
      }
      if (value?["status"] == "success") {
        refreshkey.currentState?.show(); 
      }
    }).catchError((onError) {
      context.loaderOverlay.hide();
      // print(onError);
    });
  }

  Future getsinglesavings(String id) async {
    setState(() {
      loading = true;
    });
    await saving.singlesave(id).then((value) {
      print(value);
      setState(() {
        savings = value?["savings"];
      });
      setState(() {
        loading = false;
      });
      setState(() {
        transactions = value?["savings"]["transactions"].reversed.toList();
      });
    }).catchError((onError) {
      snackbar(message: "Error Occoured", header: "error", bcolor: error);
      // print(onError);
      setState(() {
        loading = false;
      });
      return;
    });
  }

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // plugin.initialize(publicKey: publicKeyTest);
      setState(() {
        investmentid = Get.arguments;
      });
      refreshkey.currentState?.show(); 
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: RefreshIndicator(
          onRefresh: () => getsinglesavings(investmentid.toString()),
          key: refreshkey,
          color: savingmonth,
          backgroundColor: white,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 389,
                    padding: const EdgeInsets.only(right: 20, bottom: 20, top: 10),
                    decoration: BoxDecoration(
                      color: HexColor("#3E4095B3").withOpacity(0.42),
                      image: const DecorationImage(
                        image: AssetImage("assets/image/creditcard.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 45,
                                height: 45,
                                alignment: Alignment.center,
                                // color: black,
                                child: Icon(
                                  FontAwesome.angle_left,
                                  size: 20,
                                  color: white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesome.bell,
                                  color: white,
                                  size: 18.0,
                                  textDirection: TextDirection.ltr,
                                  semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Container(
                        //       margin: const EdgeInsets.only(right: 10),
                        //       width: 54,
                        //       height: 54,
                        //       alignment: Alignment.center,
                        //       decoration: BoxDecoration(
                        //         color: kwikeegoals,
                        //         shape: BoxShape.circle
                        //       ),
                        //       child: Icon(
                        //         FontAwesome.plus,
                        //         size: 31,
                        //         color: white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Text(
                                "KWIK LITE",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(width: 10),
                               Icon(
                                FontAwesome5Solid.info_circle,
                                color: white,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                // "₦300,782",
                                showamount ? stringamount(savings["amount_saved"].toString()) : "*****",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap:  ()=> changeamoun(showamount),
                                child: Icon(
                                  showamount ? FontAwesome.eye_slash : FontAwesome.eye,
                                  color: white
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed("savings/lite/withdraw", arguments: investmentid),
                          child: Container(
                            width: 110,
                            height: 25,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20, top: 15),
                            child: Text(
                              "WITHDRAW",
                              style: TextStyle(
                                color: white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: HexColor("#42D579"),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor("#0000000F"),
                                  blurRadius: 3,
                                  offset:
                                      const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "FUND KWIKLITE",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "You have access to your funds anytime. Attracts interest of 10% per annum. No minimum amount",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Visibility(
                          visible: !loading,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text(
                                  "WEMA BANK",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: white,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () => FlutterClipboard.copy(savings["payment_account_number"].toString()).then(( value ) => snackbar(message: "Account number copied ${savings["payment_account_number"].toString().toString()}", header: "Copied", bcolor: success)),
                                  child: Container(
                                    height: 34,
                                    width: 45.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: error,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.copy,
                                              color: white,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              savings["payment_account_number"].toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: white
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/image/arrows.svg',
                          semanticsLabel: 'money bill',
                          // color: white,
                        ),
                        Row(
                          children: [    
                            Icon(
                              FontAwesome.calendar_check_o,
                              color: primary,
                              size: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                      visible: loading,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300]!,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !loading,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                          // color: Colors.red,
                        constraints: BoxConstraints(
                          minHeight: 20.h
                        ),
                        child: Column(
                          children: transactions.map<Widget>((item) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Container(
                                  //   width: 27,
                                  //   height: 27,
                                  //   decoration: BoxDecoration(
                                  //     color: primary,
                                  //     borderRadius: BorderRadius.circular(100)
                                  //   ),
                                  //   alignment: Alignment.center,
                                  //   child: SvgPicture.asset(
                                  //     'assets/image/targ.svg',
                                  //     semanticsLabel: 'money bill',
                                  //     // color: white,
                                  //   ),
                                  // ),
                                  Visibility(
                                    visible: item["transaction_type"] == "1",
                                    child: Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: error,
                                        shape: BoxShape.circle
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        FontAwesome.angle_up,
                                        size: 25.0,
                                        color: white,
                                      )
                                    ),
                                  ),
                                  Visibility(
                                    visible: item["transaction_type"] == "2",
                                    child: Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: success,
                                        shape: BoxShape.circle
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        FontAwesome.angle_down,
                                        size: 25.0,
                                        color: white,
                                      )
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 5, right: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // "Credit Application X728829",
                                            item["narration"].toString(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: dashname
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item["giroreference"].toString(),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,
                                                  color: listingtextlight
                                                ),
                                              ),
                                              Text(
                                                // "15 Oct, 2022.",
                                                dateformater(item["created_at"].toString()),
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400,
                                                  color: listingtextdatelight
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ),
                                  Visibility(
                                    visible: item["transaction_type"] == "2",
                                    child: Text(
                                      // '₦1,500',
                                      stringamount(item["amount"]),
                                      style: TextStyle(
                                        color: success,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: item["transaction_type"] == "1",
                                    child: Text(
                                      // '₦1,500',
                                      stringamount(item["amount"]),
                                      style: TextStyle(
                                        color: error,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15
                                      ),
                                    ),
                                  )
                                  // Text(
                                  //   // '₦1,500',
                                  //   stringamount(item["amount"]),
                                  //   style: TextStyle(
                                  //     color: listmoneylight,
                                  //     fontWeight: FontWeight.w600,
                                  //     fontSize: 15
                                  //   ),
                                  // )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h)
                      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}