import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'dart:async';

class Finalcredit extends StatefulWidget {
  const Finalcredit({ Key? key }) : super(key: key);

  @override
  _FinalcreditState createState() => _FinalcreditState();
}

class _FinalcreditState extends State<Finalcredit> {

  dynamic data;

  @override
  void initState() {
    data = jsonDecode(Get.arguments);
    timedown();
    super.initState();
  }

  Future timedown() async {
    Timer(const Duration(milliseconds: 3000), () {
      Get.offAllNamed('home', arguments: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: ,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 30.h),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 126,
                    height: 126,
                    padding: const EdgeInsets.all(20),
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 38),
            Text(
              "SUCCESSFUL!",
              style: TextStyle(
                color: CustomTheme.presntstate ? creditwithdark : primary,
                fontSize: 28
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Credit Application Completed',
              style: TextStyle(
                color: CustomTheme.presntstate ? creditwithdark : primary,
                fontSize: 21,
                fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left:7, right: 7),
            //   child: RichText(
            //     textAlign: TextAlign.center,
            //     text:  TextSpan(
            //       text: 'Your Loan of ',
                  
            //       style:  TextStyle(
            //         color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 1) : white,
            //         fontSize: 15
            //       ),
            //       children: <TextSpan>[
            //         TextSpan(text: stringamount(data["loanamount"].toString()), style: const TextStyle(fontWeight: FontWeight.w600)),
            //         const TextSpan(text: ' to be repayed on the '),
            //         TextSpan(text:data["loanrepayment"], style: const TextStyle(fontWeight: FontWeight.w600)),
            //         const TextSpan(text: " is being processed and you would be contacted via email when it's approved."),
            //       ],
            //     ),
            //   ),
            // Your credit application has been completed and is being processed. You would be contacted via email once approved
            // ),
            Padding(
              padding: const EdgeInsets.only(left:7, right: 7),
              child: RichText(
                textAlign: TextAlign.center,
                text:  TextSpan(
                  text: 'Your credit application has been completed ',
                  
                  style:  TextStyle(
                    color: !CustomTheme.presntstate ? const Color.fromRGBO(53, 49, 48, 1) : white,
                    fontSize: 15
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "and is being processed. "),
                    TextSpan(text: "You would be contacted via email once approved"),
                    // const TextSpan(text: " is being processed and you would be contacted via email when it's approved."),
                  ],
                ),
              ),
            )
        

          ],
        ),
      )
    );
  }
}