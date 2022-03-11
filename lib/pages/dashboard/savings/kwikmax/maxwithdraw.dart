import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'package:google_fonts/google_fonts.dart';

class Maxwithdrawal extends StatefulWidget {
  const Maxwithdrawal({ Key? key }) : super(key: key);

  @override
  _MaxwithdrawalState createState() => _MaxwithdrawalState();
}

class _MaxwithdrawalState extends State<Maxwithdrawal> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  SavingController saving = Get.put(SavingController());
  bool isChecked = false;
  List banklist = [];
  List allbanks = [];
  TextEditingController bankeditor = TextEditingController();
  TextEditingController accountnumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController tranpin = TextEditingController();
  dynamic savings;
  

  @override
  void initState() {
    setState(() {
      banklist = Get.arguments["data"];
      savings = Get.arguments["saving"];
    });
    saving.savingwithdrawal["investmentid"] = savings["investmentid"];
    // print(saving.savingwithdrawal["investmentid"]);

    // amount.text = savings["amount_saved"] != null ? savings["amount_saved"].toString() : '0';

    super.initState();
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState?.validate() != false) {
      _formKey.currentState?.save();
      submit();
    } else {
    }
  }  

  Future submit() async {
    context.loaderOverlay.show();
    print(saving.savingwithdrawal);
    await saving.withsavings().then((value) {
      context.loaderOverlay.hide();
      print(value);
      if (value["status"] == "error") {
        snackbar(message: value?["message"], header: "error", bcolor: error);
      }
      if (value["status"] == "success") {
        Get.offAndToNamed('home', arguments: 1);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      print(err);
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
                title: Text(
                  "Bank",
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
                            final bankname = bank["name"].toLowerCase();
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
                                bankeditor.text = allbanks[index]["name"];
                                saving.savingwithdrawal["bankcode"] = allbanks[index]["code"];
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() => _willPopCallback(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 45,
              height: 45,
              child: Icon(
                FontAwesome.angle_left,
                size: 40,
                color: primary,
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(
                          'assets/image/maxwithdraw.svg',
                          semanticsLabel: 'Target',
                          // color: white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Withdrawal",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: primary
                        ),
                      ),
                    ],
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
                          "KWIKMAX - ${makecapitalize(savings["savings_name"].toString())}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 1.6,
                            color: HexColor("#3E4095")
                          ),
                        ),
                        Text(
                          stringamount(savings["amount_saved"].toString()),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 42,
                            color: primary,
                            fontFamily: GoogleFonts.roboto().toString(),
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
                                validator: RequiredValidator(errorText: 'Amount'),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                controller: amount,
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
                          "Your Funds will be withdrawn directly to your Kwiklite which could be transferred directly to your registered  \n \n Bank Details - Adedayo Adebimpe |GTBank | 3123245354",
                          style: TextStyle(
                            color: getstartedp.withOpacity(0.42),
                            fontSize: 11
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: ()=> validate(),
                          child: Container(
                            height: 44,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: registerActioncolor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "Withdraw",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}