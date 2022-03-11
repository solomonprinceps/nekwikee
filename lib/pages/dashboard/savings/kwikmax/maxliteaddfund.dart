import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';


class Maxliteaddfund extends StatefulWidget {
  const Maxliteaddfund({ Key? key }) : super(key: key);

  @override
  _MaxliteaddfundState createState() => _MaxliteaddfundState();
}

class _MaxliteaddfundState extends State<Maxliteaddfund> {
  final _formKey = GlobalKey<FormState>();

  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                FontAwesome.angle_left,
                size: 30,
                color: black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  
                  Icon(
                    FontAwesome.bell,
                    color: registerActioncolor,
                    size: 20.0,
                    textDirection: TextDirection.ltr,
                    semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: white,
          elevation: 0,
        ),
        backgroundColor: white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),
                    Text(
                      "Add Funds",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 35,
                        color: primary
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      width: double.infinity,
                      height: 482,
                      padding: const EdgeInsets.all(20),
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: greybackground,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            "KWIK LITE BALANCE",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              letterSpacing: 1.6,
                              color: primary
                            ),
                          ),
                          Text(
                            "₦300,782",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 42,
                              color: primary
                            ),
                          ),
                          const SizedBox(height: 15),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  'Enter amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color:  getstartedp
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField( 
                                  style: TextStyle(
                                    color: darkscaffold
                                  ),
                                  // obscureText: true,
                                  validator: RequiredValidator(errorText: 'Amount is required'),
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  
                                  decoration: InputDecoration(
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                                    fillColor: inputColor ,
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
                                
                              ],
                            )
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "FUND KWIKLITE",
                            style: TextStyle(
                              color: getstartedp,
                              fontSize: 17
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Your Kwiklite is directly connected to a bank account which could be funded using the above Wema Bank Account Number.",
                            style: TextStyle(
                              color: getstartedp.withOpacity(0.42),
                              fontSize: 11
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                "WEMA BANK",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: primary,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 34,
                                // width: 45,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.copy,
                                      color: white,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "183193910",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: white
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                         
                          GestureDetector(
                            onTap: () => Get.toNamed("savings/goals/withdrawal"),
                            child: Card(
                              color: HexColor("#0000000F"),
                              child: Container(
                                width: double.infinity,
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(66, 213, 121, 1),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor("#0000000F"),
                                      blurRadius: 3,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Withdraw',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: white
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ],
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
          ),
        ),
      ),
    );
  }
}