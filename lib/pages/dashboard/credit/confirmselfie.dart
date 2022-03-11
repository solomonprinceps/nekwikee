import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kwikee1/services/utils.dart';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Confirmselfie extends StatefulWidget {
  const Confirmselfie({ Key? key }) : super(key: key);

  @override
  _ConfirmselfieState createState() => _ConfirmselfieState();
}

class _ConfirmselfieState extends State<Confirmselfie> {
  ApplyController applycon = Get.put(ApplyController());
  AuthController auth = Get.put(AuthController());
  dynamic loanid;
  dynamic img;
  @override
  void initState() {
    // TODO: implement initState
    // print(Get.arguments);
    debuker();
    super.initState();
  }


  void debuker() {
    dynamic dbnk = jsonDecode(Get.arguments);
    loanid = dbnk[0];
    img = dbnk[1];
    print(loanid);
    print(img);
  }

  uploadselfie() async {
    context.loaderOverlay.show();
    applycon.selfieupload().then((value) {
      // print(value);
      context.loaderOverlay.hide();
      // print(value["status"]);
      if (value["status"] == "success") {
        Get.toNamed('credit/first', arguments: applycon.password["loan_id"]); 
      }

      if (value["status"] == "error") {
        snackbar(message: value["message"], header: "Error", bcolor: error);
      }
      
    }).catchError((onError ) {
      context.loaderOverlay.hide();
      // print(onError);
      snackbar(message: "Error Occoured", header: "Error", bcolor: error);
      
      
      context.loaderOverlay.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.only(left: 33, right: 33, top: 11),
                    width: 100.w,
                    color: dashboardcard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Apply For Credit",
                          style: TextStyle(
                            fontSize: 28,
                            color: primary,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Take a Selfie",
                          style: TextStyle(
                            fontSize: 28,
                            color:  Color.fromRGBO(57, 183, 233, 1),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 17),
                        const Text(
                          "To verify it's human we need to take a selfie which will be compared with your passport photo.",
                          style: TextStyle(
                            fontSize: 12,
                            color:  Color.fromRGBO(53, 49, 48, 0.6),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        const SizedBox(height: 20),

                        Center(
                          // child: SvgPicture.asset(
                          //   'assets/image/addpics.svg',
                          //   semanticsLabel: 'money bill',
                          //   // color: white,
                          // ),
                          child: Container(
                            height: 260,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(Io.File(img)),
                                // image: Image.memory(img),
                                fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align( 
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                // onTap: () => Get.toNamed('credit/first'),
                onTap: () => uploadselfie(),
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
              bottom: 58,
              child: GestureDetector(
                // onTap: () => Get.toNamed('credit/first'),
                // onTap: () => Get.toNamed("credit/addbvn"),
                // onTap: () => Get.back(),
                onTap: () => Get.toNamed("credit/camera", arguments: loanid),
                child: Container(
                  width: 100.w,
                  height: 58,
                  color: primary,
                  alignment: Alignment.center,
                  child: Text(
                    "Retake",
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
          ],
        ),
      ),
    );
  }
}