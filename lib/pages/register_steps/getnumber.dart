import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/themes/apptheme.dart';

class Getnumber extends StatefulWidget {
  const Getnumber({ Key? key }) : super(key: key);

  @override
  _GetnumberState createState() => _GetnumberState();
}

class _GetnumberState extends State<Getnumber> {
  SignupController signup = SignupController();
  String? phonenumber;
  bool isPhone = false;
  CustomTheme currentheme = CustomTheme();
  final _formKey = GlobalKey<FormState>();
  // Color resolvePhonecolor(bool CustomTheme) {
  //   // CustomTheme.presntstate ? white : getstartedp    
  //   if ( CustomTheme.presntstate && isPhone == true) {
  //     return whitescaffold;
  //   }

  //   if ( CustomTheme.presntstate == "light" && isPhone == true) {
  //     return labelactive;
  //   }

  //   if ( CustomTheme.presntstate && isPhone == false) {
  //     return inputcolordark;
  //   }

  //   if ( CustomTheme.presntstate == "light" && isPhone == false) {
  //     return getstartedp;
  //   }
  //   return white;
  // }

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  callOtp() async {
    context.loaderOverlay.show();
    await signup.otpsend().then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        // signupstate.verification["otp_id"] = value["otp_id"];
        value["phone_number"] = signup.sendotp["phone_number"];
        Get.toNamed('register/verifynumber', arguments: value);
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
      callOtp();
    } else {
      _showMessage("Error Occoured.", error);
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.presntstate ? darkscaffold :  whitescaffold,
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 25.w,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary 
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                           'Enter your Mobile Number to get started.',
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                  'Phone Number',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  onChanged: (val) {
                                    if (val != '' || val != '  ') {
                                      signup.sendotp["phone_number"] = val;
                                    }
                                    if (signup.sendotp["phone_number"]!.length == 11) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    }
                                  },
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? whitescaffold : darkscaffold
                                  ),
                                  validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                                  keyboardType: TextInputType.phone,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  onSaved: (val) {
                                    signup.sendotp["phone_number"] = val;
                                  },
                                  
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  'We May Store and send a verification code to this number.',
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? const Color.fromRGBO(246, 251, 254, 0.6) : const Color.fromRGBO(62, 64, 149, 1)
                                  ),
                                ),
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
                    RichText(
                      text: TextSpan(
                        text: 'I already have an Account ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: CustomTheme.presntstate ?const Color.fromRGBO(246, 251, 254, 0.6) : HexColor("#35313099"),
                        ),
                        children:  <TextSpan>[
                          TextSpan(
                            text: ' Log In', 
                             recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed('auth/login');
                              },
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color:Color.fromRGBO(0, 175, 239, 1)
                            )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
                            'Next',
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
}