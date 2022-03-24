import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'dart:async';
import 'package:get/get.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({ Key? key }) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      timedown();
    });
    super.initState();
  }


  Future timedown() async {
    Timer(const Duration(milliseconds: 2000), () {
      Get.offAllNamed('second');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [    
          Hero(
            tag: "rain",
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/first11.png'),
                  fit: BoxFit.cover,
                ),
              ),
              height: 100.h,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}