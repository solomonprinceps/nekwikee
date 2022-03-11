import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';


class Nameandemail extends StatefulWidget {
  const Nameandemail({ Key? key }) : super(key: key);

  @override
  _NameandemailState createState() => _NameandemailState();
}

class _NameandemailState extends State<Nameandemail> {

  bool isPhone = false;
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

  dynamic backendata = {
    "pin": "",
    "firstname": "",
    "lastname": "",
    "email": "",
    "telephone": "",
    "bvn": DateTime.now().millisecondsSinceEpoch.toString(),
    "dob": "2000-11-12",
  };


  @override
  void initState() {
    setState(() {
      backendata["telephone"] = Get.arguments["phone_number"];
    });
    super.initState();
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      Get.toNamed('register/password', arguments: backendata);
    } else {
      // _showMessage("Error Occoured.", error);
    }
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
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.h, left: 20, right: 20, bottom: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/image/reglogo.png',
                      // width: 60.w,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: themestate == "dark" ? white : onboardbackground
                      ),
                    ),
                    const  SizedBox(height: 10),
                    Text(
                      'Create your account to proceed to get loans at affordable interest rates.',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        height: 1.4,
                        fontSize: 12.sp,
                        color: themestate == "dark" ? inputcolordark : getstartedp    
                      ),
                    ),
                   SizedBox(height: 4.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            'First Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: themestate == "dark" ? inputcolordark : getstartedp
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField( 
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            validator: RequiredValidator(errorText: 'First Name must be required.'),
                            keyboardType: TextInputType.name,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onSaved: (val) => backendata["firstname"] = val,
                            textInputAction: TextInputAction.next,
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
                          SizedBox(height: 2.h),
                          Text(
                            'Last Name',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: themestate == "dark" ? inputcolordark : getstartedp
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField( 
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            validator: RequiredValidator(errorText: 'Last Name must be required.'),
                            keyboardType: TextInputType.name,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            onSaved: (val) => backendata["lastname"] = val,
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
                          SizedBox(height: 2.h),
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: themestate == "dark" ? inputcolordark : getstartedp
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField( 
                            style: TextStyle(
                              color: themestate == "dark" ? whitescaffold : darkscaffold
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Valid email is required.'),
                              EmailValidator(errorText: 'Valid email is required.'),    
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.done,
                            onSaved: (val) => backendata["email"] = val,
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
                          SizedBox(height: 2.h),
                          Text(
                            'Ensure to put in accurate information that tallies with the information on your Salary Bank Account.',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1.2,
                              fontSize: 13.sp,
                              color: themestate == "dark" ? inputcolordark : onboardbackground    
                            ),
                          ),
                          // SizedBox(height: .h),
                        ],
                      )
                    )
                  ],
                ),
              ),  
              const SizedBox(height: 100),            
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
                      Get.back();
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
          ),

        ],
      ),
    );
  }
}