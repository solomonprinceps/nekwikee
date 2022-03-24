import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kwikee1/controllers/savingcontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';


class Maxconfirm extends StatefulWidget {
  const Maxconfirm({ Key? key }) : super(key: key);

  @override
  _MaxconfirmState createState() => _MaxconfirmState();
}

class _MaxconfirmState extends State<Maxconfirm> {
  bool isChecked = false;
  dynamic savingsdata;
  SavingController saving = Get.put(SavingController());
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  AuthController auth = Get.find<AuthController>();
  List cards = [];
  String publicKeyTest = 'pk_live_6ac0e9de3f66c6954ac5484df48f10d98e9adc5f'; //pass in the public test key obtained from paystack dashboard here
  final plugin = PaystackPlugin();

  @override
  void initState() {
    setState(() {
      savingsdata = Get.arguments;
    });
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      
      plugin.initialize(publicKey: publicKeyTest);
      // loadashboard();
      print('${savingsdata["user"]["card_authorizations"]}');
    });
    super.initState();
  }

  

  //a method to show the message
  void _showMessage(String message, Color background) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: background,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //async method to charge users card and return a response card_setup_link
  chargeCard() async {
    print("ref " + savingsdata["paymentref"].toString());
    String refs = savingsdata["paymentref"].toString();
    var charge = Charge();
    charge.amount = int.parse(savingsdata["deposit_amount"]) *100;
    charge.reference = refs;
    charge.email = auth.userdata["email"];
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );

    if (response.status == true) {
      updatebackcard(refs);
      setState(() {
        savingsdata["payment_type"] = '3';
        savingsdata["last4"] = "";
        // savingsdata["paymentref"] = savingsdata["paymentref"].toString();
      });
      print('saving ${savingsdata["paymentref"]}');
      savingsdata["payment_type"] = '3';
      print('payment_type ${savingsdata["payment_type"]}');
      print("last4 ${savingsdata["last4"]}");  
      savingMAX();
      _showMessage('Payment was successful!!!', success);
      // Get.offAllNamed('home', arguments: 1);
    } else {
      _showMessage('Payment Failed!!!', error);
    }
  }

  Future updatebackcard(String data) async {
    context.loaderOverlay.show();
    await auth.calinkcard(data).then((value) {
      context.loaderOverlay.hide();
      _showMessage('Payment was successful!!!', success);
      print(" xnjsm" + value);
    }).catchError((err) {
      print(err);
    });
  }

  Future loadashboard() async {
    context.loaderOverlay.show();
    await auth.dashbaord().then((value) {
      context.loaderOverlay.hide();
      if (value["user"]["card_authorizations"] != null) {
        setState(() {
          cards = value["user"]["card_authorizations"];
        });
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      // print(err);
    });
  }

  savingMAX() async {
    context.loaderOverlay.show();
       
    await saving.submitmax(savingsdata).then((value) {
      context.loaderOverlay.hide();
      print(value);   
      if (value["status"] == "success") {
        context.loaderOverlay.hide();
        snackbar(message: value["message"], header: "Success", bcolor: success);
        
        Get.toNamed('home', arguments: 1);
        // Get.toNamed('dashboard/savings/confirmation', arguments: value);
      }
      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
      }
    }).catchError((err) {
      context.loaderOverlay.hide();
      // print(err);
      snackbar(message: "An Error Occoured", header: "Error", bcolor: error);
    });
  }


// return CupertinoActionSheetAction(
//             child: Text(
//               item["text"].toString(),
//               style: TextStyle(fontSize: 20, color: black),
//             ),
//             onPressed: () {
//               // applystate.nextofkindata["next_kin_relationship"] = "Sibling";
//               employmentdetailcontrol.text = item["value"];
//               Navigator.pop(context);
//             },
//           );
//         }).toList(),
  showModal(ctx) {
    return showModalBottomSheet(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: 350,
          decoration: BoxDecoration(
            color: !CustomTheme.presntstate ? white : darkscaffold,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 30),
              Text(
                "Where do you want to fund from ?",
                style: TextStyle(
                  color: !CustomTheme.presntstate ? darkscaffold  : white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(FontAwesome5Solid.piggy_bank, color: primary),
                title: Text(
                  'Saving',
                  style: TextStyle(
                    color: !CustomTheme.presntstate ? darkscaffold  : white,
                  ),
                ),
                onTap: () {
                  savingsdata["payment_type"] = '1';
                  savingsdata["last4"] = "";
                  Navigator.pop(context);
                  // print(savingsdata);
                  savingMAX();
                },
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: cards.isEmpty,
                // visible: true,
                child: GestureDetector(
                  onTap:() {
                    Get.back();
                    chargeCard();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    margin: const EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    // height: 100,
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add New Card",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: !CustomTheme.presntstate ? darkscaffold  : white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // color: primary,
                  ),
                ),
              ),
              Visibility(
                visible: cards.isNotEmpty,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ListView.builder
                      (
                        itemCount: cards.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                savingsdata["payment_type"] = '2';
                                savingsdata["last4"] = cards[index]["last4"];
                                Navigator.pop(context);
                                savingMAX();
                              },
                              child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cards[index]["bank"].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: !CustomTheme.presntstate ? darkscaffold  : white,
                                        ),
                                      ),
                                      Text(
                                        cards[index]["last4"].toString(),
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: !CustomTheme.presntstate ? darkscaffold  : white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    // child: Column(
                    //   children: [
                    //     ListTile(
                    //       leading: Icon(FontAwesome.cc, color: primary),
                    //       title: const Text('Cards'),
                    //       onTap: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
              
              
            ],
          ),
        );
      }
    );
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(bottom: 40),
                child: Row(
                  children: [
                    Container(
                      width: 63,
                      height: 63,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primary
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
                            "KwikMax",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w400,
                              color: CustomTheme.presntstate ? creditwithdark : primary 
                            ),
                          ),
                          Text(
                            "Earn upto 18% per annum when you lock your funds for a minimum of 30 days.",
                            style: TextStyle(
                              fontSize: 9,
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
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                width: double.infinity,
                // height: double.infinity,
                decoration: BoxDecoration(
                  color: CustomTheme.presntstate ? HexColor("#212845") : HexColor("#F8F8F8"),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 20, top: 14),
                          height: 109,
                          width: 331,
                          decoration: BoxDecoration(
                            color:const Color.fromRGBO(62, 64, 149, 0.11),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [
                                  const SizedBox(height: 18),
                                  Text(
                                    "Deposit amount",
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? inputcolordark : kwiklightcolor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  
                                  Text(
                                    // "₦300,000",
                                    stringamount(savingsdata["deposit_amount"].toString()),
                                    style: TextStyle(
                                      color: CustomTheme.presntstate ? white : primary,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  // Text(
                                  //   "₦20,000/month",
                                  //   style: TextStyle(
                                  //     color: kwiklightcolor.withOpacity(0.2),
                                  //     fontSize: 10,
                                  //     fontWeight: FontWeight.w600
                                  //   ),
                                  // ),                                                    
                                ],
                              ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     const SizedBox(height: 30),
                              //     Text(
                              //       "1/3 Months",
                              //       style: TextStyle(
                              //         color: savingmonth,
                              //         fontWeight: FontWeight.w300,
                              //         fontSize: 17
                              //       ),
                              //     ),
                              //   ],
                              // )             
                            ],
                          ),
                        ),
                        Positioned(
                          right: 0,
                          // top: -10,
                          child: Opacity(
                            opacity: 1,
                            child: Container(
                              height: 30,
                              width: 148,
                              
                              decoration: BoxDecoration(
                                color: HexColor("#42D579"),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Maturity time; ${savingsdata["duration"].toString()} days",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w300,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // const SizedBox(height: 15),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "TENOR",
                                style: TextStyle(
                                  // color:Color.fromRGBO(53, 49, 48, 1),
                                  color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                '${savingsdata["duration"].toString()} Days',
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "INTEREST RATE",
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                savingsdata["rate"].toString(),
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "MATURITY DATE",
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                               Text(
                                dateformater(savingsdata["maturity_date"].toString()),
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "ESTIMATED AMOUNT",
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? inputcolordark : const Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                // "₦400,000.00",
                                stringamount(savingsdata["estimated_amount"].toString()),
                                style: TextStyle(
                                  color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.roboto().toString(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Your Kwiklite will be credited with your interest upon confirmation of savings.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: CustomTheme.presntstate ? white : const Color.fromRGBO(53, 49, 48, 1)
                      ),
                    ),
                    SizedBox(height: 20),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20, bottom: 20),
                    //   child: Row(
                    //     children: [
                    //       Checkbox(
                    //         value: isChecked,
                    //         activeColor: const Color.fromRGBO(53, 49, 48, 1),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //         ),
                    //         onChanged: (value) {
                    //           setState(() {
                    //             isChecked = value!;
                    //           });
                    //         },
                    //       ),
                    //       Text(
                    //         "I agree to the terms and conditions.",
                    //         style: TextStyle(
                    //           color: CustomTheme.presntstate ? white : const Color.fromRGBO(28, 27, 27, 1),   
                    //           fontSize: 15 
                    //         )
                    //       )  
                    //     ],
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        // chargeCard();
                        // if (!isChecked) {
                        //   snackbar(message: "Accept our terms and conditions", header: "Error", bcolor: error);
                        // }
                        // if (isChecked) {
                        //   // savingMAX();
                        //   showModal(context);
                        // }
                        showModal(context);
                      },
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
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}