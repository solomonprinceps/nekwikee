import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'dart:async';

class Cashback extends StatefulWidget {
  const Cashback({ Key? key }) : super(key: key);

  @override
  _CashbackState createState() => _CashbackState();
}


class _CashbackState extends State<Cashback> {

  dynamic data;

  @override
  void initState() {
    // data = jsonDecode(Get.arguments);
    timedown();
    super.initState();
  }

  Future timedown() async {
    Timer(const Duration(milliseconds: 3000), () {
      Get.offAllNamed('home', arguments: 0);
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
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(247, 92, 53, 1),
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
              'Cashback Successful Funded',
              style: TextStyle(
                color: CustomTheme.presntstate ? creditwithdark : primary,
                fontSize: 21,
                fontWeight: FontWeight.w400
              ),
            ),
            const SizedBox(height: 10),
            //rgba(53, 49, 48, 1)
            Padding(
              padding: const EdgeInsets.only(left:20, right: 20, top: 15),
              child: Text(
                "To access your cashback funds go to your Kwik Lite.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: CustomTheme.presntstate ? inputcolordark :const Color.fromRGBO(53, 49, 48, 1),
                  fontWeight: FontWeight.w400
                ),
              )
            ),
        

          ],
        ),
      )
    );
  }
}