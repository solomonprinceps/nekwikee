import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/controllers/logincontroller.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool isPhone = false;
  bool isChecked = false;
  bool loginError = false;
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

  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
     login();
    } else {
      _showMessage("Error Occoured.", error);
    }
  }  



  String? premail;
  LoginController loginstate = Get.find<LoginController>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  TextEditingController emailfeild = TextEditingController();
  String _message = "Not Authorized";
  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    // print(canCheckBiometrics);
    return canCheckBiometrics;
  }


  @override
  void initState() {
    checkingForBioMetrics();
    loadmail();
    super.initState();
  }

  Future loadmail() async {
    dynamic emailfe = await loginstate.firstmail();
    loginstate.login["email"] = emailfe;
    setState(() {
      premail = emailfe;
    });
  }

  Future<void> _authenticateMe() async {
    if (loginstate.finger["email"] == '' || loginstate.finger["email"] == 'null' || loginstate.finger["email"] == null) {
      snackbar(message: "Manual login required.", header: "Error", bcolor: error);
      return;
    }
    if (loginstate.finger["pin"] == '' || loginstate.finger["pin"] == 'null' || loginstate.finger["pin"] == null) {
      snackbar(message: "Manual login required.", header: "Error", bcolor: error);
      return;
    }
    bool authenticated = false;
    try {
      const iosStrings =  IOSAuthMessages(
        cancelButton: 'cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Biometrics.',
        lockOut: 'Please reenable your Biometrics'
      );
      const andoid = AndroidAuthMessages(
        signInTitle: "Authenticate Device"
      );
      authenticated = await _localAuthentication.authenticate(  
        biometricOnly: false,
        localizedReason: "Authenticate With biometrics", 
        iOSAuthStrings: iosStrings,
        androidAuthStrings: andoid,
        // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
      setState(() {
      _message = authenticated ? "Authorized" : "Not Authorized";
      });
      if (authenticated == true) {
        fingerlogin();
      }

    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  fingerlogin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    await loginstate.fingerlogincustomer().then((resp) {
      context.loaderOverlay.hide();
      print(resp);
      if (resp["status"] == "success") {
        loginstate.logging(resp["user"], resp["access_token"]);
        Get.offAllNamed('newsplash');
      }
      if (resp["status"] == "error") {
        Get.snackbar(
          "Error.", // title
          resp["message"], // message
          icon: const Icon(Icons.cancel),
          backgroundColor: error,
          colorText: Colors.grey.shade300,
          shouldIconPulse: true,
          // onTap:(){},
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      // Get.snackbar(
      //   "Error.", // title
      //   "Error Occoured", // message
      //   icon: const Icon(Icons.cancel),
      //   backgroundColor: error,
      //   colorText: Colors.grey.shade300,
      //   shouldIconPulse: true,
      //   // onTap:(){},
      //   barBlur: 20,
      //   isDismissible: true,
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 2),
      // );
    });
  }


  login() async {
    context.loaderOverlay.show();
    await loginstate.logincustomer().then((resp) {
      context.loaderOverlay.hide();
      // print(resp);
      if (resp["status"] == "error") {
        Get.snackbar(
          "Error.", // title
          resp["message"], // message
          icon: const Icon(Icons.cancel),
          backgroundColor: error,
          colorText: Colors.grey.shade300,
          shouldIconPulse: true,
          // onTap:(){},
          barBlur: 20,
          isDismissible: true,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      if (resp?["status"] == "success") {
        print(resp?["user"]);
        loginstate.savefingerdata(loginstate.login["email"].toString(), loginstate.login["pin"].toString());
        loginstate.logging(resp?["user"], resp?["access_token"]);
        Get.offAllNamed('home');
        return;
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      Get.snackbar(
        "Error.", // title
        "Error Occoured", // message
        icon: const Icon(Icons.cancel),
        backgroundColor: error,
        colorText: Colors.grey.shade300,
        shouldIconPulse: true,
        // onTap:(){},
        barBlur: 20,
        isDismissible: true,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
      );
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 75.w,
                    height: 15.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/logreg1.png'),
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
                      padding: const EdgeInsets.only(top: 17, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 60.w,
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary 
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Visibility(
                            visible: premail == null,
                            child: Text(
                              'Enter your credentials to log in to your Kwikee account.',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                height: 1.3,
                                fontSize: 15,
                                color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                              ),
                            ),
                          ),
                          Visibility(
                            visible: premail != null,
                            child: Text(
                              premail.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                height: 1.3,
                                fontSize: 15,
                                color: CustomTheme.presntstate ? inputcolordark : getstartedp 
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Visibility(
                                  visible: premail == null,
                                  child: Text(
                                    'Email Address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: premail == null,
                                  child: const SizedBox(height: 5)
                                ),
                                Visibility(
                                  visible: premail == null,
                                  child: TextFormField( 
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? whitescaffold : darkscaffold
                                    ),
                                    // obscureText: true,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Valid email is required.'),
                                      EmailValidator(errorText: 'Valid email is required.'),    
                                    ]),
                                    keyboardType: TextInputType.emailAddress,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.done,
                                    onSaved: (val) {
                                      loginstate.login["email"] = val;
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: premail == null,
                                  child: SizedBox(height: 2.h)
                                ),
                                Visibility(
                                  visible: premail == null,
                                  child: SizedBox(height: 2.h)
                                ),
                                
                                Text(
                                  'Password',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: TextFormField( 
                                        style: TextStyle(
                                          color: CustomTheme.presntstate ? whitescaffold : darkscaffold
                                        ),
                                        obscureText: true,
                                        validator: RequiredValidator(errorText: 'Password is required.'),
                                        // keyboardType: TextInputType.name,
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.done,
                                        onSaved: (val) {
                                          loginstate.login["pin"] = val;
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                          
                                          errorStyle: const TextStyle(color: Colors.red),
                                        )
                                      ),
                                    ),
                    
                                    InkWell(
                                      onTap: () {
                                        _authenticateMe();
                                      },
                                      child: SizedBox(
                                        // margin: loginError : ,
                                        child: SvgPicture.asset(
                                          'assets/image/finger_scanner.svg',
                                          // color: Colors.red,
                                          width: 40,
                                          height: 50,
                                          semanticsLabel: 'Scanner'
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: RichText(
                                        text: TextSpan(
                                          children:  <TextSpan>[
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()..onTap = () {
                                                Get.toNamed('auth/password/reset');
                                              },
                                              text: 'Forgot Password?', 
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
                                    Visibility(
                                      visible: premail != null,
                                      child: SizedBox(
                                        child: RichText(
                                          text: TextSpan(
                                            children:  <TextSpan>[
                                              TextSpan(
                                                recognizer: TapGestureRecognizer()..onTap = () async {
                                                  setState(() {
                                                    premail = null;
                                                  });
                                                  SharedPreferences authstorage = await SharedPreferences.getInstance();
                                                  authstorage.remove('fingeremail');
                                                  authstorage.remove('fingerpassword');
                                                },
                                                text: 'Switch Account', 
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
                                    ),
                                  ],
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
                        // Get.offAllNamed('home');
                        validate();
                      },
                      child: Container(
                        width: 100.w,
                        height: 58,
                        decoration: BoxDecoration(
                          color: primary
                        ),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAndToNamed('register/getnumber');
                      },
                      child: Container(
                        width: 100.w,
                        height: 58,
                        decoration: BoxDecoration(
                          color: registerActioncolor
                        ),
                        child: Center(
                          child: Text(
                            'Create an Account',
                            style: TextStyle(
                              color: white,
                              fontSize: 15,
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