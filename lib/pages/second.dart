import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'dart:async';


class Second extends StatefulWidget {
  const Second({ Key? key }) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      timedown();
    });
    super.initState();
  }

  Future timedown() async {
    Timer(const Duration(milliseconds: 2000), () {
      Get.offAllNamed('third');
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/first1.png'),
                  fit: BoxFit.cover,    // -> 02
                ),
              ),
              height: 50.h,
              width: double.infinity,
            ),
          ),

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