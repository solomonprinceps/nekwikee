import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Employmentbank extends StatefulWidget {
  const Employmentbank({ Key? key }) : super(key: key);

  @override
  _EmploymentbankState createState() => _EmploymentbankState();
}

class _EmploymentbankState extends State<Employmentbank> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  dynamic tranw;
  dynamic _chosenDateTime;
  SavingController saving  = Get.put(SavingController());
  ApplyController applycon = Get.put(ApplyController());
  List transwhere = [
    {"text": "Male", "value": '30'},
    {"text": "Female", "value": '90'},
  ];
  TextEditingController bvn = TextEditingController();
  TextEditingController accountnumber = TextEditingController();

  TextEditingController monthtly = TextEditingController();
  TextEditingController employmentstatus = TextEditingController();
  TextEditingController nextastname = TextEditingController();
  TextEditingController bankeditor = TextEditingController();
  dynamic banklist; 
  dynamic allbanks;
  dynamic loanid;

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
              'Sibling',
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
              'Spouse',
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
              'Parent',
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
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        loanid = Get.arguments;
      });
      applycon.bankdata["loan_id"] = Get.arguments;
      getbanklist();
    });
    
    super.initState();
  }


  Future getbanklist() async {
    context.loaderOverlay.show();
    await saving.banklist().then((value) {
      context.loaderOverlay.hide();
      setState(() {
        banklist = value["data"];
      });
      // print(banklist);
    }).catchError((err) {
      context.loaderOverlay.hide();
      // print(err);
    });
  }

  _showFullModal(context) {
    setState(() {
      allbanks = banklist;
    });
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Bank", // label for barrier
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
                title: const Text(
                  "Bank",
                  style: TextStyle(color:  Colors.black87, fontFamily: 'Overpass', fontSize: 20),
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
                            // return;
                            print(bank);

                            final bankname = bank["name"] != null  ? bank["name"].toLowerCase()  : "";
                            final searchname = value.toLowerCase();
                            return bankname.contains(searchname);
                          }).toList();
                          setState(() {
                            allbanks = allbks;
                          });
                        // print(allbanks);
                      },
                        // onChanged: (value) {
                        //   // print(value);
                        //   // applycon.banks.sort((a,b) =>value.compareTo(b["name"]));
                        //   final allbks = banklist.where((bank) {
                        //     print(bank);
                        //     final bankname = bank["name"].toLowerCase();
                        //     final searchname = value.toLowerCase();
                        //     return bankname.contains(searchname);
                        //   }).toList();
                        //   print(allbks);
                        //   setState(() {
                        //     allbanks = allbks;
                        //   });
                        // },
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
                              color: Colors.grey.shade400,
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
                                bankeditor.text = allbanks[index]["name"];
                                applycon.bankdata["income_account_bankcode"] = allbanks[index]["code"];
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
                                  allbanks[index]["name"],
                                  style: TextStyle(
                                    color: Colors.grey.shade400
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


  void validate() {
    applycon.bankdata["loan_id"] = Get.arguments;
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // print(applycon.bankdata);
      bankApplydata();
      // Get.toNamed('dashboard/apply/bankinfo');
    } else {
      snackbar(message: "A error in form validation occcoured.", header: "Validation error.",  bcolor: error);
      
    }
  } 

  bankApplydata() async {
    context.loaderOverlay.show();
    applycon.applybank().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "success") {
        Get.toNamed('credit/preview', arguments: Get.arguments);
        snackbar(message: value["message"], header: "Success", bcolor: success);
        return;
        // Fluttertoast.showToast(
        //   msg: "Successfully submited.",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.green.shade400,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );  
      }

      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
        return;
      }
      
    }).catchError((onError) {
      context.loaderOverlay.hide();
      snackbar(message: "Error occoured", header: "error", bcolor: error);
      context.loaderOverlay.hide();
    });
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
                    padding: const EdgeInsets.only(left: 33, right: 33, top: 28),
                    width: 100.w,
                    color: dashboardcard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bank information",
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
                                    "Bank account number",
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
                                      RequiredValidator(errorText: "Bank account number is required."),
                                      MinLengthValidator(10, errorText: "Bank account number should be more than 10 digits.")
                                    ]),
                                    keyboardType: TextInputType.phone,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: bvn,
                                    // enabled: false,
                                    onSaved: (val) => applycon.bankdata["income_account_number"] = val,
                                    // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      
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
                                    "Bank",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: getstartedp
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () => _showFullModal(context),
                                    child: TextFormField( 
                                      style: TextStyle(
                                        color: darkscaffold 
                                      ),
                                      validator: RequiredValidator(errorText: "Account number is required."),
                                      // keyboardType: TextInputType.phone,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: bankeditor,
                                      enabled: false,
                                      // onSaved: (val) => applycon.bankdata["income_account_number"] = val,
                                      // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        
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
            Align( 
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                // onTap: () => Get.toNamed("credit/preview"),
                onTap: () =>  validate(),
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