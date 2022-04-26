import 'package:flutter/material.dart';
import 'package:kwikee1/styles.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kwikee1/themes/apptheme.dart';
import 'package:sizer/sizer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class Otpmodal extends StatefulWidget {
  const Otpmodal({ Key? key }) : super(key: key);

  @override
  State<Otpmodal> createState() => _OtpmodalState();
}

class _OtpmodalState extends State<Otpmodal> {
  List<String> otp = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: HexColor("#0000000F"),
                      ),
                      child: Icon(
                        Icons.cancel,
                        color: white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  "Enter OTP",
                  style: TextStyle(
                    color: CustomTheme.presntstate ? white : black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Enter the 4 digit pin",
                  style: TextStyle(
                    color: CustomTheme.presntstate ? white : black,
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 70.w,
                  height: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    color: CustomTheme.presntstate ? dackmodedashboardcaard : HexColor("#f8f8f8"),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: otp.length >= 1 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                        ),
                      ), 
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: otp.length >= 2 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: otp.length >= 3 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: otp.length >= 4 ? CustomTheme.presntstate ? white : primary : CustomTheme.presntstate ? white.withOpacity(0.3) : primary.withOpacity(0.3)
                        ),
                      ) 
                    ],
                  )
                ),
                SizedBox(height: 20.h),
                
                NumericKeyboard(
                  onKeyboardTap: (val) {
                    if (otp.length == 4) {
                      print(otp);
                      return;
                    }
                    if (otp.isNotEmpty || otp.length != 4) {
                      setState(() {
                        otp.add(val);
                      });
                      if (otp.length == 4) {
                        print(otp);
                        return;
                      }
                    }
                  },
                  textColor: CustomTheme.presntstate ? white : primary,
                  rightButtonFn: () {
                    if (otp.isNotEmpty || otp.length != 0) {
                      setState(() {
                        otp.removeLast();
                      });
                      print(otp);
                    }
                  },
                  rightIcon: Icon(Icons.backspace, color: CustomTheme.presntstate ? white : primary),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}