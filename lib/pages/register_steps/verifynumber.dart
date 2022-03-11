import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:flutter/gestures.dart';

class Verifynumber extends StatefulWidget {
  const Verifynumber({Key? key}) : super(key: key);

  @override
  _VerifynumberState createState() => _VerifynumberState();
}

class _VerifynumberState extends State<Verifynumber> {
  SignupController signup =  Get.put(SignupController());
  dynamic verificationData;
  bool isPhone = false;
  final _formKey = GlobalKey<FormState>();
  Color resolvePhonecolor(String themestate) {
    // themestate == "dark" ? white : getstartedp
    if (themestate == "dark" && isPhone == true) {
      return whitescaffold;
    }

    if (themestate == "light" && isPhone == true) {
      return labelactive;
    }

    if (themestate == "dark" && isPhone == false) {
      return inputcolordark;
    }

    if (themestate == "light" && isPhone == false) {
      return getstartedp;
    }
    return white;
  }


  veriftOtp() async {
    context.loaderOverlay.show();
    await signup.verifyotp().then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        // Get.toNamed('register/setotp', );
        Get.toNamed('register/nameandemail', arguments: verificationData);
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

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      veriftOtp();
      // Get.toNamed('register/nameandemail');
    } else {
      _showMessage("Pin incomplete.", error);
    }
  }

  @override
  void initState() {
    setState(() {
      verificationData = Get.arguments;
      signup.verification["otp_id"] = verificationData["otp_id"];
    });
    super.initState();
  }

  callOtp() async {
    context.loaderOverlay.show();
    await signup.otpsend().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        // signupstate.verification["otp_id"] = value["otp_id"];
        value["phone_number"] = signup.sendotp["phone_number"];
        // Get.toNamed('register/verifynumber', arguments: value);
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

  final BoxDecoration pinPutDecoration = BoxDecoration(
      border: Border(
    bottom: BorderSide(width: 2.0, color: labelactive),
  ));

  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final String themestate =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? "light"
            : "dark";
    return Scaffold(
      backgroundColor: themestate == 'light' ? whitescaffold : darkscaffold,
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                    fit: BoxFit.cover, // -> 02
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 17.h, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/image/reglogo.png',
                      // width: 60.w,
                    ),
                    SizedBox(height: 7.h),
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                        color: themestate == "dark" ? white : onboardbackground
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'We sent a verification code to your number Enter the code below to proceed.',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1.3,
                        fontSize: 13.sp,
                        color: themestate == "dark"
                            ? inputcolordark
                            : getstartedp
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  const EdgeInsets.only(left: 1, right: 15),
                              child: Row(
                              children: [
                                Text(
                                  '${verificationData["phone_number"]}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: themestate == "dark"
                                        ? labelactive
                                        : primary,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  FontAwesome.pencil_square_o,
                                  size: 15,
                                  color: labelactive,
                                )
                              ],
                            )
                          ),

                          const SizedBox(height: 7),
                          PinPut(
                            textStyle: TextStyle(
                              color: themestate == "dark" ? white : black,
                              fontSize: 25.0,
                            ),
                            autovalidateMode: AutovalidateMode.always,
                            withCursor: true,
                            fieldsCount: 4,
                            validator: MinLengthValidator(4, errorText: "Pin must be four characters"),
                            fieldsAlignment: MainAxisAlignment.spaceAround,
                            eachFieldMargin: const EdgeInsets.all(0),
                            eachFieldWidth: 45.0,
                            eachFieldHeight: 55.0,
                            onSaved: (val) => {
                              signup.verification["otp"] = val
                            },
                            focusNode: _pinPutFocusNode,
                            // controller: _pinPutController,
                            submittedFieldDecoration: pinPutDecoration,
                            selectedFieldDecoration: pinPutDecoration,
                            followingFieldDecoration: pinPutDecoration,
                            pinAnimationType: PinAnimationType.scale,
                          ),
                          SizedBox(height: 7.h),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 1, right: 15),
                            child: RichText(
                              text: TextSpan(
                                text: 'Did\'t receive OTP? ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: themestate == "dark"
                                      ? inputcolordark
                                      : primary
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Resend OTP',
                                    recognizer: TapGestureRecognizer()..onTap = () => callOtp(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Color.fromRGBO(0, 175, 239, 1)
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: 25.h)
                        ],
                      )
                    )
                  ],
                ),
              ),
              // SizedBox(height: 22.h),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAndToNamed('register/getnumber');
                      
                    },
                    child: Container(
                      width: 100.w,
                      height: 58,
                      decoration: BoxDecoration(color: labelactive),
                      child: Center(
                        child: Text(
                            'Previous',
                            style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      validate();
                    },
                    child: Container(
                      width: 100.w,
                      height: 58,
                      decoration: BoxDecoration(color: registerActioncolor),
                      child: Center(
                        child: Text(
                          'Verify My Number',
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
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
    );
  }
}
