import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/services/datstruct.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';



class CashbackRepayment extends StatefulWidget {
  const CashbackRepayment({ Key? key }) : super(key: key);

  @override
  State<CashbackRepayment> createState() => _CashbackRepaymentState();
}

class _CashbackRepaymentState extends State<CashbackRepayment> {
  SavingController saving = Get.put(SavingController());
  AuthController auth = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  dynamic cashback;
  List? cards;
  TextEditingController amount = TextEditingController();
  Future<bool> _willPopCallback() async {
    return false; // return true if the route to be popped
  }

  dynamic data = {
    "loanid": "",
    "amount": "",
  };

  dynamic datacashback = {
    "loanid": "",
    "amount": "",
    "last4": ""
  };

  paycashbacklite() async {
    context.loaderOverlay.show();
    await saving.paycashbacklite(data: data).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: "", header: value["message"], bcolor: success);
        Get.offAllNamed('home', arguments: 1);
      }

      if (value?["status"] == "error") {
        snackbar(message: "", header: value["message"], bcolor: error);
        return;
        // Get.offAllNamed('home', arguments: 1);                       saving.paycashbackcard(data: datacashback);
      }
      
    });
  }

  paycashbackcard() async {
    context.loaderOverlay.show();
    await saving.paycashbackcard(data: data).then((value) {
      context.loaderOverlay.hide();
      if (value?["status"] == "success") {
        snackbar(message: "", header: value["message"], bcolor: success);
        Get.offAllNamed('home', arguments: 1);
      }

      if (value?["status"] == "error") {
        snackbar(message: "", header: value["message"], bcolor: error);
        return;
        // Get.offAllNamed('home', arguments: 1);                       saving.paycashbackcard(data: datacashback);
      }
      
    }); 
  }

  @override
  void initState() {
    print(auth.userdata["card_authorizations"]);
    if (auth.userdata["card_authorizations"] != null) {
      cards = auth.userdata["card_authorizations"];
    }
    setState(() {
      cashback = Get.arguments;
      data["loanid"] = cashback["loanid"];
      datacashback["loanid"] = cashback["loanid"];
      data["amount"] = (cashback["loan_history"]["balance"]).toString();
      datacashback["amount"] = (cashback["loan_history"]["balance"]).toString();
    });
    amount.text = (cashback["loan_history"]["balance"]).toString();
    super.initState();
  }

  showcard() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Select A Card",
                  style: TextStyle(
                    color: primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                margin: EdgeInsets.only(bottom: 10),
                height: 200,
                child: ListView.builder (
                  itemCount: cards!.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                  return  InkWell(
                    onTap: () {
                      datacashback["last4"] = cards![index]['last4'];
                      Get.back();
                      print(datacashback);
                      // paycashbackcard();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cards![index]['bank']),
                        Text(cards![index]['last4']),
                      ],
                    ),
                  );
                  }
                ),
              ),
              // Wrap(
              //   children: cards!.map(
              //     (item) =>   ListTile(
              //       leading: Icon(Ionicons.card),
              //       title: Text(cards![index]["last4"].toString()),
              //     ),
              //   ).toList(),
                // children: [
                  
                //   ListTile(
                //     leading: Icon(Icons.share),
                //     title: Text('Share'),
                //   ),
                //   ListTile(
                //     leading: Icon(Icons.copy),
                //     title: Text('Copy Link'),
                //   ),
                //   ListTile(
                //     leading: Icon(Icons.edit),
                //     title: Text('Edit'),
                //   ),
                // ],
              // ),
            ],
          ),
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
                        "Repay Cashback",
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          // "KWIKMAX - ${makecapitalize(savings["savings_name"].toString())}",
                          "Amount: ${stringamount(cashback["amount"])}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: primary,
                            fontFamily: GoogleFonts.roboto().toString(),
                          ),
                        ),
                        Text(
                          // stringamount(savings["amount_saved"].toString()),
                          "Maximum Repayment: ${stringamount(cashback["max_repayment"])}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
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
                          "You are about to payback this cashback.",
                          style: TextStyle(
                            color: getstartedp.withOpacity(0.42),
                            fontSize: 11
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: ()=> showcard(),
                          child: Container(
                            height: 44,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: registerActioncolor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "Pay With Card",
                              style: TextStyle(
                                color: white,
                                fontSize: 18
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: ()=> paycashbacklite(),
                          child: Container(
                            height: 44,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: registerActioncolor,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              "Pay Kwilite",
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