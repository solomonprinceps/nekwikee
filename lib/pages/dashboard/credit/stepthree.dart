import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/themes/apptheme.dart';


class Nextofkin extends StatefulWidget {
  const Nextofkin({ Key? key }) : super(key: key);

  @override
  _NextofkinState createState() => _NextofkinState();
}

class _NextofkinState extends State<Nextofkin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CustomTheme customTheme = CustomTheme();
  dynamic tranw;
  List transwhere = [
    {"text": "Male", "value": '30'},
    {"text": "Female", "value": '90'},
  ];
  ApplyController applystate = Get.put(ApplyController());
  AuthController auth = Get.put(AuthController());

  TextEditingController startdate = TextEditingController();
  TextEditingController numberofyear = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController nextfirstname = TextEditingController();
  TextEditingController nextastname = TextEditingController();
  TextEditingController nextofaddreess = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController namecompany = TextEditingController();
  

  shoWidget() {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Relationship',
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
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              applystate.nextofkindata["next_kin_relationship"] = "Sibling";
              relationship.text = "Sibling";
              Navigator.pop(context);
            },
          ),
          
          CupertinoActionSheetAction(
            child: Text(
              'Spouse',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              applystate.nextofkindata["next_kin_relationship"] = "Spouse";
              relationship.text = "Spouse";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Parent',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              applystate.nextofkindata["next_kin_relationship"] = "Parent";
              relationship.text = "Parent";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Colleague',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              applystate.nextofkindata["next_kin_relationship"] = "Colleague";
              relationship.text = "Colleague";
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Neighbour',
              style: TextStyle(
                fontSize: 20,
                color: CustomTheme.presntstate ? white :  black
              ),
            ),
            onPressed: () {
              applystate.nextofkindata["next_kin_relationship"] = "Neighbour";
              relationship.text = "Neighbour";
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

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();

      nextofkinApply();
    } else {
      // print("not validated");
      snackbar(message:"A error in form validation occcoured.", header:  "Error.", bcolor: error);
      
    }
  } 

  nextofkinApply() async {
    context.loaderOverlay.show();
    applystate.applynexofkin().then((value) {
      context.loaderOverlay.hide();
      if (value["status"] == "success") {
        // print(value);
        Get.toNamed('credit/four', arguments: applystate.personalinfo["loan_id"]); 
        // Get.toNamed('dashboard/apply/employmentinfo', arguments: Get.arguments);  
      }

      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
        
      }
      
    }).catchError((onError) {
      // print(onError);
      snackbar(message: "error occoured.", header:  "Error.", bcolor: error);
      context.loaderOverlay.hide();
    });
  }

   @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      applystate.nextofkindata["loan_id"] = Get.arguments;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: ,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Column(
            children: [
              const Topbar(),
               Expanded(
                 child: Container(
                   padding: const EdgeInsets.only(left: 33, right: 33),
                   width: 100.w,
                   
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(
                         "Next of Kin Information",
                         style: TextStyle(
                           fontSize: 21,
                           color: CustomTheme.presntstate ? creditwithdark : primary,
                           fontWeight: FontWeight.w400
                         ),
                       ),
                       const SizedBox(height: 20),
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
                              width: 61,
                              decoration: BoxDecoration(
                                color: CustomTheme.presntstate ? const Color.fromRGBO(83, 209, 255, 1) : primary,
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
                       const SizedBox(height: 10),
                       Expanded(
                         child: SizedBox(
                           width: 100.w,
                           child: Form(
                             key: _formKey,
                             child: ListView(
                              //  crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   "Next of Kin's First Name",
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12,
                                     color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                                 TextFormField( 
                                   style: TextStyle(
                                     color: CustomTheme.presntstate ? whitescaffold : darkscaffold 
                                   ),
                                   validator: RequiredValidator(errorText: "Next of kin's first name is required."),
                                   keyboardType: TextInputType.name,
                                   autovalidateMode: AutovalidateMode.onUserInteraction,
                                   controller: nextfirstname,
                                   // onSaved: (val) => backendata["firstname"] = val,
                                   onSaved: (val) => applystate.nextofkindata["next_kin_firstname"] = val,
                                   textInputAction: TextInputAction.next,
                                   
                                 ),
                                 const SizedBox(height: 20),
                                 
                                 Text(
                                   "Next of Kin's Last Name",
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12,
                                     color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                                 TextFormField( 
                                   style: TextStyle(
                                     color: CustomTheme.presntstate ? whitescaffold : darkscaffold 
                                   ),
                                   validator: RequiredValidator(errorText: "Next of kin's last name is required."),
                                   keyboardType: TextInputType.name,
                                   autovalidateMode: AutovalidateMode.onUserInteraction,
                                   controller: nextastname,
                                   // onSaved: (val) => backendata["firstname"] = val,
                                   onSaved: (val) => applystate.nextofkindata["next_kin_lastname"] = val,
                                   textInputAction: TextInputAction.next,
                                   
                                 ),
                                         
                                 const SizedBox(height: 20),
                                 Text(
                                   'Relationship',
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12,
                                     color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                                 GestureDetector(
                                   onTap: () {
                                     FocusScope.of(context).requestFocus(FocusNode());
                                     shoWidget();
                                   } ,
                                   child: TextFormField( 
                                     style: TextStyle(
                                       color: CustomTheme.presntstate ? whitescaffold : darkscaffold 
                                     ),
                                     enabled: false,
                                     validator: RequiredValidator(errorText: 'Relationship is required.'),
                                     keyboardType: TextInputType.name,
                                     autovalidateMode: AutovalidateMode.onUserInteraction,
                                     controller: relationship,
                                     // onSaved: (val) => backendata["firstname"] = val,
                                     // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                     textInputAction: TextInputAction.next,
                                     decoration: InputDecoration(
                                       hintText: "Select an option",
                                       
                                       hintStyle: TextStyle(
                                         fontSize: 15,
                                         color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 0.73).withOpacity(0.5),
                                         fontWeight: FontWeight.w400
                                       ),
                                       suffixIconColor: primary,
                                       suffix:const Icon(
                                         FontAwesome.angle_down
                                       ),
                                       
                                     )
                                   ),
                                 ),
                                 const SizedBox(height: 20),
                                 Text(
                                   'Phone Number',
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12,
                                     color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                                 TextFormField( 
                                   style: TextStyle(
                                     color: CustomTheme.presntstate ? whitescaffold : darkscaffold 
                                   ),
                                   validator: MultiValidator([
                                     RequiredValidator(errorText: 'Phone number is required.'),
                                     MinLengthValidator(11, errorText: "11 characters required.")
                                   ]),
                                   keyboardType: TextInputType.phone,
                                   autovalidateMode: AutovalidateMode.onUserInteraction,
                                   controller: phone,
                                   // onSaved: (val) => backendata["firstname"] = val,
                                   onSaved: (val) => applystate.nextofkindata["next_kin_telephone"] = val,
                                   // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                   textInputAction: TextInputAction.next,
                                  
                                 ),
                                 const SizedBox(height: 20),
                                 Text(
                                   'Address',
                                   style: TextStyle(
                                     fontWeight: FontWeight.w400,
                                     fontSize: 12,
                                     color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                                   ),
                                 ),
                                 const SizedBox(height: 5),
                                 TextFormField( 
                                   style: TextStyle(
                                     color: CustomTheme.presntstate ? whitescaffold : darkscaffold 
                                   ),
                                   validator: RequiredValidator(errorText: 'Next of kin adrress is required.'),
                                   keyboardType: TextInputType.streetAddress,
                                   autovalidateMode: AutovalidateMode.onUserInteraction,
                                   controller: nextofaddreess,
                                   maxLines: 4,
                                   onSaved: (val) => applystate.nextofkindata["next_kin_address"] = val,
                                   // onSaved: (val) => backendata["firstname"] = val,
                                   // onSaved: (val) => savings.createKwikMax["start_date"] = val,
                                   textInputAction: TextInputAction.done,
                                   
                                 ),
                                const SizedBox(height: 70)
                                 
                                 
                               ],
                             ),
                           ),
                         ),
                       )
                
                      
                       
                     ],
                   ),
                 ),
               ),
              Align( 
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: [
                    GestureDetector(
                      // onTap: () => Get.toNamed("credit/four"),
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