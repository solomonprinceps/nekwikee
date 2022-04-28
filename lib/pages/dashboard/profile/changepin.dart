import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/controllers/withdrawalcontroller.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:hexcolor/hexcolor.dart';
class Changepin extends StatefulWidget {
  const Changepin({ Key? key }) : super(key: key);

  @override
  _ChangepinState createState() => _ChangepinState();
}

class _ChangepinState extends State<Changepin> {
  WithdrawController withdraw = Get.find<WithdrawController>();
  SavingController saving = Get.find<SavingController>();
  AuthController auth = Get.find<AuthController>();
  String? phonenumber;
  bool isPhone = false;
  final _formKey = GlobalKey<FormState>();
  dynamic data = {
    "pin": "",
    "pin_confirmation": "",
    "password": ""
  };


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


  Color resolvePhonecolor(String themestate) {
    // themestate == "dark" ? white : getstartedp    
    if ( themestate == "dark" && isPhone == true) {
      return whitescaffold;
    }

    if ( themestate == "light" && isPhone == true) {
      return labelactive;
    }

    if ( themestate == "dark" && isPhone == false) {
      return inputcolordark;
    }

    if ( themestate == "light" && isPhone == false) {
      return getstartedp;
    }
    return white;
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
        setpin();
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

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  setpin() async {
    context.loaderOverlay.show();
    await auth.updatepins(data).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        Get.offAllNamed('home', arguments: 2);
      }
      if (value?["status"] == "error") {
        snackbar(message: value?["message"], header: "Error", bcolor: error);  
        return; 
      }
    }).catchError((onError) {
      context.loaderOverlay.hide();
      print(onError);
    });
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      setState(() {
        sendotpdata["phone_number"] = auth.userdata["telephone"];
        sendotpdata["email"] = auth.userdata["email"];
      });
      sendotp();
      // Get.offAndToNamed('register/getnumber');
    } else {
      _showMessage("Error Occoured.", error);
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                  Container(
                    width: 60.w,
                    height: 15.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/topwaver.png'),
                        fit: BoxFit.cover,    // -> 02
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 25.w,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Change PIN',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary 
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Kindly provide a new four-digit pin to authorise transactions within the Kwikee App',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: CustomTheme.presntstate ? inputcolordark : getstartedp   
                            ),
                          ),
                          SizedBox(height: 6.h),
                
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  'New pin',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? white : black
                                  ),
                                  // validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Pin is required'),
                                    MinLengthValidator(4, errorText: "Pin should be 4 characters"),
                                    MaxLengthValidator(4, errorText: "Pin should be 4 characters")
                                  ]),
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  onSaved: (val) {
                                    setState(() {
                                      data["pin"] = val;
                                    });
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      data["pin"] = val;
                                    });
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Confirm new pin',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? white : black,
                                  ),
                                  // validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return "Pin confirmation is required";
                                    }
                                    if (data["pin"] != val) {
                                      return "Pin and Pin confirmation should same.";
                                    }
                                    return null;
                                  },
                                  
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  onSaved: (val) {
                                    setState(() {
                                      data["pin_confirmation"] = val;
                                    }); 
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      data["pin_confirmation"] = val;
                                    }); 
                                  },
                                ),
              
                                const SizedBox(height: 20),
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? white : black
                                  ),
                                  validator: RequiredValidator(errorText: 'Password is required.'),
                                  
                                  // keyboardType: TextInputType.visiblePassword,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  onSaved: (val) {
                                    setState(() {
                                      data["password"] = val;
                                    }); 
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      data["password"] = val;
                                    }); 
                                  },
                                ),
              
                                SizedBox(height: 5.h),
                               
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 30.h,),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        validate();
                      },
                      child: Container(
                        width: 100.w,
                        height: 58,
                        decoration: BoxDecoration(
                          color: registerActioncolor
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
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
                  padding: EdgeInsets.all(20),
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