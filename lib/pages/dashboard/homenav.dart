import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
class Homenav extends StatefulWidget {
 
  const Homenav({ Key? key}) : super(key: key);

  @override
  State<Homenav> createState() => _HomenavState();
}

class _HomenavState extends State<Homenav> {
  @override
  void initState() {
    print(Get.arguments);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      timedown();
    });
    super.initState();
  }

  Future timedown() async {
    Timer(const Duration(milliseconds: 100), () {
      // Get.offAllNamed('second');
      print(100);
      Get.toNamed('home', arguments: Get.arguments);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Text(Get.arguments.toString()),
    );
  }
}