import 'package:flutter/material.dart';
import 'package:kwikee1/services/utils.dart';
import 'package:kwikee1/styles.dart';
import 'package:sizer/sizer.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';


class Terms extends StatefulWidget {
  const Terms({ Key? key }) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  Image? woman;

    void launchInBrowser(String url) async {
    await launch(url);
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      // backgroundColor: ,
      body: SizedBox(
        height: 100.h,
        child: Column(
          children: [
            const Topbar(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 33, right: 33, ),
                width: 100.w,
                color: CustomTheme.presntstate ? applydark : dashboardcard,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const SizedBox(height: 10),
                      AutoSizeText(
                        'Terms and conditions',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.presntstate ? credithometextdark : savingmonth
                        ),
                        minFontSize: 10,
                        maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 17),
                      AutoSizeText(
                        'When you create an account , you are setting up an agreement between Moneymarque Finance and yourself. Below is the short version of the legal terms for use of the Kwikee App',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                        minFontSize: 10,
                        maxLines: 4,
                        // overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "1. Customer’s Consent",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "You consent and agree to the following in this Agreement.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(a). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Sending you information through emails, social  media, or the Kwikee App.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(b). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Reviewing your credit report from time to time.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                        
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(c). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Debiting your account to reduce or pay off debt you owe us.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(d). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Our sharing the information you have given us  so we can provide you with our services.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(e). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Once you register on the kwikee application and accept our terms and conditions you agree to be a member of Em-Marque (Opebi) multipurpose cooperative society limited.',
                                // maxLines: ,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                              
                      const SizedBox(height: 17),
                
                      Text(
                        "Please see our privacy policy here",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () => launchInBrowser("https://kwikee.app/privacy-policy"),
                        child: Text(
                          "https://kwikee.app/privacy-policy",
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            color: CustomTheme.presntstate ? credithometextdark : primary 
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                            
                      Text(
                        "2. Condition for use of kwikee account",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "To open a Kwikee account, you must",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(a). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'agree to our terms and conditions.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(b). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'register on the app.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                        
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(c). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'be a Nigerian citizen or legal resident, and',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "(D). ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: CustomTheme.presntstate ? credithometextdark : primary
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'be at least 18 years old.',
                                maxLines: 3,
                                // softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: CustomTheme.presntstate ? credithometextdark : primary
                                ),
                                // minFontSize: 10,
                                // maxLines: 4,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "We may need you to provide some additional information which will allow us to identify you, and meet our obligations under law",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "3. Lending Terms",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "If you apply for credit, you agree to repay the credit withdrawn from the credit card, including any fees. We will take the money from either your kwikee account, the debit card provided by you, or by bank transfer.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "4. Our responsibility to you",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "If you qualify for credit, we will make the credit available to you within a reasonable time.  If you do not make your payments on time, or break your agreement with us, we will try to collect the money, using legal means, including reporting you to the Central Bank of Nigeria.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "5. Investment Terms",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "When you save on any plan,you agree to the interest rates shown.If you decide to save on kwikmax, you will be unable to withdraw your money until the agreed date, but you will have access to a cashback of 75% of your money with us. If you decide to save on kwikGoals and kwiklit, you agree to pay a fee if you withdraw your money before the agreed date. See our interest rates and fees here.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "6. Closing your account",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "Please contact us, if you want to close your account. You will need to pay us any money you owe us before we close your account. If we decide to close your account we will notify you first but, we may close your account without informing you, if we believe that you have given us false information, committed or tried to commit a crime, or acted against this agreement.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "7. General Terms",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "We will update these terms and conditions from time to time, and will notify you once we have done so. If you are not happy with the changes, and choose to close your account, please let us know. If you choose to keep your account, it means you have accepted our terms.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 17),
                      Text(
                        "8. How we will contact you",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        "We will contact you through the phone number or email address you provided to us, or through notifications on your device. If you have any questions, complaints or claims, please contact us via mail help@kwikee.app.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: CustomTheme.presntstate ? credithometextdark : primary 
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      
                    ],
                  ),
                ),
              ),
            ),
            
            
          ],
        ),
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