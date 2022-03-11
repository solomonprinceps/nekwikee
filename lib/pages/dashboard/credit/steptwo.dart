import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import 'package:form_field_validator/form_field_validator.dart';



class CreditSecond extends StatefulWidget {
  const CreditSecond({ Key? key }) : super(key: key);

  @override
  _CreditSecondState createState() => _CreditSecondState();
}

class _CreditSecondState extends State<CreditSecond> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic tranw;
  List transwhere = [
    {"text": "Male", "value": '30'},
    {"text": "Female", "value": '90'},
  ];
  TextEditingController startdate = TextEditingController();
  TextEditingController numberofyear = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Number of years',
          style: TextStyle(
            fontSize: 20,
            color: primary
          ),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              '2',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          CupertinoActionSheetAction(
            child: Text(
              'Married',
              style: TextStyle(
                fontSize: 20,
                color: black
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 20,
              color: error
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: ,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20.h,
                  width: 100.w,
                  // child: Text("fiosa"),  
                  decoration: BoxDecoration(
                    color: primary,
                    image: const DecorationImage(image: AssetImage("assets/image/credithome.png"), fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Container(
                    // padding: const EdgeInsets.only(left: 33, right: 33, top: 28),
                    width: 100.w,
                    color: dashboardcard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Information",
                          style: TextStyle(
                            fontSize: 21,
                            color: primary,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            
                            Container(
                              height: 6,
                              width: 23,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 6,
                              width: 61,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 6,
                              width: 23,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 6,
                              width: 23,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 6,
                              width: 23,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.6),
                                borderRadius: const BorderRadius.all(Radius.circular(20))
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                    
                        Expanded(
                          child: SizedBox(
                            width: 100.w,
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: getstartedp
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField( 
                                    style: TextStyle(
                                      color: darkscaffold 
                                    ),
                                    // validator: 
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Phone number is required.'),
                                      MinLengthValidator(11, errorText: "11 characters required.")
                                    ]),
                                    keyboardType: TextInputType.phone,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: phone,
                                    // onSaved: (val) => backendata["firstname"] = val,
                                    // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixIconColor: primary,
                                      suffix: Icon(
                                        FontAwesome.calendar_plus_o,
                                        color: const Color.fromRGBO(53, 49, 48, 0.73).withOpacity(0.5),
                                        size: 20,
                                      ),
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                      fillColor: inputColor,
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
                                    'Current Residential Address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: getstartedp
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField( 
                                    style: TextStyle(
                                      color: darkscaffold 
                                    ),
                                    // enabled: false,
                                    validator: RequiredValidator(errorText: 'Current residential is required.'),
                                    keyboardType: TextInputType.name,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    maxLines: 4,
                                    controller: address,
                                    // onSaved: (val) => backendata["firstname"] = val,
                                    // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                      fillColor:  inputColor,
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
                                    'Number of Years in above address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: getstartedp
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () => shoWidget(),
                                    child: TextFormField( 
                                      style: TextStyle(
                                        color: darkscaffold 
                                      ),
                                      enabled: false,
                                      validator: RequiredValidator(errorText: 'Number of years is required.'),
                                      keyboardType: TextInputType.name,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: numberofyear,
                                      // onSaved: (val) => backendata["firstname"] = val,
                                      // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Select an option",
                                        
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromRGBO(53, 49, 48, 0.73).withOpacity(0.5),
                                          fontWeight: FontWeight.w400
                                        ),
                                        suffixIconColor: primary,
                                        // suffix:const Icon(
                                        //   FontAwesome.angle_down
                                        // ),
                                        filled: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                        fillColor:  inputColor,
                                        border: inputborder,
                                        focusedBorder: activeinputborder,
                                        enabledBorder: inputborder,
                                        focusedErrorBorder:inputborder ,
                                        errorBorder: errorborder,
                                        disabledBorder: inputborder,
                                        errorStyle: const TextStyle(color: Colors.red),
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 40),

                                  GestureDetector(

                                  onTap: () => Get.toNamed('credit/three'),
                                  child: Container(
                                    width: 100.w,
                                    height: 58,
                                    color: const Color.fromRGBO(66, 213, 121, 1),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                                  
                                ],
                              ),
                            ),
                          )
                        )

                       
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
            
            Positioned(
              top: 16.h,
              right: 7.w,
              child: Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  "assets/image/Iconmoney-bill.svg",
                  semanticsLabel: 'Acme Logo',
                  width: 40,
                  height: 20,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  shape: BoxShape.circle
                ),
              )
            ),
            Positioned(
              top: 6.h,
              left: 3.w,
              child: GestureDetector(
                onTap: () =>  Get.back(),
                child: Container(
                  width: 42,
                  height: 42,
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    FontAwesome.angle_left,
                    color: black,
                  ),
                 
                ),
              )
            ),
            
          ],
        ),
      ),
    );
  }
}