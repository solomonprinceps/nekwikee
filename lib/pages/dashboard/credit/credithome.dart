import 'package:flutter/material.dart';
import 'package:kwikee1/controllers/applycontroller.dart';
import 'package:kwikee1/controllers/authcontroller.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Credithome extends StatefulWidget {
  const Credithome({ Key? key }) : super(key: key);

  @override
  _CredithomeState createState() => _CredithomeState();
}

class _CredithomeState extends State<Credithome> {
  ApplyController  applystate =  Get.put(ApplyController());
  AuthController  auth =  Get.put(AuthController());


  startnow() async {
    FocusScope.of(context).requestFocus(FocusNode());
    context.loaderOverlay.show();
    applystate.startapplication().then((value) {
      context.loaderOverlay.hide();
      // print('checker ${value} ');
      if (value["status"] == "success") {
        auth.getusers();
        // Get.toNamed('dashboard/apply/camera', arguments: value["loan_id"]); credit/takeselfie
        Get.toNamed('credit/takeselfie', arguments: value["loan_id"]);
      }
      if (value["bvn"] == 0) {
        snackbar(message: value["message"], header:  "Successful.", bcolor: success);
        Get.offAndToNamed("credit/addbvn", arguments: 1);
        return;
      }
      if (value["status"] == "error" ) {
        snackbar(message: value["message"], header:  "Error.", bcolor: error);
      }
    }).catchError((onError) {
      // print(onError);
      context.loaderOverlay.hide();
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Topbar(),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 33, right: 33, top: 41),
                  width: 100.w,
                  // color: error,
                  color: CustomTheme.presntstate ? applydark : dashboardcard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply For Credit",
                        style: TextStyle(
                          fontSize: 30,
                          color: CustomTheme.presntstate ? creditwithdark : primary,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      const SizedBox(height: 20),
                      AutoSizeText(
                        'You are about to apply for Kwikee credit. Kindly read the following before you get started:',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.presntstate ? credithometextdark : savingmonth
                        ),
                        minFontSize: 10,
                        maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 17),
                      AutoSizeText(
                        'The loans work like a virtual credit card for salary earners. The repayment date is your salary date.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: credithometextdark
                        ),
                        minFontSize: 10,
                        maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 17),
                      AutoSizeText(
                        'We will collect some information from you in the next few steps and based on this we will make you a loan offer. \n\n This amount is the maximum credit amount that can be made available for you at this time. As you increase your credibility by paying back at the required time, more will be made available to you.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: credithometextdark 
                        ),
                        minFontSize: 10,
                        // maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align( 
            alignment: Alignment.bottomCenter,
            child: InkWell(
              // onTap: () => Get.toNamed('credit/first'),
              // onTap: () => Get.toNamed("credit/addbvn"),
              // onTap: () => Get.toNamed("credit/takeselfie"),
              onTap: () => startnow(),
              child: Container(
                width: 100.w,
                height: 58,
                color: const Color.fromRGBO(66, 213, 121, 1),
                alignment: Alignment.center,
                child: Text(
                  "Get Started",
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
    return Container(
      color: CustomTheme.presntstate ? applydark : dashboardcard,
      child: Stack(
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
      ),
    );
  }
}