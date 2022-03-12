import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


Color whitescaffold = Colors.white;
Color success = Colors.green;
Color white = Colors.white;
Color black = Colors.black;
Color onboardaction = HexColor('#91d8f7');
Color darkscaffold = HexColor('#131b39');
Color primary = const Color.fromRGBO(62, 64, 149, 1);
Color onboardbackground = const Color.fromRGBO(62, 64, 149, 1);
Color transparent = Colors.transparent;
Color getstartedp = HexColor('#353130');
Color inputColor = const Color.fromRGBO(53, 49, 48, 0.06);
Color inputcolordark = const Color.fromRGBO(63,70,94, 1);
Color labelactive = const Color.fromRGBO(0, 175, 239, 1);
Color registerActioncolor = HexColor('#53E88B');
Color error = Colors.red;
Color dashboardbackground = HexColor('#f5f6fb');
Color dashname = HexColor('#3E4095');
Color dashboardcard = HexColor('#F8F8F8');
Color dackmodedashboardcaard = HexColor('#303753');
Color darkwhite = HexColor('#F6FBFE');
Color kwiklightcolor = HexColor("#353130");
Color kwikmaxcolor = const Color.fromRGBO(62, 64, 149, 0.11);
Color savingmonth = HexColor("#00AFEF");
Color kwikgoals = HexColor("#e5f6fd"); 

Color listingtextlight = HexColor('#3E409545');
Color listingtextdatelight = HexColor("#3E4095B3");
Color listmoneylight = HexColor('#00AFEF');
Color kwikeegoals = HexColor("#00AFEF");
Color creditcolorlight = HexColor("#35313099");
Color creditcolordark = HexColor("#FFFFFF");
Color iconcolor = HexColor("#898989");
Color iconcolorselected = HexColor("#3e4095");
Color goalstext = HexColor("#F6FBFE");
Color cashbackbackground = HexColor("#F75C35");
Color greybackground = HexColor("#F8F8F8");
Color credithometextlight = const Color.fromRGBO(53, 49, 48, 0.6);


Color darkbottomtype = HexColor("#212946");
Color darkactivity = HexColor("#82869D");
Color creditwithdark = HexColor("#53D1FF");
Color applydark = HexColor("#131B39");

Color credithometextdark = HexColor("#CBD1D8");















OutlineInputBorder inputborder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    style: BorderStyle.solid,
    width: 1,
    color: inputColor
  ),
);

OutlineInputBorder errorborder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    style: BorderStyle.solid,
    color: Colors.red, 
    width: 2
  ),
);

OutlineInputBorder activeinputborder = OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(0)),
  borderSide: BorderSide(
    style: BorderStyle.solid,
    width: 2,
    color: labelactive
  ),
);