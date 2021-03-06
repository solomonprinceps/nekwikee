import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class CreateGoals extends StatefulWidget {
  const CreateGoals({ Key? key }) : super(key: key);

  @override
  _CreateGoalsState createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SavingController saving = Get.put(SavingController());
  AuthController auth = Get.put(AuthController());
  dynamic tranw;
  dynamic _chosenDateTime;
  dynamic _matuirydate;
  List transwhere = [
    {"text": "30 Days", "value": '30'},
    {"text": "90 Days", "value": '90'},
    {"text": "180 Days", "value": '180'},
    {"text": "270 Days", "value": '270'},
    {"text": "365 Days", "value": '365'},
    {"text": "730 Days", "value": '730'},
    {"text": "Others", "value": " "}
  ];
  bool loading = false;
  List cards = [
    {"last4": "-1", "bank": "KwikLite"}
  ];

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController goalsdate = TextEditingController(); 
  TextEditingController prefferedamount = TextEditingController();
  TextEditingController maturitydate = TextEditingController();
  TextEditingController savingreason = TextEditingController();
  dynamic selectedfreq;
  dynamic selectedsource;
  List<String> reasons = [
    "Rent/Accomodation",
    "Vacation/Travel",
    "Car/Vehicle",
    "Fees/Debt",
    "Education",
    "Starting/Growing Business",
    "Event e.g. weddings, anniversary etc",
    "Birthday",
    "Gadgets",
    "Investment",
    "Unforeseen circumstances e.g health",
    "Challenge / Contents",
    "No Reason",
    "Others"
  ];
  dynamic allbanks;
  dynamic banklist;
  List freqs = [
    {"text": "Daily", "value": "1"},
    {"text": "Weekly", "value": "2"},
    {"text": "Monthly", "value": "3"},
    {"text": "Anytime", "value": "4"},
  ];


  

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // print(saving.createKwikGoal);
      submitGoals();
    //  login();
    } else {
    }
  }  

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    FocusScope.of(context).unfocus();
    goalsdate.text = dateformaterY_M_D(DateTime.now().toString());
    saving.createKwikGoal["start_date"] = dateformaterY_M_D(DateTime.now().toString());
    showCupertinoModalPopup(
      context: ctx,
      barrierDismissible: true,
      builder: (_) => Container(
        height: 350,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            const SizedBox(height: 70),
            // const Text("start date"),
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
                      // print(dateformaterY_M_D(_chosenDateTime.toString()));
                      goalsdate.text = dateformaterY_M_D(_chosenDateTime.toString());
                      saving.createKwikGoal["start_date"] = dateformaterY_M_D(_chosenDateTime.toString());
                    });
                  }
                ),
              ),
            ),
            const SizedBox(height: 15),
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
                    goalsdate.text = '';
                    saving.createKwikGoal["start_date"] = '';
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  void _maturityDatePicker(ctx) {
    FocusScope.of(context).unfocus();
    maturitydate.text = dateformaterY_M_D(DateTime.now().toString());
    saving.createKwikGoal["maturity_date"] = dateformaterY_M_D(DateTime.now().toString());
    showCupertinoModalPopup(
      context: ctx,
      barrierDismissible: false,
      builder: (_) => Container(
        height: 350,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 140,
                child: CupertinoDatePicker(
                  minimumDate: DateTime.now(),
                  initialDateTime: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (val) {
                    // print(val);
                    setState(() {
                      _matuirydate = val;
                      // print(dateformaterY_M_D(_chosenDateTime.toString()));
                    });
                    maturitydate.text = dateformaterY_M_D(_matuirydate.toString());
                    saving.createKwikGoal["maturity_date"] = dateformaterY_M_D(_matuirydate.toString());
                  }
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Close the modal
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                      maturitydate.text = '';
                      saving.createKwikGoal["maturity_date"] = '';
                      Navigator.of(ctx).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

   reasonshowFullModal(context) {
    FocusScope.of(context).unfocus();
    setState(() {
      allbanks = banklist;
    });
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Reasons", // label for barrier
      transitionDuration: const Duration(milliseconds: 50), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) { // your widget implementation 
        return StatefulBuilder(
          builder:  (context, setState) {
            final String themestate = MediaQuery.of(context).platformBrightness == Brightness.light ? "light" : "dark";
            return Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: black,
                  ), 
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
                title: Text(
                  "Reason",
                  style: TextStyle(color: themestate == 'dark' ? white : Colors.black87, fontFamily: 'Overpass', fontSize: 20),
                ),
                elevation: 0.0
              ),
              backgroundColor: white,
              body: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xfff8f8f8),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(136, 136, 136, 1),
                        ),
                        onChanged: (value) {
                          final allbks = banklist.where((bank) {
                            final bankname = bank.toLowerCase();
                            final searchname = value.toLowerCase();
                            return bankname.contains(searchname);
                          }).toList();
                          setState(() {
                            allbanks = allbks;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Sort Bank",
                          hintStyle: TextStyle(
                            color: black.withOpacity(0.3),
                            fontSize: 16
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              FontAwesome5Solid.piggy_bank,
                              color: Colors.grey[300],
                              size: 15,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                          fillColor: white,
                          border: inputborder,
                          focusedBorder: activeinputborder,
                          enabledBorder: activeinputborder,
                          focusedErrorBorder: errorborder,
                          errorBorder: errorborder,
                          disabledBorder: inputborder,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: ListView.builder(
                          itemCount: allbanks.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return InkWell(
                              onTap: (){ 
                                savingreason.text = allbanks[index];
                                saving.createKwikGoal["savings_category"] = allbanks[index];
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: primary
                                    )
                                  )
                                ),
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  allbanks[index],
                                  style: TextStyle(
                                    color: Colors.grey[600]
                                  ),
                                )
                              ),
                            );
                          }
                        ),
                      )
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
    );
  }

  addcards(List dcards) {
    // print("dcards $dcards");
    dcards.forEach((element) { 
      setState(() {
        cards.add(element);        
      });

    });
    setState(() {
      loading = true;
    });
  }


  submitGoals() async {
    FocusScope.of(context).requestFocus(FocusNode());
    // print(saving.createKwikGoal);
    // return;
    context.loaderOverlay.show();
    await saving.makeGoal().then((value) {
      context.loaderOverlay.hide();
      print(value);   
      if (value["status"] == "success") {
        snackbar(message: value?["message"], header: "Success", bcolor: success);
        Get.offAndToNamed('home', arguments: 0);
      }
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "Error", bcolor: error);
        return;
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      // print(err);
      snackbar(message: "An Error Occoured", header: "Error", bcolor: error);
      return;
    });
  }

  @override
  void initState() {
    saving.createKwikGoal["type"] = "2";
    print(auth.userdata["card_authorizations"]);
    if (auth.userdata["card_authorizations"] != null) {
      addcards(auth.userdata["card_authorizations"]);
    }
    super.initState();
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
              color: CustomTheme.presntstate ? white : black,
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
        elevation: 0,
      ),
      body: Column(
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 175, 239, 1)
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
                        "Goals",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w400,
                          color: primary
                        ),
                      ),
                      Text(
                        "Acheive your target, save towards a particular goal. 12% per annum",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? white : HexColor("#353130")
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
                color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F8F8F8"),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Form(
                key: _formKey,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      // Text("data"),
                      Text(
                        'What are you saving for',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField( 
                        style: TextStyle(
                          color: CustomTheme.presntstate ? white : darkscaffold 
                        ),
                        validator: RequiredValidator(errorText: 'Title is required.'),
                        keyboardType: TextInputType.name,
                        controller: title,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onSaved: (val) => saving.createKwikGoal["savings_name"]  = val,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                            
                      Text(
                        'Target amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                            
                      const SizedBox(height: 5),
                      TextFormField( 
                        style: TextStyle(
                          color: CustomTheme.presntstate ? white : darkscaffold,
                          fontFamily: GoogleFonts.roboto().toString(),
                        ),
                        validator: RequiredValidator(errorText: 'Target amount is required.'),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: amount,
                        onSaved: (val) => saving.createKwikGoal["target_amount"] = saving.goalformatamount(val),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                          locale: 'en',
                          decimalDigits: 0,
                          symbol: '???',
                        )],
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                            
                      Text(
                        'Preffered saving amount',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                            
                      const SizedBox(height: 5),
                      TextFormField( 
                        style: TextStyle(
                          color: CustomTheme.presntstate ? white : darkscaffold,
                          fontFamily: GoogleFonts.roboto().toString(),
                        ),
                        validator: RequiredValidator(errorText: 'Preffered saving amount is required.'),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: prefferedamount,
                        onSaved: (val) => saving.createKwikGoal["preffered_saving_amount"] = saving.goalformatamount(val),
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            locale: 'en',
                            decimalDigits: 0,
                            symbol: '???',
                          )
                        ],
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      // Text(
                      //   'Saving Category',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 12,
                      //     color: getstartedp
                      //   ),
                      // ),
                            
                      // const SizedBox(height: 5),
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {
                      //       banklist = reasons;
                      //       allbanks = reasons;
                      //     });
                          
                          
                      //     _reasonshowFullModal(context);
                      //   }, 
                      //   child: TextFormField( 
                      //     style: TextStyle(
                      //       color: darkscaffold 
                      //     ),
                      //     enabled: false,
                      //     validator: RequiredValidator(errorText: 'Saving category is required.'),
                      //     keyboardType: TextInputType.number,
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     controller: savingreason,
                      //     onSaved: (val) => saving.createKwikGoal["savings_category"] = val,
                          
                      //     textInputAction: TextInputAction.next,
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                      //       fillColor:  inputColor,
                      //       border: inputborder,
                      //       focusedBorder: activeinputborder,
                      //       enabledBorder: inputborder,
                      //       focusedErrorBorder:inputborder ,
                      //       errorBorder: errorborder,
                      //       disabledBorder: inputborder,
                      //       errorStyle: const TextStyle(color: Colors.red),
                      //     )
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // Text(
                      //   'How long do you want to save for?',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w400,
                      //     fontSize: 12,
                      //     color: getstartedp
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      // DropdownButtonFormField<dynamic>(
                      //   hint: const Text(
                      //     "Select Savings Frequency",
                      //     style: TextStyle(
                      //       color: Color.fromRGBO(173,175,176, 1),
                      //       fontWeight: FontWeight.w300,
                      //       fontSize: 14
                      //     ),
                      //   ),
                      //   value: tranw,
                      //   icon: const Icon(
                      //     FontAwesome.angle_down
                      //   ),
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
                      //     saving.createKwikGoal["saving_frequency"] = val["value"].toString();
                      //   },
                      // ),
                
                
                      Text(
                        'How often do you want to save',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<dynamic>(
                        hint: Text(
                          "Select an option",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white :const Color.fromRGBO(136, 136, 136, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                          ),
                        ),
                        value: selectedfreq,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return 'Option is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: freqs.map((dynamic single) {
                          return DropdownMenuItem<dynamic>(
                            value: single,
                            child: Text(
                              single["text"],
                              style: TextStyle(
                                color: CustomTheme.presntstate ? white : darkscaffold,
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedfreq = val;
                          });
                          // print(val["text"]);
                          saving.createKwikGoal["saving_frequency"] = val["value"].toString();
                        },
                      ),
                
                      const SizedBox(height: 20),
                      Text(
                        'Start Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _showDatePicker(context),
                        child: TextFormField( 
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : darkscaffold 
                          ),
                          validator: RequiredValidator(errorText: 'Start date is required.'),
                          keyboardType: TextInputType.name,
                          controller: goalsdate,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // onSaved: (val) => backendata["firstname"] = val,
                          enabled: false,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Maturity Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _maturityDatePicker(context),
                        child: TextFormField( 
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : darkscaffold 
                          ),
                          validator: RequiredValidator(errorText: 'Maturity date is required.'),
                          keyboardType: TextInputType.name,
                          controller: maturitydate,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // onSaved: (val) => backendata["firstname"] = val,
                          enabled: false,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Savings Source',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp
                        ),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<dynamic>(
                        hint: Text(
                          "Select an option",
                          style: TextStyle(
                            color: CustomTheme.presntstate ? white : const Color.fromRGBO(136, 136, 136, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                          ),
                        ),
                        value: selectedsource,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null) {
                            return 'Option is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        items: cards.map((dynamic single) {
                          return DropdownMenuItem<dynamic>(
                            value: single,
                            child: Text(
                              single["last4"] != "-1" ? 'Card - '+single["bank"] : single["bank"],
                              style: TextStyle(
                                color: CustomTheme.presntstate ? white : const Color.fromRGBO(136, 136, 136, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                              selectedsource = val;
                            });
                          // print(val["text"]);
                          saving.createKwikGoal["savings_source"] = val["last4"].toString();
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        // onTap: () => print(saving.createKwikGoal["savings_source"]),
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
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}