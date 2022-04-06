import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kwikee1/themes/apptheme.dart';


class Nameandemail extends StatefulWidget {
  const Nameandemail({ Key? key }) : super(key: key);

  @override
  _NameandemailState createState() => _NameandemailState();
}

class _NameandemailState extends State<Nameandemail> {

  bool isPhone = false;
  CustomTheme currentheme = CustomTheme();
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
    "verified": "",
    "bvn": DateTime.now().millisecondsSinceEpoch.toString(),
    "dob": "2000-11-12",
  };


  @override
  void initState() {
    print(Get.arguments["verified"]);
    setState(() {
      backendata["telephone"] = Get.arguments["phone_number"];
      backendata["verified"] = Get.arguments["verified"];
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
                          Image.asset(
                            CustomTheme.presntstate ? 'assets/image/newlogo1white.png' :
                            'assets/image/newlogo1.png',
                            width: 25.w,
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Verified',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: CustomTheme.presntstate ? creditwithdark : primary
                            ),
                          ),
                          const  SizedBox(height: 10),
                          Text(
                            'Create your account to proceed to get loans at affordable interest rates.',
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              height: 1.6,
                              fontSize: 15,
                              color: CustomTheme.presntstate ? inputcolordark : getstartedp    
                            ),
                          ),
                         SizedBox(height: 2.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  'First Name',
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
                                  validator: RequiredValidator(errorText: 'First Name must be required.'),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  onSaved: (val) => backendata["firstname"] = val,
                                  textInputAction: TextInputAction.next,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Last Name',
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
                                  validator: RequiredValidator(errorText: 'Last Name must be required.'),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (val) => backendata["lastname"] = val,
                                ),
                                SizedBox(height: 2.h),
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
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Valid email is required.'),
                                    EmailValidator(errorText: 'Valid email is required.'),    
                                  ]),
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  onSaved: (val) => backendata["email"] = val,
                                ),
                                SizedBox(height: 2.h),
                                // Text(
                                //   'Ensure to put in accurate information that tallies with the information on your Salary Bank Account.',
                                //   maxLines: 2,
                                //   softWrap: true,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w300,
                                //     height: 1.2,
                                //     fontSize: 12,
                                //     color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                //   ),
                                // ),
                              ],
                            )
                          )
                        ],
                      ),
                    ),  
                    // const SizedBox(height: 100),            
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
                        decoration: BoxDecoration(color: registerActioncolor),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        
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