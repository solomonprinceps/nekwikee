import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Passwordreset extends StatefulWidget {
  const Passwordreset({ Key? key }) : super(key: key);

  @override
  _PasswordresetState createState() => _PasswordresetState();
}

class _PasswordresetState extends State<Passwordreset> {
  SignupController signup =  Get.put(SignupController());
  bool isPhone = false;
  bool isChecked = false;
  dynamic data = {
    "email": ""
  };
  final _formKey = GlobalKey<FormState>();
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

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      resetp();
    } else {
      // _showMessage("Error Occoured.", error);
    }
  }  

  resetp() async {
    context.loaderOverlay.show();
    await signup.forgotpass(data).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        return;
        // Get.toNamed('register/setotp', );
        // Get.toNamed('register/nameandemail', arguments: verificationData);
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
    )
  );

  @override
  Widget build(BuildContext context) {
    final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themestate == 'light' ? whitescaffold : darkscaffold,
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
                padding: EdgeInsets.only(top: 17.h, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h),
                    Image.asset(
                      'assets/image/reglogo.png',
                      // width: 60.w,
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: themestate == "dark" ? white : onboardbackground
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Enter the email associated with your account and we’ll send an email with instructions to reset your password.',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1.3,
                        fontSize: 15,
                        color: themestate == "dark" ? inputcolordark : getstartedp    
                      ),
                    ),
                    const SizedBox(height: 25),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: themestate == "dark" ? inputcolordark : getstartedp
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField( 
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            onSaved: (val) {
                              setState(() {
                                data["email"] = val;
                              });
                            },
                            validator: EmailValidator(errorText: 'Email is required.'),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              filled: true,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(20),
                                child: SvgPicture.asset(
                                  'assets/image/mailbox.svg',
                                  // width: 6,
                                  // height: 6,
                                  semanticsLabel: 'Scanner'
                                ),
                              ),
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
                         
                          SizedBox(height: 12.h),
                          
                        ],
                      )
                    )
                  ],
                ),
              ),
              
              
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
                      Get.offAllNamed('register/getnumber');
                    },
                    child: Container(
                      width: 100.w,
                      height: 58,
                      decoration: BoxDecoration(
                        color: primary
                      ),
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
                      decoration: BoxDecoration(
                        color: registerActioncolor
                      ),
                      child: Center(
                        child: Text(
                          'Send Instructions',
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