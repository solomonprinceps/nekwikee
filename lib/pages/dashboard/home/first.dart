import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'dart:math';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'dart:ui';


class First extends StatefulWidget {
  const First({ Key? key }) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  AuthController auth = Get.put(AuthController());
  final GlobalKey<RefreshIndicatorState> refreshkey = GlobalKey<RefreshIndicatorState>();
  dynamic transactions = [];
  bool inital = true;
  bool loading = false;
  bool showbankstatementsetup = false;
  bool showapplyforcredit = false;
  bool continuecreditapply = false;
  bool showsetpin = false;
  bool hasloan = false;
  dynamic paymentcard;
  Map<String, dynamic> loandata = {
    "wallet_balance" : "0",
    "wallet_history": {''
      "payback_amount": 0.00,
      "amount_withdrawn": 0.00,
      "expiry_date": "",
      "repayment_due_date": "",
      "interest_due": 0.00
    }

  };
  // dashboards["latest_goal"] != null
  bool linkcard  = false;
  bool showgoals = false;
  dynamic latestgoal = {
    "target_amount": "0",
    "amount_saved": "0"
  };
  dynamic dashboards = {
    "loans": {
      "loan_amount": "0",
    },
    "latest_goal": {
      "target_amount": "0",
      "amount_saved": "0"
    }
  };
  String publicKeyTest = 'pk_live_6ac0e9de3f66c6954ac5484df48f10d98e9adc5f'; //pass in the public test key obtained from paystack dashboard here
  final plugin = PaystackPlugin();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      plugin.initialize(publicKey: publicKeyTest);
      if (auth.inital.value) {
        refreshkey.currentState?.show(); 
      } 
      if (!auth.inital.value) {
        loadashboard();
      }
    });
    super.initState();
  }

  Future updatebackcard(String data) async {
    context.loaderOverlay.show();
    await auth.calinkcard(data).then((value) {
      context.loaderOverlay.hide();
      _showMessage('Payment was successful!!!', success);
      // refreshkey.currentState?.show(); 
      Get.offAllNamed('home', arguments: 0);
      // _showMessage('Payment was successful!!!', success);
      print(value);
    }).catchError((err) {
      print(err);
    });
  }


  addsaving(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext,Animation animation, Animation secondaryAnimation) {
        return Scaffold(
          backgroundColor: white.withOpacity(0),
          appBar: AppBar(
            leading: InkWell(
              onTap: () => Get.back(),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  FontAwesome.close,
                  color: white,
                  size: 20,
                ),
              ),
            ),
            elevation: 0,
          ),
          body: SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: 100.w,
                height: 100.h,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: white.withOpacity(0),
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                    left: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                    right: BorderSide(
                      style: BorderStyle.solid,
                      color: HexColor("#707070"),
                      width: 1
                    ),
                  )
                  // border: Border.all(
                    // style: BorderStyle.solid,
                    // color: HexColor("#707070"),
                    // width: 1
                  // )
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    children:  [
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed('savings/max/create');
                        },
                        child: Container(
                          width: 435,
                          height: 111,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(246, 251, 254, 1)
                                  ),
                                  child: Icon(
                                    FontAwesome5Solid.piggy_bank,
                                    color: primary,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "KwikMax",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Text(
                                        "Earn upto 18% per annum when your lock your funds for a minimum of 30 days Upfront interest",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 9,
                                          // letterSpacing: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(246, 251, 254, 0.42),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesome5Solid.arrow_right,
                                      color: white,
                                      size: 10,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
            
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed('savings/goals/create');
                        },
                        child: Container(
                          width: 435,
                          height: 111,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: savingmonth,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromRGBO(246, 251, 254, 1)
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/image/maxcircle.svg',
                                    semanticsLabel: 'Target',
                                    // color: white,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "KwikGoals",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Text(
                                        "Acheive you target, save towards a particular goal. 12% per annum",
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                          color:Color.fromRGBO(246, 251, 254, 0.42)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Icon(
                                      FontAwesome5Solid.arrow_right,
                                      color: white,
                                      size: 10,
                                    )
                                  ],
                                ),
                              )
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
        );
      }
    );
  }
  
  //a method to show the message
  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //used to generate a unique reference for payment
  String _getReference() {
    var rng = Random();
    dynamic numstring= '';
    for (var i = 0; i < 10; i++) {
      int num = rng.nextInt(100); 
      numstring = numstring + num.toString();
    }
    return  "kuser-${auth.userdata["id"]}-cardsetup-$numstring";
  }

  //async method to charge users card and return a response card_setup_link
  chargeCard() async {
    
    String refs = _getReference();
    var charge = Charge()
      ..amount = 50 * 100
      ..reference = refs
      // ..putCustomField('custom_id',
      //     '846gey6w') //to pass extra parameters to be retrieved on the response from Paystack
      ..email =  auth.userdata["email"];
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    // print(response);
    // check if the response is true or not

    if (response.status == true) {
      updatebackcard(refs);
      //you can send some data from the response to an API or use webhook to record the payment on a database
    } else {
      //the payment wasn't successsful or the user cancelled the payment
      _showMessage('Payment Failed!!!', error);
    }
  }

  void _launchInBrowser(String url) async {
    await launch(url);
    // if (await canLaunch(url.toString())) {
    //   await launch(
    //     url.toString(),
    //   );
    //   Get.toNamed('althome');
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  Future loadashboard() async {
    setState(() {
      loading = true;
    });
    await auth.dashbaord().then((value) {
      setState(() {
        loading = false;
      });
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
        return;
      }
      setState(() {
        dashboards = value;
      });
      
      if (dashboards["latest_goal"] != null) {
        latestgoal = dashboards["latest_goal"];
        setState(() {
          showgoals = true;
        });
      }
      if (dashboards["latest_goal"] == null) {
        setState(() {
          showgoals = false;
        });
      }
      

      auth.updateuserobj(value["user"]);
      // print('co ${dashboards["set_pin"]}');
      if (dashboards["set_pin"].toString() == "1") {
        setState(() {
          showsetpin = true;
        });  
      }

      if (value?["loans"] != null) {
          // print(value?["loans"]["transactions"]);
        auth.transactions.assignAll(value?["user"]["transactions"].reversed.toList());
        setState(() {
          transactions = value?["user"]["transactions"].reversed.toList();
        });
      }
      if (value["loans"] != null) {
        
        setState(() {
          // hasloan = true;
          loandata = value["loans"];
          paymentcard = value["loans"]["wallet_history"];
        });
         if (value["loans"]["status"] == "-1") {
          setState(() {
            hasloan = false;
          });
        }
      }

      if (dashboards["card_setup"].toString() == "-3" || dashboards["card_setup"].toString() == "0") {
        dashboards["card_setup"].toString() == "-3";
        auth.linkcard.value = true;
        // setState(() {
        //   linkcard = true;
        // });
      }
      if (dashboards["bank_statement_setup"].toString() == "0") {
        auth.showbankstatementsetup.value = true;
        // setState(() {
        //   showbankstatementsetup = true;
        // });
      }
      if (dashboards["card_setup"].toString() == "-2") {
        auth.continuecreditapply.value = true;
        // setState(() {
        //   continuecreditapply = true;
        // });  
      }

      if (dashboards["card_setup"].toString() == "-3" || dashboards["card_setup"].toString() == "-1") {
        // print(dashboards["card_setup"].toString());
        auth.showapplyforcredit.value = true;
        setState(() {
          showapplyforcredit = true;
        });
      }
      if (auth.inital.value == true) {
        setState(() {
          auth.inital.value = false;
        });
      }

    }).catchError((err) {
      if (inital) {
        setState(() {
          inital = false;
        });
      }
      setState(() {
        loading = false;
      });
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
    // final bool cutomtheme = CustomTheme.presntstate;
    return SafeArea(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 6,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(6)
                      ), 
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 9,
                      height: 6,
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.60),
                        borderRadius: BorderRadius.circular(6)
                      ), 
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('credit');
                    // print(auth.userdata["firstname"]);
                    // findfirstGoal();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, right: 20, bottom: 15, left: 20),
                    // width: 50.w,
                    height: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        image: AssetImage("assets/image/homecard.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () => loadashboard(),
                      key: refreshkey,
                      color: primary,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    'assets/image/feather-right1.svg',
                                    semanticsLabel: 'Action Button',
                                    width: 20,
                                    height: 20,
                                    color: primary,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'KWIKEE CARD BALANCE',
                                style: TextStyle(
                                  color: white,
                                  fontSize: 10,
                                  letterSpacing: 1.4,
                                  fontWeight: FontWeight.w200
                                ),
                              ),
                              SizedBox(height: 1.h),
                              
                              Text(
                                stringamount(loandata["wallet_balance"].toString()),
                                style: TextStyle(
                                  fontSize: 29,
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                               
                              ),
                              const SizedBox(height: 10),
                              // Container(
                              //   height: 10,
                              //   width: 30,
                              //   color: primary,
                              // ),
                              Container(
                                width: 110,
                                height: 24,
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: registerActioncolor,
                                  borderRadius: BorderRadius.circular(3)
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Withdraw',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: white
                                  )
                                ),
                              )
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Visibility(
                  visible: auth.inital.value && loading,
                  child: SizedBox(
                    // padding: const EdgeInsets.all(10),
                    height: 180,
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.white,
                            child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Card(
                                child: Container(
                                  height: 180,
                                  // width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.white,
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Card(
                                child: Container(
                                  height: 180,
                                  // width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: !auth.inital.value,
                  child: SizedBox(
                    height: 180,
                    width: 100.w,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: ListView(
                        // clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 20),
                          Visibility(
                            visible: auth.showapplyforcredit.value,
                            child: GestureDetector(
                              onTap: () => Get.toNamed("credit/home"),
                              child: Card(
                                shadowColor: HexColor("#0000000F"),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                                  height: 180,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#0000000F"),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/image/feather-right.svg',
                                            semanticsLabel: 'Action Button',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius: BorderRadius.circular(100)
                                            ),
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/image/money-bill.svg',
                                              semanticsLabel: 'money bill',
                                              color: white,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Apply for Credit',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Get your kwikee credit card funded and withdraw at will.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: auth.continuecreditapply.value,
                            child: GestureDetector(
                              onTap: () => Get.toNamed("credit/home"),
                              child: Card(
                                shadowColor: HexColor("#0000000F"),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                                  height: 180,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#0000000F"),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/image/feather-right.svg',
                                            semanticsLabel: 'Action Button',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              borderRadius: BorderRadius.circular(100)
                                            ),
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/image/money-bill.svg',
                                              semanticsLabel: 'money bill',
                                              color: white,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Apply for Credit',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Reach your goals quicker and easier with savings and investment with Kwikee.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),    
                
                          
                          
                          Visibility(
                            visible: auth.showbankstatementsetup.value,
                            child: GestureDetector(
                              onTap: () => _launchInBrowser(dashboards["bank_statement_setup_link"]),
                              // onTap: () => okrowigdet(),
                              child: Card(
                                shadowColor: HexColor("#0000000F"),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                                  height: 180,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#0000000F"),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/image/feather-right.svg',
                                            semanticsLabel: 'Action Button',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            // padding: const EdgeInsets.all(6),
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              shape: BoxShape.circle
                                              // borderRadius: BorderRadius.circular(100)
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              FontAwesome5Solid.piggy_bank,
                                              color: white,
                                              size: 15
                                            )
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Link Bank',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Link your acccount to increase your credit score.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),   
                

                          Visibility(
                            visible: auth.linkcard.value,
                            // visible: true,
                            child: GestureDetector(
                              onTap: () => chargeCard(),
                              child: Card(
                                shadowColor: HexColor("#0000000F"),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                                  height: 180,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#0000000F"),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/image/feather-right.svg',
                                            semanticsLabel: 'Action Button',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            // padding: const EdgeInsets.all(6),
                                            width: 46,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: primary,
                                              shape: BoxShape.circle
                                              // borderRadius: BorderRadius.circular(100)
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              FontAwesome.cc_mastercard,
                                              color: white,
                                              size: 15
                                            )
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Link Card',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Link your bank card to get funds disbursed into your wallet.',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),   

                          
                          Visibility(
                            visible: showgoals,
                            child: GestureDetector(
                              onTap: () => Get.toNamed('savings/goals/goalshome', arguments: latestgoal["investmentid"]),
                              child: Card(
                                shadowColor: HexColor("#0000000F"),
                                // margin: const EdgeInsets.only(right: 5, left: 5),
                                margin: const EdgeInsets.only(right: 10),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
                                  height: 180,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: HexColor("#0000000F"),
                                        blurRadius: 3,
                                        offset: const Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: kwikeegoals,
                                              borderRadius: BorderRadius.circular(100)
                                            ),
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/image/goalsicons.svg',
                                              semanticsLabel: 'Target',
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Goals",
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.w600,
                                              color: CustomTheme.presntstate ?  darkwhite : primary,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        latestgoal["savings_name"] != null ? makecapitalize(latestgoal["savings_name"].toString()) : '',
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: CustomTheme.presntstate ? white : HexColor("#35313099"),
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        stringamount(latestgoal["target_amount"].toString()),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 23,
                                          color: CustomTheme.presntstate ?  darkwhite : primary,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: GoogleFonts.roboto().toString(),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      LinearPercentIndicator(
                                        width: 110,
                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                        alignment: MainAxisAlignment.start,
                                        animation: false,
                                        lineHeight: 10.0,
                                        animationDuration: 2500,
                                        percent: ((int.parse(latestgoal["amount_saved"].toString())/int.parse(latestgoal["target_amount"].toString()))).toDouble(),
                                        backgroundColor: CustomTheme.presntstate ? primary.withOpacity(0.3) : primary.withOpacity(0.1),
                                        barRadius: const Radius.circular(10),
                                        progressColor:CustomTheme.presntstate ? primary : HexColor("#42D579"),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        '${latestgoal["matures_in"].toString()}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: CustomTheme.presntstate ?  darkwhite : primary.withOpacity(0.27),
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          

                          Card(
                            shadowColor: HexColor("#0000000F"),
                            margin: const EdgeInsets.only( right: 20),
                            child: GestureDetector(
                              onTap: () {
                                // print('object');
                                // Get.toNamed('home/mov', arguments: 1);
                                addsaving(context);
                                // Get.to(const Homenav(id: 1));
                                // chargeCard();
                              },
                              child: Container(
                              padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                                height: 180,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                                  borderRadius: BorderRadius.circular(5.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor("#0000000F"),
                                      blurRadius: 3,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/image/feather-right.svg',
                                          semanticsLabel: 'Action Button',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 46,
                                          height: 46,
                                          decoration: BoxDecoration(
                                            color: registerActioncolor,
                                            borderRadius: BorderRadius.circular(100)
                                          ),
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            'assets/image/goalsicons.svg',
                                            semanticsLabel: 'money bill',
                                            width: 20,
                                            height: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Save with Kwik',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: CustomTheme.presntstate ?  darkwhite : primary,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Reach your goals quicker & easier with savings and investment with Kwikee.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 8.5,
                                        color: CustomTheme.presntstate ?  darkwhite : primary,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/image/arrows.svg',
                          semanticsLabel: 'money bill',
                          color: !CustomTheme.presntstate ? primary : darkactivity,
                        ),
                        const SizedBox(width: 7.6),
                        Text(
                          'ACTIVITY',
                          style: TextStyle(
                            color: !CustomTheme.presntstate ? primary : darkactivity,
                            fontWeight: FontWeight.w400,
                            fontSize: 10
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        
                        Icon(
                          FontAwesome5Regular.calendar,
                          color: !CustomTheme.presntstate ? primary : darkactivity,
                          size: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: double.infinity,
                // color: Colors.red,
                constraints: const BoxConstraints(
                  minHeight: 40
                ),
                child: 
                  Obx(() => 
                    Column(
                      children: auth.transactions.map<Widget>((item) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          margin: const EdgeInsets.only(bottom: 5),
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
                                              color: CustomTheme.presntstate ?  white : black
                                            ),
                                          ),
                                          Text(
                                            // "15 Oct, 2022.",
                                            dateformater(item["created_at"].toString()),
                                            style: TextStyle(
                                              fontSize: 8,
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
                                    color: success,
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
                  )  
                // child: Column(
                //   children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    //   margin: const EdgeInsets.only(bottom: 5),
                    //   decoration: BoxDecoration(
                    //     color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                    //     borderRadius: BorderRadius.circular(5)
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Container(
                    //         width: 27,
                    //         height: 27,
                    //         decoration: BoxDecoration(
                    //           color: primary,
                    //           borderRadius: BorderRadius.circular(100)
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: SvgPicture.asset(
                    //           'assets/image/targ.svg',
                    //           semanticsLabel: 'money bill',
                    //           // color: white,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 20),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           margin: const EdgeInsets.only(left: 5, right: 5),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "Credit Application X728829",
                    //                 style: TextStyle(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: dashname
                    //                 ),
                    //               ),
                    //               Row(
                    //                 children: [
                    //                   Text(
                    //                     "TRNX928292768303;",
                    //                     style: TextStyle(
                    //                       fontSize: 8,
                    //                       fontWeight: FontWeight.w400,
                    //                       color: listingtextlight
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "15 Oct, 2022.",
                    //                     style: TextStyle(
                    //                       fontSize: 8,
                    //                       fontWeight: FontWeight.w400,
                    //                       color: listingtextdatelight
                    //                     ),
                    //                   ),
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //         )
                    //       ),
                    //       Text(
                    //         '₦1,500',
                    //         style: TextStyle(
                    //           color: listmoneylight,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 15
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                //       margin: const EdgeInsets.only(bottom: 5),
                //       decoration: BoxDecoration(
                //         color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                //         borderRadius: BorderRadius.circular(5)
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             width: 27,
                //             height: 27,
                //             decoration: BoxDecoration(
                //               color: kwikeegoals,
                //               borderRadius: BorderRadius.circular(100)
                //             ),
                //             alignment: Alignment.center,
                //             child: SvgPicture.asset(
                //               'assets/image/targ.svg',
                //               semanticsLabel: 'money bill',
                //               // color: white,
                //             ),
                //           ),
                //           const SizedBox(width: 20),
                //           Expanded(
                //             flex: 1,
                //             child: Container(
                //               margin: const EdgeInsets.only(left: 5, right: 5),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "Credit Application X728829",
                //                     style: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w400,
                //                       color: dashname
                //                     ),
                //                   ),
                //                   Row(
                //                     children: [
                //                       Text(
                //                         "TRNX928292768303;",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextlight
                //                         ),
                //                       ),
                //                       Text(
                //                         "15 Oct, 2022.",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextdatelight
                //                         ),
                //                       ),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             )
                //           ),
                //           Text(
                //             '₦1,500',
                //             style: TextStyle(
                //               color: listmoneylight,
                //               fontWeight: FontWeight.w600,
                //               fontSize: 15
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                //       margin: const EdgeInsets.only(bottom: 5),
                //       decoration: BoxDecoration(
                //         color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                //         borderRadius: BorderRadius.circular(5)
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             width: 27,
                //             height: 27,
                //             decoration: BoxDecoration(
                //               color: error,
                //               shape: BoxShape.circle
                //             ),
                //             alignment: Alignment.center,
                //             child: Icon(
                //               FontAwesome.angle_up,
                //               size: 25.0,
                //               color: white,
                //             )
                //           ),
                //           const SizedBox(width: 20),
                //           Expanded(
                //             flex: 1,
                //             child: Container(
                //               margin: const EdgeInsets.only(left: 5, right: 5),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "Credit Application X728829",
                //                     style: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w400,
                //                       color: dashname
                //                     ),
                //                   ),
                //                   Row(
                //                     children: [
                //                       Text(
                //                         "TRNX928292768303;",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextlight
                //                         ),
                //                       ),
                //                       Text(
                //                         "15 Oct, 2022.",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextdatelight
                //                         ),
                //                       ),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             )
                //           ),
                //           Text(
                //             '₦1,500',
                //             style: TextStyle(
                //               color: error,
                //               fontWeight: FontWeight.w600,
                //               fontSize: 15
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                //       margin: const EdgeInsets.only(bottom: 5),
                //       decoration: BoxDecoration(
                //         color: CustomTheme.presntstate ?  dackmodedashboardcaard : HexColor("#f8f8f8"),
                //         borderRadius: BorderRadius.circular(5)
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(
                //             width: 27,
                //             height: 27,
                //             decoration: BoxDecoration(
                //               color: success,
                //               shape: BoxShape.circle
                //             ),
                //             alignment: Alignment.center,
                //             child: Icon(
                //               FontAwesome.angle_down,
                //               size: 25.0,
                //               color: white,
                //             )
                //           ),
                //           const SizedBox(width: 20),
                //           Expanded(
                //             flex: 1,
                //             child: Container(
                //                margin: const EdgeInsets.only(left: 5, right: 5),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Text(
                //                     "Credit Application X728829",
                //                     style: TextStyle(
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w400,
                //                       color: dashname
                //                     ),
                //                   ),
                //                   Row(
                //                     children: [
                //                       Text(
                //                         "TRNX928292768303;",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextlight
                //                         ),
                //                       ),
                //                       Text(
                //                         "15 Oct, 2022.",
                //                         style: TextStyle(
                //                           fontSize: 8,
                //                           fontWeight: FontWeight.w400,
                //                           color: listingtextdatelight
                //                         ),
                //                       ),
                //                     ],
                //                   )
                //                 ],
                //               ),
                //             )
                //           ),
                //           Text(
                //             '₦1,500',
                //             style: TextStyle(
                //               color: listmoneylight,
                //               fontWeight: FontWeight.w600,
                //               fontSize: 15
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ),
              SizedBox(height: 10.h)
            ],
          ),
        ),
      ),
    );
  }
}