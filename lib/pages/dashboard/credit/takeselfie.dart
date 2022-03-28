import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class TakeSelfie extends StatefulWidget {
  const TakeSelfie({ Key? key }) : super(key: key);

  @override
  _TakeSelfieState createState() => _TakeSelfieState();
}

class _TakeSelfieState extends State<TakeSelfie> {
  CustomTheme customTheme = CustomTheme();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      body: Stack(
        children: [
          Column(
            children: [
              Topbar(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 33, right: 33, top: 11),
                  width: 100.w,
                  color: CustomTheme.presntstate ? applydark : dashboardcard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply For Credit",
                        style: TextStyle(
                          fontSize: 28,
                          color: CustomTheme.presntstate ? creditwithdark : primary,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Take a Selfie",
                        style: TextStyle(
                          fontSize: 28,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "To verify it's human we need to take a selfie which will be compared with your passport photo.",
                        style: TextStyle(
                          fontSize: 12,
                          color: CustomTheme.presntstate ? inputcolordark : getstartedp,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: SvgPicture.asset(
                          'assets/image/addpics.svg',
                          semanticsLabel: 'money bill',
                          // color: white,
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
              onTap: () => Get.offAllNamed("home"),
              child: Container(
                width: 100.w,
                height: 58,
                color: const Color.fromRGBO(66, 213, 121, 1),
                alignment: Alignment.center,
                child: Text(
                  "Back",
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
              onTap: () => Get.toNamed("credit/camera", arguments: Get.arguments),
              child: Container(
                width: 100.w,
                height: 58,
                color: primary,
                alignment: Alignment.center,
                child: Text(
                  "Open Camera",
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
    );
  }
}


class Topbar extends StatelessWidget {
  const Topbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 25.h),
        Container(
          height: 20.h,
          width: 100.w,
          // child: Text("fiosa"),  
          decoration: BoxDecoration(
            color: primary,
            image: const DecorationImage(image: AssetImage("assets/image/credithome.png"), 
              fit: BoxFit.cover
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
        Positioned(
          top: 6.h,
          left: 3.w,
          child: InkWell(
            onTap: () =>  Get.back(),
            child: Container(
              width: 42,
              height: 42,
              padding: const EdgeInsets.all(10),
              child: Icon(
                FontAwesome.angle_left,
                color: black,
              ),
            
            ),
          )
        ),
      ],
    );
  }
}
