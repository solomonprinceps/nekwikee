import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Passwordreset extends StatefulWidget {
  const Passwordreset({ Key? key }) : super(key: key);

  @override
  _PasswordresetState createState() => _PasswordresetState();
}

class _PasswordresetState extends State<Passwordreset> {
  CustomTheme currentheme = CustomTheme();
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

  void clearalldata() async {
    // Get.back();
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.remove('user');
    authstorage.remove('accessToken');
    authstorage.remove('fingeremail');
    authstorage.remove('fingerpassword');
    // authstorage.remove('passgetstarted');
    authstorage.remove('firstmail');
    Get.offAndToNamed('auth/login');
  }

  resetp() async {
    context.loaderOverlay.show();
    await signup.forgotpass(data).then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value?["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);  
        // Get.offAndToNamed('auth/login');
        clearalldata();
        return;
        
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
    return Scaffold(
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
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 50.w,
                          ),
                          SizedBox(height: 5.h),
                          InkWell(
                            onTap: () {
                              currentheme.toggleTheme(CustomTheme.presntstate);
                            },
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: CustomTheme.presntstate ? creditwithdark : primary,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Enter the email associated with your account and we’ll send an email with instructions to reset your password.',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1.3,
                              fontSize: 15,
                              color: CustomTheme.presntstate ? inputcolordark : getstartedp 
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
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField( 
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? whitescaffold : darkscaffold
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
                                        semanticsLabel: 'Scanner'
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                    // fillColor: CustomTheme.presntstate ? inputcolordark : inputColor,
                                    border: inputborder,
                                    focusedBorder: activeinputborder,
                                    enabledBorder: inputborder,
                                    focusedErrorBorder:inputborder ,
                                    errorBorder: errorborder,
                                    disabledBorder: inputborder,
                                    errorStyle: const TextStyle(color: Colors.red),
                                  )
                                ),
                                const SizedBox(height: 10),
                                const SizedBox(height: 20),
                                SizedBox(
                                  
                                  child: RichText(
                                    text: TextSpan(
                                      children:  <TextSpan>[
                                        TextSpan(
                                          recognizer: TapGestureRecognizer()..onTap = () {
                                            // print('Terms and Conditions Single Tap');
                                            Get.toNamed('auth/login');
                                          },
                                          text: ' Already have an account ?', 
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
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}