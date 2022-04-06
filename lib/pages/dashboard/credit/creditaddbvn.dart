import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/themes/apptheme.dart';


class Creditbvn extends StatefulWidget {
  const Creditbvn({ Key? key }) : super(key: key);

  @override
  _CreditbvnState createState() => _CreditbvnState();
}

class _CreditbvnState extends State<Creditbvn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApplyController  applystate =  Get.put(ApplyController());
  AuthController  auth =  Get.put(AuthController());
  CustomTheme customTheme = CustomTheme();
  int? bvnfrom;

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      submitbvn();
    } else {
      // print("not validated");
      snackbar(message: "A error in form validation occcoured.", header: "Validation error.", bcolor: error);
      
    }
  }  

  startnow() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    applystate.startapplication().then((value) {
      context.loaderOverlay.hide();
      // print('checker ${value} ');
      if (value["status"] == "success") {
        auth.getusers();
        // Get.toNamed('dashboard/apply/camera', arguments: value["loan_id"]); credit/takeselfie
        Get.toNamed('credit/takeselfie', arguments: value["loan_id"]);
      }
      if (value["bvn"] == 0) {
        snackbar(message: value["message"], header:  "Successful.", bcolor: success);
        Get.offAndToNamed("credit/addbvn", arguments: 1);
        return;
      }
      if (value["status"] == "error" ) {
        snackbar(message: value["message"], header:  "Error.", bcolor: error);
      }
    }).catchError((onError) {
      // print(onError);
      context.loaderOverlay.hide();
    });
  }  

  submitbvn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    await applystate.addbvnapplication().then((value) {
      context.loaderOverlay.hide();
      if (value["status"] == "success") {
        snackbar(message:  value["message"], header: "Success", bcolor: success);
        // Get.toNamed('dashboard/apply/one');
        if (bvnfrom == 0) {
          Get.toNamed('home', arguments: 1);
          return;
        }
        if (bvnfrom == 1) {
          // Get.toNamed('credit/home');
          startnow();
          return;
        }
        
      }
      if (value["status"] == "error") {
        snackbar(message:  value["message"], header: "Error", bcolor: error);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      // print(err);
      // snackbar(message:"An Error Occoured.", header: "Error", bcolor: error);
    });
  }

  @override
  void initState() {
    setState(() {
      bvnfrom = Get.arguments;
    });
    // print(bvnfrom);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            const Topbar(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 33, right: 33),
                width: 100.w,
                color: CustomTheme.presntstate ? applydark : dashboardcard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Bvn",
                      style: TextStyle(
                        fontSize: 21,
                        color: CustomTheme.presntstate ? creditwithdark : primary,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    // const SizedBox(height: 25),
                    
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Enter BVN',
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
                              RequiredValidator(errorText: 'BVN is required.'),
                              MinLengthValidator(11, errorText: "BVN should be more than 10 characters.")
                            ]),
                            keyboardType: TextInputType.number,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onSaved: (val) => applystate.bvndata["bvn"] = val,
                            textInputAction: TextInputAction.next,
                            // decoration: InputDecoration(
                            //   filled: true,
                            //   contentPadding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                            //   fillColor: CustomTheme.presntstate ? inputcolordark : inputColor,
                            //   border: inputborder,
                            //   focusedBorder: activeinputborder,
                            //   enabledBorder: inputborder,
                            //   focusedErrorBorder:inputborder ,
                            //   errorBorder: errorborder,
                            //   disabledBorder: inputborder,
                            //   errorStyle: const TextStyle(color: Colors.red),
                            // )
                          ),
                        ],
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
                  // InkWell(
                  //   // onTap: () => Get.toNamed("credit/second"),
                  //   onTap: () => validate(),
                  //   child: Container(
                  //     width: 100.w,
                  //     height: 58,
                  //     color: primary,
                  //     alignment: Alignment.center,
                  //     child: Text(
                  //       "Skip",
                  //       style: TextStyle(
                  //         color: white,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    // onTap: () => Get.toNamed("credit/second"),
                    onTap: () => validate(),
                    child: Container(
                      width: 100.w,
                      height: 58,
                      color: const Color.fromRGBO(66, 213, 121, 1),
                      alignment: Alignment.center,
                      child: Text(
                        "Submit",
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