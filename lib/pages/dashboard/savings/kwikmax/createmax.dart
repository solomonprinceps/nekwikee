import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMax extends StatefulWidget {
  const CreateMax({ Key? key }) : super(key: key);

  @override
  _CreateMaxState createState() => _CreateMaxState();
}

class _CreateMaxState extends State<CreateMax> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SavingController savings  = Get.put(SavingController());
  AuthController auth = Get.put(AuthController());
  dynamic tranw;
  List transwhere = [
    {"text": "30 Days", "value": '30'},
    {"text": "90 Days", "value": '90'},
    {"text": "180 Days", "value": '180'},
    {"text": "270 Days", "value": '270'},
    {"text": "365 Days", "value": '365'},
    {"text": "730 Days", "value": '730'},
    {"text": "Others", "value": " "}
  ];
  dynamic _chosenDateTime;
  TextEditingController startdate = TextEditingController();
  TextEditingController amount = TextEditingController();


  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    FocusScope.of(context).requestFocus(FocusNode());
    startdate.text = dateformaterY_M_D(DateTime.now().toString());
    savings.createKwikMax["start_date"] = dateformaterY_M_D(DateTime.now().toString());
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 350,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 140,
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (val) {
                    setState(() {
                      _chosenDateTime = val;
                      startdate.text = dateformaterY_M_D(_chosenDateTime.toString());
                      savings.createKwikMax["start_date"] = dateformaterY_M_D(_chosenDateTime.toString());
                      // print(dateformaterY_M_D(_chosenDateTime.toString()));
                    });
                  }
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Close the modal
            Column(
              children: [
                CupertinoButton(
                  child: Text(
                    'Select',
                    style: TextStyle(
                      color: white
                    ),
                  ),
                  color: primary,
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: white
                    ),
                  ),
                  color: error,
                  onPressed: () {
                    startdate.text = "";
                    savings.createKwikMax["start_date"] = "";
                    Navigator.of(ctx).pop();
                  },
                  // onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // print(savings.createKwikGoal);
      submitmax();
    //  login();
    } else {
    }
  } 

  submitmax() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    await savings.makeMax().then((value) {
      context.loaderOverlay.hide();
      print(value); 
      if (value["status"] == "success") {
        snackbar(message: value["message"], header: "successful", bcolor: success);
        // Get.toNamed('dashboard/savings/confirmation', arguments: value);
          Get.toNamed('savings/max/confirm', arguments: value);
        return;
      }
      if (value["status"] == "error") {
        snackbar(message: "An Error Occoured.", header: "Error.", bcolor: error);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
      snackbar(message: "An Error Occoured.", header: "Error.", bcolor: error);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            // color: black,
            child: Icon(
              FontAwesome.angle_left,
              size: 20,
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.only(bottom: 40),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary
                    ),
                    child: Icon(
                      FontAwesome5Solid.piggy_bank,
                      color: HexColor("#F6FBFE"),
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "KwikMax",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                            color: primary
                          ),
                        ),
                        Text(
                          "Lock your funds for a minimum of 3 month Interest rate is 15% per annum. Minimum amount is ₦50,000",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#353130")
                          ),
                          overflow: TextOverflow.clip,
                          softWrap: true,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      // Text("data"),
                      
                      Text(
                        'How much do you want to save?',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: getstartedp,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField( 
                        style: TextStyle(
                          color: darkscaffold,
                          fontFamily: GoogleFonts.roboto().toString(),
                        ),
                        validator: RequiredValidator(errorText: 'Amount is required.'),
                        keyboardType: TextInputType.number,
                        controller: amount,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                          locale: 'en',
                          decimalDigits: 0,
                          symbol: '₦',
                        )],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) {
                          savings.createKwikMax["target_amount"] = savings.goalformatamount(val);
                          savings.createKwikMax["deposit_amount"] = savings.goalformatamount(val);
                        },
                        // onSaved: (val) => backendata["firstname"] = val,
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
                        'Start date',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: getstartedp
                        ),
                      ),
            
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _showDatePicker(context),
                        child: TextFormField( 
                          style: TextStyle(
                            color: darkscaffold 
                          ),
                          enabled: false,
                          validator: RequiredValidator(errorText: 'Start date is required.'),
                          keyboardType: TextInputType.name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: startdate,
                          // onSaved: (val) => backendata["firstname"] = val,
                          onSaved: (val) => savings.createKwikMax["start_date"] = val,
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
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'How long do you want to save for?',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<dynamic>(
                        hint: const Text(
                          "Select Savings Frequency",
                          style: TextStyle(
                            color: Color.fromRGBO(173,175,176, 1),
                            fontWeight: FontWeight.w300,
                            fontSize: 14
                          ),
                        ),
                        value: tranw,
                        icon: const Icon(
                          FontAwesome.angle_down
                        ),
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return 'Option is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        ),
                        items: transwhere.map((dynamic single) {
                          return DropdownMenuItem<dynamic>(
                            value: single,
                            child: Text(
                              single["text"],
                              style: const TextStyle(
                                color: Color.fromRGBO(136, 136, 136, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            tranw = val;
                          });
                          // print(val["text"]);
                          // if (val["value"] == " ") {
                          //   setState(() {
                          //     showother = true;
                          //   });
                          //   return;
                          // }
                          // if (val["value"] != " ") {
                          //   setState(() {
                          //     showother = false;
                          //   });
                          // }
                          savings.createKwikMax["duration"] = val["value"].toString();
                        },
                      ),
                      const SizedBox(height: 20),

                      // Text(
                      //   'Saving Duration',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 12,
                      //     color: getstartedp
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // DropdownButtonFormField<dynamic>(
                      //   hint: const Text(
                      //     "Select Savings Duration",
                      //     style: TextStyle(
                      //       color: Color.fromRGBO(173,175,176, 1),
                      //       fontWeight: FontWeight.w300,
                      //       fontSize: 14
                      //     ),
                      //   ),
                      //   icon: const Icon(
                      //     FontAwesome.angle_down
                      //   ),
                      //   value: tranw,
                      //   isExpanded: true,
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'Option is required';
                      //     }
                      //     return null;
                      //   },
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      //     fillColor:  inputColor,
                      //     border: inputborder,
                      //     focusedBorder: activeinputborder,
                      //     enabledBorder: inputborder,
                      //     focusedErrorBorder:inputborder ,
                      //     errorBorder: errorborder,
                      //     disabledBorder: inputborder,
                      //     errorStyle: const TextStyle(color: Colors.red),
                      //   ),
                      //   items: transwhere.map((dynamic single) {
                      //     return DropdownMenuItem<dynamic>(
                      //       value: single,
                      //       child: Text(
                      //         single["text"],
                      //         style: const TextStyle(
                      //           color: Color.fromRGBO(136, 136, 136, 1),
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 14
                      //         ),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (val) {
                      //     setState(() {
                      //       tranw = val;
                      //     });
                      //     // print(val["text"]);
                      //     // if (val["value"] == " ") {
                      //     //   setState(() {
                      //     //     showother = true;
                      //     //   });
                      //     //   return;
                      //     // }
                      //     // if (val["value"] != " ") {
                      //     //   setState(() {
                      //     //     showother = false;
                      //     //   });
                      //     // }
                      //     // saving.createKwikMax["duration"] = val["value"].toString();
                      //   },
                      // ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        // onTap: () => Get.toNamed("savings/max/confirm"),
                        onTap: () => validate(),
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
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: white
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        FontAwesome5Solid.arrow_right,
                                        color: white,
                                        size: 10,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}