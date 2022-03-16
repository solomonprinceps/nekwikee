import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';



class Third extends StatefulWidget {
  const Third({ Key? key }) : super(key: key);

  @override
  _ThirdState createState() => _ThirdState();
}

class _ThirdState extends State<Third> {
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
   
    Timer(const Duration(milliseconds: 2000), () {
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
    return Scaffold(
      body: Column(
        children: [         
          Expanded(
            child: Center(
              child: Image.asset('assets/image/kwikee.png')
            ),
          )
        ],
      ),
    );
  }
}