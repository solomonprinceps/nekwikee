import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Setotp extends StatefulWidget {
  const Setotp({ Key? key }) : super(key: key);

  @override
  _SetotpState createState() => _SetotpState();
}

class _SetotpState extends State<Setotp> {
  AuthController auth = AuthController();
  String? phonenumber;
  bool isPhone = false;
  final _formKey = GlobalKey<FormState>();
  dynamic data = {
    "pin": "",
    "pin_confirmation": ""
  };
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
    await auth.changepins(data).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        Get.offAllNamed('third');
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
      setpin();
      // Get.offAndToNamed('register/getnumber');
    } else {
      _showMessage("Error Occoured.", error);
    }
  }  

  @override
  Widget build(BuildContext context) {
    final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
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
                    fit: BoxFit.cover,    // -> 02
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.h),
                    Image.asset(
                      'assets/image/reglogo.png',
                      // width: 60.w,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Create PIN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: themestate == "dark" ? white : onboardbackground
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Kindly provide a five-digit pin to authorise transactions within the Kwikie App',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: themestate == "dark" ? inputcolordark : getstartedp    
                      ),
                    ),
                    SizedBox(height: 6.h),
          
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            'Enter pin',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: resolvePhonecolor(themestate)
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            // validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Pin is required'),
                              MinLengthValidator(5, errorText: "Pin should be 5 characters"),
                              MaxLengthValidator(5, errorText: "Pin should be 5 characters")
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
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                              fillColor: themestate == 'dark' ? inputcolordark : inputColor,
                              border: inputborder,
                              focusedBorder: activeinputborder,
                              enabledBorder: inputborder,
                              focusedErrorBorder:inputborder ,
                              errorBorder: errorborder,
                              disabledBorder: inputborder,
                              errorStyle: const TextStyle(color: Colors.red),
                            )
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Confirm Pin',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: resolvePhonecolor(themestate)
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            // validator: MinLengthValidator(11, errorText: 'phone number must be atleast 11 digits long'),
                            validator: (val) {
                              if (val == null || val == '') {
                                return "Pin confirmation is required";
                              }
                              if (data["pin"] != val) {
                                return "Pin and Pin comfirmation should same.";
                              }
                              return null;
                            },
                            // validator: MultiValidator([
                            //   RequiredValidator(errorText: 'Pin confirmation is required'),
                            //   MinLengthValidator(5, errorText: "Pin confirmation should be 5 characters"),
                            //   MaxLengthValidator(5, errorText: "Pin confirmation should be 5 characters")
                            // ]),
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
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                              fillColor: themestate == 'dark' ? inputcolordark : inputColor,
                              border: inputborder,
                              focusedBorder: activeinputborder,
                              enabledBorder: inputborder,
                              focusedErrorBorder:inputborder ,
                              errorBorder: errorborder,
                              disabledBorder: inputborder,
                              errorStyle: const TextStyle(color: Colors.red),
                            )
                          ),
                          SizedBox(height: 5.h),
                          // Text(
                          //   'We May Store and send a verification code to this number.',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w300,
                          //     fontSize: 12,
                          //     color: themestate == "dark" ? inputcolordark : primary    
                          //   ),
                          // ),
                        ],
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 30.h,),
          Positioned(
            bottom: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: RichText(
                  //     text: TextSpan(
                  //       text: 'I already have an Account ',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 13.sp,
                  //         color: themestate == "dark" ? inputcolordark : getstartedp
                  //       ),
                  //       children:  <TextSpan>[
                  //         TextSpan(
                  //           text: ' Log In', 
                  //            recognizer: TapGestureRecognizer()
                  //             ..onTap = () {
                  //               Get.toNamed('auth/login');
                  //             },
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 15.sp,
                  //             color: const Color.fromRGBO(0, 175, 239, 1)
                  //           )
                  //         ),
                  //       ],
                  //     ),
                  //   )
                  // ),
                  // const SizedBox(height: 20),
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
          ),
        ],
      ),
    );
  }
}