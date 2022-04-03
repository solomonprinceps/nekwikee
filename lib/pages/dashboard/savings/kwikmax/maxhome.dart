import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:google_fonts/google_fonts.dart';


class Maxhome extends StatefulWidget {
  const Maxhome({ Key? key }) : super(key: key);

  @override
  _MaxhomeState createState() => _MaxhomeState();
}

class _MaxhomeState extends State<Maxhome> {
  bool showamount = true;
  dynamic autosave;
  changeamoun(bool presentstate){
    setState(() {
      showamount = !presentstate;
    });
  }
  SavingController saving = Get.put(SavingController());
  AuthController auth = Get.put(AuthController());
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  dynamic savings =  {
    "target_amount": "0",
    "deposit_amount": "0",
    "savings_name": "",
    "withdrawn": "0",
    "amount_saved": "0",
    "month_spent": " ",
    "matures_in": "",
  };  

  String? investmentid;
  dynamic transactions = [];
  bool loading = false;
  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  listransaction() async {
    //investmentid.toString()
    context.loaderOverlay.show();
    final Map data = {
      "product_type": '5',
      "loanid": savings["cashbacks"]
    };
    await auth.listransaction(data: data).then((value) {
      print(value);
      context.loaderOverlay.hide();
      if (value?["status"] == "error") {
        snackbar(message: "Error", header: value["message"], bcolor: error);
      }
      if(value?["status"] == "success") {
        final Map data = {
          "data": value["transactions"]["data"],
          "savings": savings
        };
        Get.toNamed("cashback/list", arguments: data);
        // print(value["transactions"]["data"]);
      }
    });
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
      // print(value["savings"]);
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
      
      setState(() {
        loading = false;
      });
      return;
    });
  }

  Future changeAutosave(String id) async {
    context.loaderOverlay.show();
    await saving.changeAutosave(data: id).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        setState(() {
          autosave = value?["saving"]["auto_save"];
        });
        snackbar(message: value?["message"], header: "Success", bcolor: success);
        return;
      }
      if (value?["status"] == "error") {
        snackbar(message: value?["message"], header: "Error", bcolor: error);
        return;
      }
    });
  }
  

  Future startCashback(String id) async {
    context.loaderOverlay.show();
    await saving.applycashback(id).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value?["status"] == "success") {
        Get.toNamed("cashback/home", arguments: value); 
      }
      if (value?["status"] == "error") {
        snackbar(message: value?["message"], header: "Error", bcolor: error); 
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
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
    return WillPopScope(
      onWillPop:() => _willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40,
              height: 40,
              color: primary,
              child: Icon(
                FontAwesome.angle_left,
                size: 20,
                color: white,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  
                  InkWell(
                    onTap: () {
                      Get.toNamed("notification");
                    },
                    child: Icon(
                      FontAwesome.bell,
                      color: registerActioncolor,
                      size: 20.0,
                      textDirection: TextDirection.ltr,
                      semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: iconcolorselected,
          elevation: 0,
        ),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: RefreshIndicator(
            onRefresh: () => getsinglesavings(investmentid.toString()),
            key: refreshkey,
            color: primary,
            backgroundColor: white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 35.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 35),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(246, 251, 254, 1)
                                    ),
                                    // child: Icon(
                                    //   FontAwesome5Solid.piggy_bank, maxhomepig.svg
                                    //   color: iconcolorselected,
                                    // )
                                    padding: EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      'assets/image/maxhomepig.svg',
                                      semanticsLabel: 'Transactions',
                                      // color: goalstext,
                                      width: 8,
                                      height: 8,
                                      // color: white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "KwikMax",
                                    style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: !loading,
                                child: GestureDetector(
                                  onTap: () => changeAutosave(investmentid.toString()),
                                  child: Container(
                                    width: 135,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: registerActioncolor,
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
                                    ),
                                    child: Text(
                                      autosave == 1 ? "Autosave is On" : "Autosave is Off",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Shimmer.fromColors(
                        //   baseColor: Colors.grey[300]!,
                        //   highlightColor: Colors.grey[100]!,
                        //   child: Container(
                        //     margin: const EdgeInsets.only(left: 20, top: 20),
                        //     width: 170,
                        //     height: 50,
                        //     color: error,
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            children: [
                              Text(
                                savings["savings_name"].toString(),
                                style: TextStyle(
                                  color: goalstext,
                                  fontSize: 17
                                ),
                              ),
                              const SizedBox(width: 30),
                              Visibility(
                                visible: !loading,
                                child: GestureDetector(
                                  onTap: () => changeamoun(showamount),
                                  child: Icon(
                                    showamount ? FontAwesome.eye_slash : FontAwesome.eye,
                                    size: 21,
                                    color: white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left:20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                showamount ? stringamount(savings["amount_saved"].toString()) : "*******",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 34,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20, right: 20),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                savings["matures_in"].toString(),
                                style: TextStyle(
                                  color: goalstext.withOpacity(0.27),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                savings["month_spent"].toString(),
                                style: TextStyle(
                                  color: goalstext,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Get cashback of upto 75% of your Kwikmax fund. 24% per annum",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 1)
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40, bottom: 5),
                    padding: const EdgeInsets.only(top:15, bottom: 15),
                    width: 100.w,
                    height: 100,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Visibility(
                              visible: loading,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !loading,
                              child: GestureDetector(
                                onTap: () => startCashback(investmentid.toString()),
                                // onTap: () {
                                 
                                //   Get.toNamed("cashback/list", arguments: savings);
                                // },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: cashbackbackground,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/cashback.svg',
                                    semanticsLabel: 'Transactions',
                                    color: goalstext,
                                    width: 10,
                                    height: 10,
                                    // color: white,
                                  ),
                                  // child: Icon(
                                  //   FontAwesome.plus_square,
                                  //   color: goalstext,
                                  // ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'CashBack',
                              style: TextStyle(
                                color: CustomTheme.presntstate ? white : iconcolorselected,
                                fontSize: 9,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 15),
                        // Column(
                        //   children: [
                        //     Visibility(
                        //       visible: loading,
                        //       child: Shimmer.fromColors(
                        //         baseColor: Colors.grey[300]!,
                        //         highlightColor: Colors.grey[100]!,
                        //         child: Container(
                        //           width: 45,
                        //           height: 45,
                        //           decoration: BoxDecoration(
                        //             color: Colors.grey[300],
                        //             borderRadius: BorderRadius.circular(5)
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                            
                        //     Visibility(
                        //       visible: !loading,
                        //       child: GestureDetector(
                        //         onTap: () => Get.toNamed("savings/lite/maxliteaddfund.dart"),
                        //         child: Container(
                        //           width: 42,
                        //           height: 42,
                        //           decoration: BoxDecoration(
                        //             color: iconcolorselected,
                        //             borderRadius: BorderRadius.circular(5)
                        //           ),
                        //           child: Icon(
                        //             FontAwesome.plus_square,
                        //             color: goalstext,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(height: 4),
                        //     Text(
                        //       'Add Funds',
                        //       style: TextStyle(
                        //         color: iconcolorselected,
                        //         fontSize: 9,
                        //         fontWeight: FontWeight.w600
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Column(
                          children: [
                            Visibility(
                              visible: loading,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !loading,
                              child: GestureDetector(
                                onTap: () { 
                                  if (savings["can_withdraw"] == 1) {
                                    moveKwimax();
                                    return;
                                  }
                                  // Get.toNamed("savings/max/withdrawal"); can_withdraw
                                  snackbar(message: "Savings is not withdrawable.", header: "Error", bcolor: error);
                                  return;
                                },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: savings["can_withdraw"] != 1  ? iconcolorselected.withOpacity(0.4) : iconcolorselected,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/loandocument.svg',
                                    semanticsLabel: 'Loan document',
                                    color: CustomTheme.presntstate ? HexColor("#827F7F") : HexColor("#827F7F")
                                      // color: white,
                                  ),
                                  // child: Icon(
                                  //   // FontAwesome.money,
                                  //   savings["can_withdraw"] != 1  ? FontAwesome.lock  : FontAwesome.money,
                                  //   color: goalstext,
                                  // ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Withdraw',
                              style: TextStyle(
                                color: CustomTheme.presntstate ? white : iconcolorselected,
                                fontSize: 9,
                                fontWeight: FontWeight.w600
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 15),
                        Column(
                          children: [
                            Visibility(
                              visible: loading,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !loading,
                              child: GestureDetector(
                                // onTap: () => Get.toNamed("cashback/home"),
                                onTap: () => listransaction(),
                                // onTap: () {
                                 
                                //   Get.toNamed("cashback/list", arguments: savings);
                                // },
                                child: Container(
                                  width: 42,
                                  height: 42,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: cashbackbackground,
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/cashback.svg',
                                    semanticsLabel: 'Transactions',
                                    color: goalstext,
                                    width: 10,
                                    height: 10,
                                    // color: white,
                                  ),
                                  // child: Icon(
                                  //   FontAwesome.plus_square,
                                  //   color: goalstext,
                                  // ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Column(
                              children: [
                                Visibility(
                                  visible: !loading,
                                  child: Text(
                                    'Cashback',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : iconcolorselected,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                Text(
                                  'Repayment',
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? white : iconcolorselected,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Visibility(
                        //       visible: loading,
                        //       child: Shimmer.fromColors(
                        //         baseColor: Colors.grey[300]!,
                        //         highlightColor: Colors.grey[100]!,
                        //         child: Container(
                        //           width: 45,
                        //           height: 45,
                        //           decoration: BoxDecoration(
                        //             color: Colors.grey[300],
                        //             borderRadius: BorderRadius.circular(5)
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Visibility(
                        //       visible: !loading,
                        //       child: Container(
                        //         width: 42,
                        //         height: 42,
                        //         decoration: BoxDecoration(
                        //           color: iconcolorselected,
                        //           borderRadius: BorderRadius.circular(5)
                        //         ),
                        //         child: Icon(
                        //           FontAwesome.gear,
                        //           color: goalstext,
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(height: 4),
                        //     Text(
                        //       'Settings',
                        //       style: TextStyle(
                        //         color: iconcolorselected,
                        //         fontSize: 9,
                        //         fontWeight: FontWeight.w600
                        //       ),
                        //     )
                        //   ],
                        // )
                      ],
                    )
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/image/arrows.svg',
                              semanticsLabel: 'money bill',
                              color: CustomTheme.presntstate ? white : primary,
                              // color: white,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'ACTIVITY',
                              style: TextStyle(
                                color: CustomTheme.presntstate ? white : primary,
                                fontWeight: FontWeight.w400,
                                fontSize: 10
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [    
                            Icon(
                              FontAwesome.calendar_check_o,
                              color: CustomTheme.presntstate ? white : primary,
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                            margin: const EdgeInsets.only(bottom: 5),
                            height: 50,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                                Visibility(
                                  visible: item["transaction_type"] == "4",
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      color: error,
                                      shape: BoxShape.circle
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Ionicons.close_outline,
                                      size: 15.0,
                                      color: white,
                                    )
                                  ),
                                ),
                                Visibility(
                                  visible: item["transaction_type"] == "3",
                                  child: Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      color: error,
                                      shape: BoxShape.circle
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Ionicons.close_outline,
                                      size: 15.0,
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
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: CustomTheme.presntstate ? goalstext : dashname
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["giroreference"].toString(),
                                              style: TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w400,
                                                color: CustomTheme.presntstate ?  white : black
                                              ),
                                            ),
                                            Text(
                                              // "15 Oct, 2022.",
                                              dateformater(item["created_at"].toString()),
                                              style: TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w400,
                                                color: CustomTheme.presntstate ?  white : black
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
                                      color: listmoneylight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: item["transaction_type"] == "1",
                                  child: Text(
                                    // '₦1,500',
                                    stringamount(item["amount"]),
                                    style: TextStyle(
                                      color: listmoneylight,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible: item["transaction_type"] == "3",
                                  child: Text(
                                    // '₦1,500',
                                    stringamount(item["amount"]),
                                    style: TextStyle(
                                      color: error,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: item["transaction_type"] == "4",
                                  child: Text(
                                    // '₦1,500',
                                    stringamount(item["amount"]),
                                    style: TextStyle(
                                      color: error,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      fontFamily: GoogleFonts.roboto().toString(),
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