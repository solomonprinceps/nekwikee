import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  AuthController auth = Get.find<AuthController>();
  Map<String, dynamic> loandata = {
    "wallet_balance": "0",
    "loan_amount": "0",
    "wallet_history": {
      "payback_amount": 0.00,
      "amount_withdrawn": 0.00,
      "expiry_date": "",
      "repayment_due_date": "",
      "interest_due": 0.00
    },
    "status": "-1"
  };
  bool loading = false;
  Map<String, dynamic> paymentcard = {
    "payback_amount": 0.00,
    "amount_withdrawn": 0.00,
    "expiry_date": "",
    "repayment_due_date": "",
    "interest_due": 0.00
  };
  String amount = '';
  bool showbankstatementsetup = false;
  bool showapplyforcredit = false;
  bool showsetpin = false;
  bool hasloan = false;
  dynamic dashboards;
  bool linkcard = false;
  bool showithdrawal = false;

  Future loadashboard() async {
    setState(() {
      loading = true;
    });
    await auth.dashbaord().then((value) {
      // print('edxm${value["loans"]}');
      setState(() {
        loading = false;
      });
      if (value["status"] == "error") {
        return;
      }
      setState(() {
        dashboards = value;
      });
      // print('ststus ${dashboards["loans"]["card_setup"].toString()}');
      if (value["set_pin"].toString() == "1") {
        setState(() {
          showsetpin = true;
        });
      }

      if (value["loans"] != null) {
        setState(() {
          // hasloan = true;
          loandata = value["loans"];
          paymentcard = value["loans"]["wallet_history"];
        });
        // print('lon dead ${loandata["wallet_history"]["amount_withdrawn"].toString()}');
        if (value["loans"]["status"] == "-1") {
          setState(() {
            hasloan = false;
          });
        }
        if (value["loans"]["status"] == "1") {
          setState(() {
            showithdrawal = true;
          });
        }
      }
      if (dashboards["loans"]["card_setup"].toString() == "-3" ||
          dashboards["loans"]["card_setup"].toString() == "0") {
        // print('sdojm');
        setState(() {
          linkcard = true;
        });
      }
      if (dashboards["bank_statement_setup"].toString() == "0") {
        setState(() {
          showbankstatementsetup = true;
        });
      }
      if (dashboards["card_setup"].toString() == "-3" ||
          dashboards["card_setup"].toString() == "-1") {
        setState(() {
          showapplyforcredit = true;
        });
      }
      // print("linkcard $linkcard");
    }).catchError((err) {
      setState(() {
        loading = false;
      });
      // print(err);
    });
  }

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Color loanscolor(String? ids) {
    // return int.parse(ids);
    if (ids.toString() == "0") {
      return primary;
    }
    if (ids.toString() == "1") {
      return success;
    }
    if (ids.toString() == "2") {
      return error;
    } 
    return primary;
  }

  String loanstatus(String? ids) {
  // return int.parse(ids);
    if (ids.toString() == "0") {
      return "Awaiting Approval";
    }
    if (ids.toString() == "1") {
      return "Active";
    }
    if (ids.toString() == "2") {
      return "Defaulting";
    } 
    return "";
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // plugin.initialize(publicKey: publicKeyTest);
      refreshkey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(
              FontAwesome.angle_left,
              color: black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: const [
                Icon(
                  FontAwesome.bell,
                  color: Color.fromRGBO(66, 213, 121, 1),
                  size: 20.0,
                  textDirection: TextDirection.ltr,
                  semanticLabel:
                      'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: RefreshIndicator(
          key: refreshkey,
          onRefresh: () => loadashboard(),
          color: primary,
          child: ListView(
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 6,
                    decoration: BoxDecoration(
                      color: primary, borderRadius: BorderRadius.circular(6)
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 9,
                    height: 6,
                    decoration: BoxDecoration(
                        color: primary.withOpacity(0.60),
                        borderRadius: BorderRadius.circular(6)),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, bottom: 15, left: 20),
                width: double.infinity,
                height: 195,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                    image: AssetImage("assets/image/creditcard.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        cardFormater(
                            auth.userdata["card_reference"].toString()),
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            // height: 24,
                            letterSpacing: 2.52,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(height: 3.h),
                      Obx(() => Text(
                          "${auth.userdata["firstname"]} ${auth.userdata["lastname"]}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          ),
                        )),
                      const SizedBox(height: 10),
                    ]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/image/money-bill.svg',
                        semanticsLabel: 'money bill',
                        color: !CustomTheme.presntstate
                            ? primary
                            : const Color.fromRGBO(130, 134, 157, 1),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'ACTIVITY',
                        style: TextStyle(
                          color: !CustomTheme.presntstate
                              ? primary
                              : const Color.fromRGBO(130, 134, 157, 1),
                          fontSize: 10,
                          letterSpacing: 0.76,
                          fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Text(
                  //     loanstatus(loandata["status"].toString()),
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 10,
                  //       color: !CustomTheme.presntstate
                  //         ? primary
                  //         : const Color.fromRGBO(130, 134, 157, 1),
                  //     ),
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: loanscolor(loandata["status"].toString()),
                  //     borderRadius: BorderRadius.circular(10)
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: !CustomTheme.presntstate
                      ? HexColor("#EFEFEF").withOpacity(0.46)
                      : const Color.fromRGBO(33, 40, 69, 1).withOpacity(0.46),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                height: 160,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TOTAL CREDIT RECIEVED",
                                style: TextStyle(
                                    // color: creditcolorlight,rgba(53, 49, 48, 0.6)
                                    color: !CustomTheme.presntstate
                                        ? const Color.fromRGBO(53, 49, 48, 0.6)
                                        : const Color.fromRGBO(53, 49, 48, 0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                stringamount(loandata["loan_amount"]),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: success,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PAYBACK AMOUNT",
                                style: TextStyle(
                                    // color: creditcolorlight,rgba(53, 49, 48, 0.6)
                                    color: !CustomTheme.presntstate
                                        ? const Color.fromRGBO(53, 49, 48, 0.6)
                                        : const Color.fromRGBO(53, 49, 48, 0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                stringamount(paymentcard["payback_amount"].toString()),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: primary.withOpacity(0.6),
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "AMOUNT WITHDRAWN",
                                style: TextStyle(
                                    // color: creditcolorlight,rgba(53, 49, 48, 0.6)
                                    color: !CustomTheme.presntstate
                                        ? const Color.fromRGBO(53, 49, 48, 0.6)
                                        : const Color.fromRGBO(53, 49, 48, 0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                stringamount(loandata["wallet_history"]["amount_withdrawn"].toString()),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                  color: primary,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: HexColor("#0000000F"),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#0000000F"),
                        blurRadius: 3,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Fund With Kwiklite',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: white),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/image/feather-right1.svg',
                              semanticsLabel: 'Action Button',
                              width: 20,
                              height: 20,
                              color: white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () =>  Get.toNamed("credit/withdraw"),
                child: Card(
                  color: HexColor("#0000000F"),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(66, 213, 121, 1),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#0000000F"),
                          blurRadius: 3,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Withdraw',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: white),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                'assets/image/feather-right1.svg',
                                semanticsLabel: 'Action Button',
                                width: 20,
                                height: 20,
                                color: white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
