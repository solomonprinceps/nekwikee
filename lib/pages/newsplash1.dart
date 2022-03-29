import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:uni_links/uni_links.dart';
import 'package:lottie/lottie.dart';

class Newsplash extends StatefulWidget {
  const Newsplash({ Key? key }) : super(key: key);

  @override
  State<Newsplash> createState() => _NewsplashState();
}

class _NewsplashState extends State<Newsplash> {


   @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      checkpassgetstarted();
    });
    super.initState();
  }


  checkpassgetstarted () async {
    
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic statebool = authstorage.getBool('passgetstarted');
    dynamic token = authstorage.getString("accessToken");
    print("token");
    print(token);
    print("statebool");
    print(statebool);
    Timer(const Duration(milliseconds: 4000), () {
      if (token != null) {
        // Get.offAllNamed("onboard");
        Get.offAllNamed('home');
        // Get.offAllNamed('dashboard/home');
        return;
      }
      if (statebool == true) {
        Get.offAllNamed("auth/login");
        return;
      }
      if (token == null) {
        Get.offAllNamed("onboard");
        return;   
      }
    });
    
  }

  Future timedown() async {
    Timer(const Duration(milliseconds: 1000), () {
      Get.offAllNamed('onboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      color: white,
      child: Center(
        // child: Image.asset('assets/image/newsplash3.jpeg')
        child: Lottie.asset('assets/image/Kwikee_Splash.json', repeat: false),
      ),
    );
  }
}