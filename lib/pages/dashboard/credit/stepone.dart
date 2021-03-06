import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/themes/apptheme.dart';

class Creditfirst extends StatefulWidget {
  const Creditfirst({Key? key}) : super(key: key);

  @override
  _CreditfirstState createState() => _CreditfirstState();
}

class _CreditfirstState extends State<Creditfirst> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApplyController applystate = Get.put(ApplyController());
  AuthController auth = Get.put(AuthController());
  dynamic tranw;
  List transwhere = [
    {"text": "Male", "value": '30'},
    {"text": "Female", "value": '90'},
  ];
  dynamic _chosenDateTime;
  TextEditingController startdate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController numberofyear = TextEditingController();
  TextEditingController marital = TextEditingController();
  CustomTheme customTheme = CustomTheme();

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
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
                              startdate.text =
                                  dateformaterY_M_D(_chosenDateTime.toString());
                              // savings.createKwikMax["start_date"] = dateformaterY_M_D(_chosenDateTime.toString());
                              // print(dateformaterY_M_D(_chosenDateTime.toString()));
                            });
                          }),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Close the modal
                  CupertinoButton(
                    child: Text(
                      'Select',
                      style: TextStyle(color: white),
                    ),
                    color: primary,
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Marital Status',
          style: TextStyle(fontSize: 20, color: primary),
        ),
        // message: const Text('Select your marital status below'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: Text(
              'Single',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              applystate.personalinfo["marital_status"] = '1';
              marital.text = "Single";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Married',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              applystate.personalinfo["marital_status"] = '2';
              marital.text = "Married";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Divorced',
              style: TextStyle(fontSize: 20, color: CustomTheme.presntstate ? white : black),
            ),
            onPressed: () {
              applystate.personalinfo["marital_status"] = '3';
              marital.text = "Divorced";
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

  @override
  void initState() {
    // print(Get.arguments);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      applystate.personalinfo["dob"] = auth.userdata["dob"];
      applystate.personalinfo["loan_id"] = Get.arguments;
    });
    super.initState();
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      // register();
      personalinfoApply();
    } else {
      snackbar(message: "A error in form validation occcoured.", header: "Error", bcolor: error);
      
      // print("not validated");
    }
  } 

  personalinfoApply() async {
    // print(applystate.personalinfo);
    context.loaderOverlay.show();
    applystate.applypersonalinfo().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "success") {
        Get.toNamed('credit/three', arguments: applystate.personalinfo["loan_id"]);   
      }

      if (value["status"] == "error") {
        snackbar(message:  value?["message"], header: "Error", bcolor: error);
        return;
      }
      
    }).catchError((onError) {
      print(onError);
      snackbar(message: "An Error Occoured", header: "Error", bcolor: error);
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.presntstate ? applydark : dashboardcard,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              const Topbar(),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 33, right: 33),
                      width: 100.w,
                      // height: double.infinity,
                      // color: CustomTheme.presntstate ? applydark : dashboardcard,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personal Information",
                            style: TextStyle(
                              fontSize: 21,
                              color: CustomTheme.presntstate ? creditwithdark : primary,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
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
                              ),
                              const SizedBox(width: 10),
                              // Container(
                              //   height: 6,
                              //   width: 23,
                              //   decoration: BoxDecoration(
                              //       color: primary.withOpacity(0.6),
                              //       borderRadius: const BorderRadius.all(
                              //           Radius.circular(20))),
                              // ),
                              // const SizedBox(width: 10),
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
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 101,
                            width: 100.w,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 16, bottom: 10),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(145, 216, 247, 0.1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "FULL NAME ",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 9,
                                      color: CustomTheme.presntstate ? const Color.fromRGBO(203, 209, 216, 1) : const Color.fromRGBO(53, 49, 48, 1).withOpacity(0.5),
                                      fontWeight: FontWeight.w500
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: '(SURNAME, FIRST NAME)',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          color: CustomTheme.presntstate ? const Color.fromRGBO(203, 209, 216, 1).withOpacity(0.5) : const Color.fromRGBO(53, 49, 48, 1).withOpacity(0.5),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(() => Text(
                                  "${auth.userdata['lastname']} ${auth.userdata['firstname']}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color:CustomTheme.presntstate ? const Color.fromRGBO(203, 209, 216, 1) : primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                  ),
                                )),
                                const SizedBox(height: 10),
                                Text(
                                  "EMAIL ADDRESS",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: CustomTheme.presntstate ? const Color.fromRGBO(203, 209, 216, 1).withOpacity(0.5) : const Color.fromRGBO(53, 49, 48, 1).withOpacity(0.5),
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Obx(() => Text(
                                 "${auth.userdata['email']}",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color:CustomTheme.presntstate ? const Color.fromRGBO(203, 209, 216, 1) : primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                  ),
                                )),
                              ],
                            ),
                          ),
                          const SizedBox(height: 7),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     RichText(
                          //       text: TextSpan(
                          //         text: "Want to Edit; Go to ",
                          //         style: TextStyle(
                          //           overflow: TextOverflow.ellipsis,
                          //           fontSize: 9,
                          //           color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                          //           fontWeight: FontWeight.w500
                          //         ),
                          //         children: <TextSpan>[
                          //           TextSpan(
                          //             text: 'Settings',
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.w700,
                          //               color: CustomTheme.presntstate ? creditwithdark : primary 
                          //             )
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 100.w,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                        
                                  Text(
                                    'Marital Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                    ),
                                  ),
                        
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () => shoWidget(),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: CustomTheme.presntstate ? white : darkscaffold,
                                      ),
                                      enabled: false,
                                      validator: RequiredValidator(errorText:'Marital Status required.'),
                                      keyboardType: TextInputType.name,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: marital,
                                      // onSaved: (val) => backendata["firstname"] = val,
                                      // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Select an option",
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color:  CustomTheme.presntstate ? white : const Color.fromRGBO(  53, 49, 48, 0.73).withOpacity(0.5),
                                          fontWeight: FontWeight.w400
                                        ),
                                        suffix: Icon(
                                          FontAwesome.angle_down,
                                          color: CustomTheme.presntstate ? white : primary,
                                          // size: 10,
                                        ),
                                      )
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Current Residential Address', 
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : darkscaffold,
                                    ),
                                    // enabled: false,
                                    validator: RequiredValidator(
                                      errorText:  'Current residential is required.'
                                    ),
                                    keyboardType: TextInputType.name,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    maxLines: 4,
                                    controller: address,
                                    onSaved: (val) => applystate.personalinfo["address"] = val,
                                    // onSaved: (val) => backendata["firstname"] = val,
                                    // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                    textInputAction: TextInputAction.next,
                                    
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Number of  Years in above address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextFormField(
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : darkscaffold,
                                    ),
                                    validator: RequiredValidator( errorText: 'Number of years is required.'),
                                    keyboardType: TextInputType.number,
                                    autovalidateMode:  AutovalidateMode.onUserInteraction,
                                    controller: numberofyear,
                                    // onSaved: (val) => backendata["firstname"] = val,
                                    // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                    onSaved: (val) {
                                      applystate.personalinfo["no_of_years_in_address"] = val;
                                    },
                                    textInputAction: TextInputAction.done,
                                   
                                  ),
                                  // const SizedBox(height: 3),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: InkWell(
                  // onTap: () => Get.toNamed("credit/second"), applystate.personalinfo
                  onTap: () => validate(),
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
    return Container(
      color: CustomTheme.presntstate ? applydark : dashboardcard,
      child: Stack(
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
            child: InkWell(
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
    );
  }
}