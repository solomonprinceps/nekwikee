import 'package:flutter/material.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kwikee1/controllers/logincontroller.dart';
import 'package:kwikee1/controllers/signupcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/themes/apptheme.dart';

class Password extends StatefulWidget {
  const Password({ Key? key }) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  bool isPhone = false;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  dynamic backendata;
  SignupController signupstate = Get.find<SignupController>();
  LoginController loginstate = Get.find<LoginController>();
  CustomTheme currentheme = CustomTheme();

  @override
  void initState() {
    setState(() {
      backendata = Get.arguments;
    });
    super.initState();
  }

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
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void validate() {
    // if(!isChecked) {
    //   _showMessage("Accept Terms and condition.", error);
    //   return;
    // }
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      register();
    } else {
      _showMessage("Error Occoured.", error);
    }
  }  

  register() async {
    context.loaderOverlay.show();
    await signupstate.registercustomer(backendata).then((value) {
      context.loaderOverlay.hide();
      var resp = value;
      if (resp["status"] == "success") {
        loginstate.savefingerdata(signupstate.signup["email"].toString(),signupstate.signup["pin"].toString());
        loginstate.logging(value["user"], value["access_token"]);
        // Get.offAllNamed('third');
         Get.toNamed('register/setotp');
        // Get.toNamed('login');
      }
      if (resp["status"] == "error") {
       snackbar(message: resp["message"], header: "Error", bcolor: error);
       return;
      }
      // print(resp?["message"] );
    })
    .catchError((onError) {
      context.loaderOverlay.hide();
      print(error);
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
                      padding:  const EdgeInsets.only(left: 20, right: 20),
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
                            'Enter Credentials',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Create your account to proceed to get loans at affordable interest rates.',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1.6,
                              fontSize: 15,
                              color: CustomTheme.presntstate ? inputcolordark : getstartedp      
                            ),
                          ),
                          const SizedBox(height: 17),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  'Enter Password',
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
                                  obscureText: true,
                                  validator: RequiredValidator(errorText: 'Password is required.'),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (val) => backendata["pin"] = val,
                                  onSaved: (val) => backendata["pin"] = val,
                                 
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Re - Enter Password',
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
                                  obscureText: true,
                                  validator: (val) {
                                    if (val == null || val == '') {
                                      return "Password confirmation is required";
                                    }
                                    if (backendata["pin"] != val) {
                                      return "Password and password comfirmation should same.";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  
                                ),
                                const SizedBox(height: 20),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [
                                //     Checkbox(
                                //       activeColor: Colors.grey.shade400,
                                //       value: isChecked,
                                //       onChanged: (value) {
                                //         setState(() {
                                //           isChecked = value!;
                                //         });
                                //       },
                                //     ),
                                //     SizedBox(
                                      
                                //       child: RichText(
                                //         text: TextSpan(
                                //           text: 'I agree with the',
                                //           style: TextStyle(
                                //             fontWeight: FontWeight.w300,
                                //             fontSize: 15,
                                //             color: CustomTheme.presntstate ? inputcolordark : getstartedp   
                                //           ),
                                //           children:  const <TextSpan>[
                                //             TextSpan(
                                //               text: ' Terms and Conditions \n', 
                                //               style: TextStyle(
                                //                 fontWeight: FontWeight.w500,
                                //                 fontSize: 15,
                                //                 color: Color.fromRGBO(0, 175, 239, 1)
                                //               )
                                //             ),
                                //             TextSpan(
                                //               text: 'of the kwikee Platform.', 
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10.h),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        validate();
                        // Get.toNamed('auth/login');
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed('register/getnumber');
                      },
                      child: Container(
                        width: 100.w,
                        height: 58,
                        decoration: BoxDecoration(
                          color: labelactive
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
                    
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}