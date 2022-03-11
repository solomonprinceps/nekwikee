import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Goalsconfirm extends StatefulWidget {
  const Goalsconfirm({ Key? key }) : super(key: key);

  @override
  _GoalsconfirmState createState() => _GoalsconfirmState();
}

class _GoalsconfirmState extends State<Goalsconfirm> {
  
  bool isChecked = false;

  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();

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
              color: black,
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
      body: SafeArea(
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(0, 175, 239, 1)
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
                          "Goals",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                            color: primary
                          ),
                        ),
                        Text(
                          "You have access to your funds anytime. Attracts interest of 10% per annum. No minimum amount",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#353130")
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
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: HexColor("#F8F8F8"),
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
                            color:const Color.fromRGBO(145, 216, 247, 0.34),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "CAMARY",
                                    style: TextStyle(
                                      color: kwiklightcolor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "₦300,000",
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 35,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  // const SizedBox(height: 5),
                                  Text(
                                    "₦20,000/month",
                                    style: TextStyle(
                                      color: kwiklightcolor.withOpacity(0.2),
                                      fontSize: 10,
                                      fontFamily: GoogleFonts.roboto().toString(),
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),                                                    
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 30),
                                  Text(
                                    "1/3 Months",
                                    style: TextStyle(
                                      color: savingmonth,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17
                                    ),
                                  ),
                                ],
                              )             
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
                                "Maturity time; 310 days",
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
                            children: const [
                              Text(
                                "TENURE",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                "12 Months",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "INTEREST RATE",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                "0.15% Per Day",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "MATURITY DATE",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              const Text(
                                "10 July, 2045",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                                ),
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "ESTIMATED AMOUNT",
                                style: TextStyle(
                                  color:Color.fromRGBO(53, 49, 48, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11
                                ),
                              ),
                              Text(
                                "₦400,000.00",
                                style: TextStyle(
                                  color: const Color.fromRGBO(53, 49, 48, 0.6),
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
                    const Text(
                      "This estimate assumes you save #5000 monthly between today and your chosen maturity date",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(53, 49, 48, 1)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: const Color.fromRGBO(53, 49, 48, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text(
                            "I agree to the terms and conditions.",
                            style: TextStyle(
                              color: Color.fromRGBO(28, 27, 27, 1),   
                              fontSize: 15 
                            )
                          )  
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed("savings/max/confirm"),
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
              ),
            )
          ],
        )
      ),
    );
  }
}