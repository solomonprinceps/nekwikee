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
import 'dart:io' as Io;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/themes/apptheme.dart';

class Employmentinfo extends StatefulWidget {
  const Employmentinfo({Key? key}) : super(key: key);

  @override
  _EmploymentinfoState createState() => _EmploymentinfoState();
}

class _EmploymentinfoState extends State<Employmentinfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SavingController savings = Get.put(SavingController());
  ApplyController applycon = Get.put(ApplyController());

  dynamic tranw;
  dynamic _chosenDateTime;
  List transwhere = [
    {"text": "Male", "value": '30'},
    {"text": "Female", "value": '90'},
  ];
  TextEditingController startdate = TextEditingController();
  TextEditingController numberofyear = TextEditingController();

  TextEditingController monthtly = TextEditingController();
  TextEditingController employmentstatus = TextEditingController();
  TextEditingController nextastname = TextEditingController();

  bool isChecked = false;
  final ImagePicker _picker = ImagePicker();

  // dynamic _dateTime;

  List educationlevel = [
    {"text": "BSc", "value": "Bsc"},
    {"text": "Diploma", "value": "Diploma"},
    {"text": "High School (S.S.C.E)", "value": "High School (S.S.C.E)"},
    {"text": "HND", "value": "HND"},
    {"text": "MBA / MSc", "value": "MBA / MSc"},
    {"text": "Vocational", "value": "Vocational"},
    {"text": "MBBS", "value": "MBBS"},
    {"text": "MPhil / PhD", "value": "MPhil / PhD"},
    {"text": "N.C.E", "value": "N.C.E"},
    {"text": "OND", "value": "OND"},
    {"text": "Others", "value": "Others"},
  ];

  dynamic selectedemployer;
  dynamic employer;
  dynamic educationlev;

  String dateformater(String datestring) {
    if (datestring == '') {
      return '';
    }
    return DateFormat('MMM dd, yyyy')
        .format(DateTime.parse(datestring))
        .toString();
  }

  TextEditingController paydayctontroller = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController documentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController employerconttroller = TextEditingController();
  TextEditingController otheremployerconttroller = TextEditingController();
  TextEditingController namecompany = TextEditingController();
  TextEditingController employmentdetailcontrol = TextEditingController();
  TextEditingController educationalcontroller = TextEditingController();
  TextEditingController otheremployer = TextEditingController();

  dynamic detail;
  bool showerror = false;
  bool imageselected = false;
  List allcomp = [];
  List allbanks = [];
  List banklist = [];
  List emplymentdetails = [
    {"text": "Employed", "value": "Employed"},
    {"text": "Self-employed", "value": "Self-employed"},
    {"text": "Student", "value": "Student"},
    {"text": "Unemployed", "value": "Unemployed"},
  ];

  _showFullModal(context) {
    // print(applycon.companies);
    // print("ssm ${allbanks}");
    showGeneralDialog(
      context: context,
      barrierDismissible: false, // should dialog be dismissed when tapped outside
      barrierLabel: "Select Company", // label for barrier
      transitionDuration: const Duration(milliseconds:  50), // how long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // your widget implementation
        return StatefulBuilder(builder: (context, setState) {
        
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
              icon: Icon(
                Icons.close,
                color: CustomTheme.presntstate ? white: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
              title: Text(
                "Companies",
                style: TextStyle(
                    color: CustomTheme.presntstate ? white : Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 20
                ),
              ),
              elevation: 0.0
            ),
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
                        final allbks = applycon.companies.where((bank) {
                          // return;
                          // print(bank);

                          final bankname = bank["company_name"] != null
                              ? bank["company_name"].toLowerCase()
                              : "";
                          final searchname = value.toLowerCase();
                          return bankname.contains(searchname);
                        }).toList();
                        setState(() {
                          allbanks = allbks;
                        });
                        // print(allbanks);
                      },
                      decoration: InputDecoration(
                        hintText: "Company List",
                        hintStyle: TextStyle(color: CustomTheme.presntstate ? white :  black.withOpacity(0.3), fontSize: 16),
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
                            onTap: () {
                              namecompany.text = allbanks[index]["company_name"];
                              applycon.employerdata["employer_name"] = allbanks[index]["company_id"].toString();
                              namecompany.text = allbanks[index]["company_name"].toString();
                              paydayctontroller.text = allbanks[index]["payday"];
                              if (applycon.employerdata["employer_name"] == "99") {
                                paydayctontroller.text = "";
                              }
                              print('${applycon.employerdata}');
                              Get.back();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: primary))),
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  allbanks[index]["company_name"].toString(),
                                  // "",
                                  style: TextStyle(color: Colors.grey[600]),
                                )),
                          );
                        }),
                  ))
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future getbank() async {
    context.loaderOverlay.show();
    await savings.banklist().then((value) {
      context.loaderOverlay.hide();
      // print(value);
      Get.toNamed("credit/five", arguments: value?["data"]);
    }).catchError((onError) {
      context.loaderOverlay.hide();
      print(onError);
    });
  }

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Number of years',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Sibling',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Spouse',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Parent',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: error),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showDatePicker(ctx) {
    FocusScope.of(context).requestFocus(FocusNode());
    startdate.text = dateformaterY_M_D(DateTime.now().toString());
    setState(() {
      _chosenDateTime = dateformaterY_M_D(DateTime.now().toString());      
    });
    _chosenDateTime = dateformaterY_M_D(DateTime.now().toString());
    savings.createKwikGoal["employment_start_date"] = dateformaterY_M_D(DateTime.now().toString());
  
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
                    // print(val);
                    setState(() {
                      _chosenDateTime = val;
                      // print(_chosenDateTime);
                      startdate.text = dateformaterY_M_D(_chosenDateTime.toString());
                      // print(dateformaterY_M_D(_chosenDateTime.toString()));
                    });
                    savings.createKwikGoal["employment_start_date"] = dateformaterY_M_D(_chosenDateTime.toString());
                  }),
              ),
            ),
            const SizedBox(height: 20),
            // Close the modal
            Column(
              children: [
                CupertinoButton(
                  child: Text(
                    'Select',
                    style: TextStyle(color: white),
                  ),
                  color: primary,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    startdate.text = dateformaterY_M_D(_chosenDateTime.toString());
                    savings.createKwikGoal["employment_start_date"] = dateformaterY_M_D(_chosenDateTime.toString());
                    Navigator.of(ctx).pop();
                  },
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: white),
                  ),
                  color: error,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    startdate.text = "";
                    savings.createKwikGoal["employment_start_date"] = "";
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ));
  }

  employmentWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Employment Status',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Employed',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Unemployed',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: error),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  selectImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path == null) {
      setState(() {
        imageselected = false;
      });
      documentController.text = "";
      applycon.employerdata["id_card"] = "";
      print(applycon.employerdata["id_card"]);
      return;
    }
    applycon.employerdata["id_card"] = image?.path;
    String? imageString = image?.path.toString();
    documentController.text = imageString.toString();
    setState(() {
      imageselected = true;
    });
    print(applycon.employerdata["id_card"]);
    return;
  }

  _showSimpleModalDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            margin: const EdgeInsets.all(10),
            // width: 400.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              image: DecorationImage(
                image: FileImage(Io.File(applycon.employerdata["id_card"])),
                  // image: Image.memory(img),
                fit: BoxFit.cover
              ),
            ),
            height: 300.h,
            // alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    applycon.employerdata["id_card"] = "";
                    documentController.text = '';
                    setState(() {
                      imageselected = false;
                    });
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
  }

  employmmentWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Employment Status',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'), transactions.map<Widget>((item) {
        actions: emplymentdetails.map<CupertinoActionSheetAction>((item) {
          return CupertinoActionSheetAction(
            child: Text(
              item["text"].toString(),
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              // applystate.nextofkindata["next_kin_relationship"] = "Sibling";
              employmentdetailcontrol.text = item["value"];
              Navigator.pop(context);
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: error),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  educationlevelWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Education level',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'), transactions.map<Widget>((item) {
        actions: educationlevel.map<CupertinoActionSheetAction>((item) {
          return CupertinoActionSheetAction(
            child: Text(
              item["text"].toString(),
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              // applystate.nextofkindata["next_kin_relationship"] = "Sibling";
              educationalcontroller.text = item["value"];
              Navigator.pop(context);
            },
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20, color: error),
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
    // print(Get.arguments);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      applycon.employerdata["loan_id"] = Get.arguments;
      // print(applycon.employerdata["loan_id"]);
      getcompanies();
      // allcomp = applycon.companies;
    });

    super.initState();
  }

  getcompanies() async {
    context.loaderOverlay.show();
    applycon.companieslist().then((value) {
      context.loaderOverlay.hide();
      // print(value);
      // print(applycon.companies);
    }).catchError((onError) {
      print(onError);
      context.loaderOverlay.hide();
    });
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // print(applycon.employerdata);
      // print('object');
      employmentApply();
    } else {}
  }

  employmentApply() async {
    context.loaderOverlay.show();
    applycon.applyemployment().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "success") {
        snackbar(message: value["message"], header: "Success", bcolor: success);
        Get.toNamed('credit/five', arguments: Get.arguments);
      }

      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error.", bcolor: error);
        return; 
      }
    }).catchError((onError) {
      context.loaderOverlay.hide();
      print(onError);
      snackbar(message: "Error Occoured", header: "Error.", bcolor: error);
        return; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              const Topbar(),
              Expanded(
                child: Container(
                  padding:  const EdgeInsets.only(left: 33, right: 33, top: 10),
                  width: 100.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Employment Information",
                        style: TextStyle(
                          fontSize: 21,
                          color: CustomTheme.presntstate ? creditwithdark : primary,
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
                              color: CustomTheme.presntstate ? const Color.fromRGBO(130, 134, 157, 1) : primary.withOpacity(0.6),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          const SizedBox(width: 10),
                          
                          Container(
                            height: 6,
                            width: 23,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? const Color.fromRGBO(130, 134, 157, 1) : primary.withOpacity(0.6),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 6,
                            width: 61,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? const Color.fromRGBO(83, 209, 255, 1) : primary,
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 6,
                            width: 23,
                            decoration: BoxDecoration(
                              color: CustomTheme.presntstate ? const Color.fromRGBO(130, 134, 157, 1) : primary.withOpacity(0.6),
                              borderRadius: const BorderRadius.all(Radius.circular(20))
                            ),
                          )
                        ],
                      ),
                      // const SizedBox(height: 25),
                      // Visibility(
                      //   visible: showerror,
                      //   child: Text(
                      //     "** Work Id or Offical email is required",
                      //     style: TextStyle(
                      //       color: error
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SizedBox(
                        width: 100.w,
                        child: Form(
                          key: _formKey,
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                              Text(
                                "Official Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                // validator: MultiValidator([
                                //   RequiredValidator(errorText: "Official email is required."),
                                //   EmailValidator(errorText: "Official email is required.")
                                // ]),
                                
                                validator: EmailValidator(
                                  errorText:  "Official email is required."
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:  AutovalidateMode.onUserInteraction,
                                controller: emailController,
                                onChanged: (val) {
                                  setState(() {
                                    showerror = false;
                                  });
                                },
                                onSaved: (val) {
                                  applycon.employerdata["official_email"] = val;
                                },
                                textInputAction: TextInputAction.done,
                                
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Work ID (Optional)',
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      _showSimpleModalDialog(context);
                                    },
                                    child: Visibility(
                                      visible: imageselected,
                                      child: Text(
                                        'Preview',
                                        style: TextStyle(
                                          color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              InkWell(
                                onTap: () => selectImage(),
                                child: TextFormField(
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: (val) {
                                    if (val == "" && emailController.text == "") {
                                      setState(() {
                                        showerror = true;
                                      });
                                    }
                                    return null;
                                  },
                                    // validator: RequiredValidator(
                                    //     errorText:
                                    //         "Work ID / CAC Document is required."),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: documentController,
                                  onChanged: (val) {
                                    setState(() {
                                      showerror = false;
                                    });
                                  },
                                  onSaved: (val) {
                                    applycon.employerdata["id_card"] = val;
                                  },
                                  textInputAction: TextInputAction.done,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    label: Text(
                                      "Click to select",
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? white : Colors.grey.shade700
                                      ),
                                    ),
                                    
                                  )
                                ),
                              ),
                              const SizedBox(height: 20),
        
                              Text(
                                "Employment Start Date",
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
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: RequiredValidator(errorText:"Employment start date is required."),
                                  keyboardType: TextInputType.phone,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: startdate,
                                  enabled: false,
                                  
                                  // onSaved: (val) => backendata["firstname"] = val, applycon.employerdata["other_employer_name"] = val;
                                  onSaved: (val) =>applycon.employerdata["employment_start_date"] = val,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      FontAwesome5Regular.calendar_alt,
                                      color: darkscaffold,
                                      size: 15,
                                    ),
                                    
                                  )
                                ),
                              ),
        
                              const SizedBox(height: 20),
                              Text(
                                'Name of Employer / Business',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                ),
                              ),
                              const SizedBox(height: 5),
                              // _showFullModal
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    allbanks = applycon.companies;
                                  });
                                  _showFullModal(context);
                                },
                                child: TextFormField(
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: RequiredValidator(errorText: "Employer is required."),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: namecompany,
                                  enabled: false,
                                  onSaved: (val) {
                                    // applycon.employerdata["other_employer_name"] = val;
                                    if (val == "Others") {
                                      applycon.employerdata["other_employer_name"] = '99';
                                    } else {
                                      applycon.employerdata["other_employer_name"]  = val;
                                    }
                                  },
                                  // onSaved: (val) => backendata["firstname"] = val,
                                  // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                  textInputAction: TextInputAction.done,
                                  
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(() => Visibility(
                                visible: applycon.employerdata["employer_name"] ==  '99',
                                child: Text(
                                  "Other Employer Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                  ),
                                ),
                              )),
                              const SizedBox(height: 5),
                              Obx(() => Visibility(
                                visible: applycon.employerdata["employer_name"] == '99',
                                child: TextFormField(
                                  style: TextStyle( 
                                    color:CustomTheme.presntstate ? white : darkscaffold
                                  ),
                                  validator: RequiredValidator(errorText:"Other Employer name is required."),
                                  keyboardType:  TextInputType.emailAddress,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: otheremployer,
                                  onSaved: (val) {
                                    applycon.employerdata["other_employer_name"] = val;
                                  },
                                  textInputAction: TextInputAction.done,
                                  
                                ),
                              )),
                              Obx(() => 
                                Visibility(
                                  visible: applycon.employerdata["employer_name"] == '99',
                                  child: const SizedBox(height: 20)
                                )
                              ),
                              Text(
                                'Pay day',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                ),
                              ),
                              const SizedBox(height: 5),
                              Obx(() => 
                                TextFormField(
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: RequiredValidator(
                                  errorText: 'Pay day is required.'),
                                  enabled: applycon.employerdata["employer_name"] ==  '99' ? true : false,
                                  keyboardType: TextInputType.phone,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: paydayctontroller,
                                  onSaved: (val) {
                                    applycon.employerdata["pay_date"] = val;
                                  },
                                  // onSaved: (val) => backendata["firstname"] = val,
                                  // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),  
                              const SizedBox(height: 20),

                              Text(
                                'Monthly Salary',
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
                                validator: RequiredValidator(
                                  errorText: 'Monthly salary is required.'
                                ),
                                keyboardType: TextInputType.phone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: monthtly,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(
                                    locale: 'en',
                                    decimalDigits: 0,
                                    symbol: '₦',
                                  )
                                ],
        
                                // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                onChanged: (val) {
                                  applycon.formatamount(val);
                                },
                                textInputAction: TextInputAction.done,
                              ),
        
                              const SizedBox(height: 20),
                              Text(
                                'Employment Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () => employmmentWidget(),
                                child: TextFormField(
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: RequiredValidator(
                                    errorText: 'Employment details is required.'
                                  ),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: employmentdetailcontrol,
                                  enabled: false,
                                  // onSaved: (val) => backendata["firstname"] = val,
                                  onSaved: (val) => applycon.employerdata["employment_type"] = val,
                                  textInputAction: TextInputAction.done,
                                  
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Educational Level',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                ),
                              ),
                              const SizedBox(height: 5),
                              GestureDetector(
                                onTap: () => educationlevelWidget(),
                                child: TextFormField(
                                  style: TextStyle(color: CustomTheme.presntstate ? white : darkscaffold),
                                  validator: RequiredValidator(
                                    errorText: 'Educational level is required.'
                                  ),
                                  keyboardType: TextInputType.name,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: educationalcontroller,
                                  enabled: false,
                                  onSaved: (val) => applycon.employerdata["education_level"] = val,
                                  textInputAction: TextInputAction.done,
                                ),
                              ),
        
                              const SizedBox(height: 40)
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    // getbank();
                    // print(applycon.employerdata);
                    validate();
                  },
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
              
            ],
          ),
        ),
      ),
    );
  }
}


class Topbar extends StatelessWidget {
  const Topbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 25.h),
        Container(
          height: 20.h,
          width: 100.w,
          // child: Text("fiosa"),  
          decoration: BoxDecoration(
            color: primary,
            image: const DecorationImage(image: AssetImage("assets/image/credithome.png"), 
              fit: BoxFit.cover
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
    );
  }
}