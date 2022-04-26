import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/withdrawalcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:kwikee1/controllers/authcontroller.dart';




class Goalswithdraw extends StatefulWidget {
  const Goalswithdraw({ Key? key }) : super(key: key);

  @override
  _GoalswithdrawState createState() => _GoalswithdrawState();
}

class _GoalswithdrawState extends State<Goalswithdraw> {
  SavingController saving = Get.put(SavingController());
  WithdrawController withdraw = Get.put(WithdrawController());
  AuthController auth = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  List banklist = [];
  List allbanks = [];
  TextEditingController bankeditor = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController tranpin = TextEditingController();
  dynamic savings;
  List<String> otp = [];
  Map<String?, String?> sendotpdata = {
    'message': 'Use {{code}} to authorize your kwikee transaction',
    'duration': '10',
    'length': '4',
    'type': '3',
    'place_holder': '{{code}}',
    'phone_number': '',
    'email': '',
    'product': '3'
  };

  Map? verification = {};
  

  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  @override
  void initState() {
    setState(() {
      banklist = Get.arguments["data"];
      savings = Get.arguments["saving"];
    });
    saving.savingwithdrawal["investmentid"] = savings["investmentid"];
    // print(saving.savingwithdrawal["investmentid"]);
    // amount.text = savings["amount_saved"] != null ? savings["amount_saved"].toString() : '0';
    super.initState();
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // submit();
      setState(() {
        sendotpdata["phone_number"] = auth.userdata["telephone"];
        sendotpdata["email"] = auth.userdata["email"];
      });
      sendotp();
    } else {
    }
  }  


  sendotp() {
    context.loaderOverlay.show();
    withdraw.otpsend(sendotpdata: sendotpdata).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: "", header: value?["message"], bcolor: error);
        return;
      }
      if (value["status"] == "success") {
        setState(() {
          verification = value;
        });
        // snackbar(message: "", header: "OTP sent to your phone number and email.", bcolor: success);
        // submit();
        setState(() {
          otp = [];
        });
        otpdailog(context);
        return;
      }
      
    });
  }

  verificationOtp() {
    context.loaderOverlay.show();
    verification!["otp"] = otp.join();
    withdraw.verifyotp(verification: verification!).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: "", header: value?["message"], bcolor: error);
        return;
      }
      if (value["status"] == "success") {
        Get.back();
        submit();
        return;
      }
    });
  }

  resendotp() {
    context.loaderOverlay.show();
    withdraw.otpsend(sendotpdata: sendotpdata).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: "", header: value?["message"], bcolor: error);
        return;
      }
      if (value["status"] == "success") {
        setState(() {
          verification = value;
        });
        // snackbar(message: "", header: "OTP sent to your phone number and email.", bcolor: success);
        // submit();
        setState(() {
          otp = [];
        });
        return;
      }
    });
  }

  Future submit() async {
    context.loaderOverlay.show();
    // print(saving.savingwithdrawal);
    await saving.withsavings().then((value) {
      context.loaderOverlay.hide();
      // print(value);
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "error", bcolor: error);
      }
      if (value["status"] == "success") {
        Get.offAndToNamed('home', arguments: 1);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
    });
  }


  _showFullModal(context) {
    setState(() {
      allbanks = banklist;
    });
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Bank", // label for barrier
      transitionDuration: const Duration(milliseconds: 50), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) { // your widget implementation 
        return StatefulBuilder(
          builder:  (context, setState) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: CustomTheme.presntstate ? white : black,
                  ), 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
                title: Text(
                  "Bank",
                  style: TextStyle(color: CustomTheme.presntstate ? white : Colors.black87, fontFamily: 'Overpass', fontSize: 20),
                ),
                elevation: 0.0
              ),
              body: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xfff8f8f8),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(136, 136, 136, 1),
                        ),
                        onChanged: (value) {
                          final allbks = banklist.where((bank) {
                            final bankname = bank["name"].toLowerCase();
                            final searchname = value.toLowerCase();
                            return bankname.contains(searchname);
                          }).toList();
                          setState(() {
                            allbanks = allbks;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Sort Bank",
                          hintStyle: TextStyle(
                            color: black.withOpacity(0.3),
                            fontSize: 16
                          ),
                          
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemCount: allbanks.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return InkWell(
                              onTap: (){ 
                                bankeditor.text = allbanks[index]["name"];
                                saving.savingwithdrawal["bankcode"] = allbanks[index]["code"];
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: primary
                                    )
                                  )
                                ),
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  allbanks[index]["name"],
                                  style: TextStyle(
                                    color: Colors.grey[600]
                                  ),
                                )
                              ),
                            );
                          }
                        ),
                      )
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 40,
              height: 40, 
              child: Icon(
                FontAwesome.angle_left,
                size: 20,
                color: CustomTheme.presntstate ? white : primary,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Icon(
                    FontAwesome.bell,
                    color: registerActioncolor,
                    size: 20.0,
                    textDirection: TextDirection.ltr,
                    semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                  ),
                ],
              ),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Center(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 3.h),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: savingmonth,
                        shape: BoxShape.circle
                      ),
                      child: SvgPicture.asset(
                        'assets/image/circlemax.svg',
                        semanticsLabel: 'Target',
                        // color: white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Withdrawal",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: CustomTheme.presntstate ? creditwithdark : primary 
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    // height: ,
                    padding: const EdgeInsets.all(20),
                    // alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: CustomTheme.presntstate ? HexColor("#212845") : greybackground,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "GOALS - ${savings["savings_name"].toUpperCase()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: CustomTheme.presntstate ? white : primary
                          ),
                        ),
                        Text(
                          // "₦300,782",
                          stringamount(savings["amount_saved"].toString()),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 42,
                            fontFamily: GoogleFonts.roboto().toString(),
                            color: savingmonth
                          ),
                        ),
                        const SizedBox(height: 15),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text(
                                'Amount',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField( 
                                
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? whitescaffold : darkscaffold,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                                // obscureText: true,
                                controller: amount,
                                validator: RequiredValidator(errorText: 'Amount is required.'),
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                // initialValue: savings["amount_saved"].toString(),
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                  locale: 'en',
                                  decimalDigits: 0,
                                  symbol: '₦',
                                )],
                                onSaved: (val) {
                                  saving.savingwithdrawal["amount"] = saving.goalformatamount(val);
                                },
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Bank',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () =>_showFullModal(context),
                                child: TextFormField( 
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? whitescaffold : darkscaffold,
                                  ),
                                  // obscureText: true,
                                  enabled: false,
                                  validator: RequiredValidator(errorText: 'Bank is required.'),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  controller: bankeditor,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Bank Account Number',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField( 
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? whitescaffold : darkscaffold
                                ),
                                // obscureText: true,
                                // validator: RequiredValidator(errorText: 'Account number is required.'),
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Account number is required.'),
                                  MinLengthValidator(10, errorText: "Account number should be more than 10.")
                                ]),
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                controller: accountnumber,
                                onSaved: (val) {
                                  saving.savingwithdrawal["accountnumber"] = val;
                                },
                              ),

                              SizedBox(height: 2.h),
                              Text(
                                'Transaction Pin',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField( 
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? whitescaffold : darkscaffold
                                ),
                                // obscureText: true,
                                validator: RequiredValidator(errorText: 'Transaction pin is required.'),
                                keyboardType: TextInputType.number,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                controller: tranpin,
                                obscureText: true,
                                onSaved: (val) {
                                  saving.savingwithdrawal["transaction_pin"] = val;
                                },
                                
                              ),
                              
                            ],
                          )
                        ),
                        const SizedBox(height: 15),
                        
                        Text(
                          // "Your Funds will be withdrawn from you kwiklite and credited in this kwikmax.",
                          "",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : getstartedp.withOpacity(0.42),
                            fontSize: 11
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => validate(),
                          child: Container(
                            height: 44,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: registerActioncolor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "Withdraw",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  otpdailog(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "OTP", // label for barrier
      transitionDuration: const Duration(milliseconds:50), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: HexColor("#0000000F"),
                              ),
                              child: Icon(
                                Icons.cancel,
                                color: CustomTheme.presntstate ? white : primary,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                          color: CustomTheme.presntstate ? white : primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Enter the 4 digit pin",
                        style: TextStyle(
                          color: CustomTheme.presntstate ? white : black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 70.w,
                        height: 60,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                          color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: otp.length >= 1 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                              ),
                            ), 
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: otp.length >= 2 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: otp.length >= 3 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: otp.length >= 4 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                              ),
                            ) 
                          ],
                        )
                      ),
                      SizedBox(height: 35),
                      InkWell(
                        onTap: () => resendotp(),
                        child: Text(
                          "Resend OTP?",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      
                      NumericKeyboard(
                        onKeyboardTap: (val) {
                          if (otp.length == 4) {
                            // print(otp);
                            verificationOtp();
                            return;
                          }
                          if (otp.isNotEmpty || otp.length != 4) {
                            setState(() {
                              otp.add(val);
                            });
                            if (otp.length == 4) {
                              // print(otp);
                              verificationOtp();
                              return;
                            }
                          }
                        },
                        textColor: CustomTheme.presntstate ? white : primary,
                        rightButtonFn: () {
                          if (otp.isNotEmpty || otp.length != 0) {
                            setState(() {
                              otp.removeLast();
                            });
                            print(otp);
                          }
                        },
                        rightIcon: Icon(Icons.backspace, color: CustomTheme.presntstate ? white : primary),
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly
                      )


                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

}

