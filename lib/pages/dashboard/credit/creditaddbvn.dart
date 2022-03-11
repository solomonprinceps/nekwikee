import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';


class Creditbvn extends StatefulWidget {
  const Creditbvn({ Key? key }) : super(key: key);

  @override
  _CreditbvnState createState() => _CreditbvnState();
}

class _CreditbvnState extends State<Creditbvn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ApplyController  applystate =  Get.put(ApplyController());
  AuthController  auth =  Get.put(AuthController());

  void validate() {
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      submitbvn();
    } else {
      // print("not validated");
      snackbar(message: "A error in form validation occcoured.", header: "Validation error.", bcolor: error);
      
    }
  }  


  submitbvn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    await applystate.addbvnapplication().then((value) {
      context.loaderOverlay.hide();
      // print(value);   
      if (value["status"] == "success") {
        snackbar(message:  value["message"], header: "Success", bcolor: success);
        

        // Get.toNamed('dashboard/apply/one');
        Get.toNamed('credit/takeselfie', arguments: value["loan_id"]);
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
                          "Add Bvn",
                          style: TextStyle(
                            fontSize: 21,
                            color: primary,
                            fontWeight: FontWeight.w400
                          ),
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
                                    'Enter BVN',
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
                                    // validator: RequiredValidator(errorText: 'BVN is required.'),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'BVN is required.'),
                                      MinLengthValidator(11, errorText: "BVN whould be more than 10 characters.")
                                    ]),
                                    keyboardType: TextInputType.number,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    // controller: startdate,
                                    // onSaved: (val) => backendata["firstname"] = val,
                                    onSaved: (val) => applystate.bvndata["bvn"] = val,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Enter BVN",
                                      hintStyle: TextStyle(
                                        fontSize: 15,
                                        color: const Color.fromRGBO(53, 49, 48, 0.73).withOpacity(0.5),
                                        fontWeight: FontWeight.w400
                                      ),
                                      suffixIconColor: primary,
                                      suffix:const Icon(
                                        FontAwesome.angle_down
                                      ),
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
                // onTap: () => Get.toNamed("credit/second"),
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