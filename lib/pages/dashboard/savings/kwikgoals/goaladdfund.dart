import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';


class Goalsaddfund extends StatefulWidget {
  const Goalsaddfund({ Key? key }) : super(key: key);

  @override
  _GoalsaddfundState createState() => _GoalsaddfundState();
}

class _GoalsaddfundState extends State<Goalsaddfund> {
  SavingController saving = Get.put(SavingController());
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  List banklist = [];
  List allbanks = [];
  TextEditingController bankeditor = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController tranpin = TextEditingController();
  dynamic savings;
  dynamic data = {
    "amount" : "",
    "investmentid": ""
  };
  

  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  @override
  void initState() {
    // print(Get.arguments);
    setState(() {
      // banklist = Get.arguments["data"]
      savings = Get.arguments;
      data["investmentid"] = savings["investmentid"];
    });
    super.initState();
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      submit();
      // print(saving.savingwithdrawal);
    } else {
    }
  }  

  Future submit() async {
    context.loaderOverlay.show();
    await saving.addfundGoals(data).then((value) {
      context.loaderOverlay.hide();
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "error", bcolor: error);
      }
      if (value["status"] == "success") {
        snackbar(message: value?["message"], header: "success", bcolor: success);
        Get.offAndToNamed('home', arguments: 1);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
    });
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
                size: 20,
                color: CustomTheme.presntstate ? white : primary,
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Center(
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 3.h),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: savingmonth,
                          shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(
                          'assets/image/circlemax.svg',
                          semanticsLabel: 'Target',
                          // color: white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Add Fund",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: CustomTheme.presntstate ? creditwithdark : primary 
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      // height: ,
                      padding: const EdgeInsets.all(20),
                      // alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomTheme.presntstate ? HexColor("#212845") : greybackground,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            "KWIK GOALS",
                            // "GOALS - ${savings["savings_name"].toUpperCase()}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: primary
                            ),
                          ),
                          Text(
                            stringamount(savings?["amount_saved"].toString()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 42,
                              fontFamily: GoogleFonts.roboto().toString(),
                              color: savingmonth
                            ),
                          ),
                          const SizedBox(height: 15),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? inputcolordark : getstartedp
                                  ),
                                ),
                                const SizedBox(height: 5),
                                TextFormField( 
                                  style: TextStyle(
                                    color: CustomTheme.presntstate ? whitescaffold : darkscaffold,
                                    fontFamily: GoogleFonts.roboto().toString(),
                                  ),
                                  // obscureText: true,
                                  controller: amount,
                                  validator: RequiredValidator(errorText: 'Amount is required.'),
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.done,
                                  // initialValue: savings["amount_saved"].toString(),
                                  inputFormatters: [
                                    CurrencyTextInputFormatter(
                                    locale: 'en',
                                    decimalDigits: 0,
                                    symbol: '₦',
                                  )],
                                  onSaved: (val) {
                                    // saving.savingwithdrawal["amount"] = saving.goalformatamount(val);
                                    setState(() {
                                      data["amount"] = saving.goalformatamount(val);
                                    });
                                  },
                                  
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'FUND KWIKLITE',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: CustomTheme.presntstate ? HexColor("#CBD1D8") : getstartedp
                                  ),
                                ),
                                
                              ],
                            )
                          ),
                          const SizedBox(height: 15),
                          
                          Text(
                            "Your Funds will be withdrawn directly to your Kwiklite which could be transferred directly to this savings",
                            style: TextStyle(
                              // color: getstartedp.withOpacity(0.42),
                              color: CustomTheme.presntstate ? HexColor("#CBD1D8") : getstartedp,
                              fontSize: 11
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => validate(),
                            child: Container(
                              height: 44,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: registerActioncolor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(
                                "Add Fund",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 18
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}