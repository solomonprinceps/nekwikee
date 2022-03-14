import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kwikee1/styles.dart';
import 'package:get/get.dart';


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


// String dateformater(String datestring) {
//   return DateFormat('MMM dd, yyyy').format(DateTime.parse(datestring)).toString();
// }



snackbar({@required String? message,@required String? header,@required Color? bcolor}) {
  Get.snackbar(
    header.toString(), // title
    message.toString(), // message
    // icon: const Icon(Icons.cancel),
    backgroundColor: bcolor,
    colorText: white,
    shouldIconPulse: true,
    // onTap:(){},
    barBlur: 20,
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 1),
  );
}

double checkDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return 0.0 + value;
  } else {
    return value;
  }
}

String stringamount(String? value) { 
  
  if (value.toString() == '' || value.toString() == ' ') {
    return '₦0';
  }
  if (value == null) {
    return '₦0';
  }
  var newPrice = double.parse(value.toString());
  // if (newPrice == null) {
    
  // }
  String actualPrice =  newPrice.toStringAsFixed(0);
  return NumberFormat.currency(name: '₦').format(int.parse(actualPrice)).toString();
}
String Intamount(int value) {
  String actualPrice =  value.toStringAsFixed(0);
  return NumberFormat.currency(name: '₦').format(int.parse(actualPrice)).toString();
}

String dateformater(String datestring) {
  if (datestring == '') {
    return '';
  }
  return DateFormat('MMM dd, yyyy').format(DateTime.parse(datestring)).toString();
}

// String capitalize(String stringdata) {
//   return "${stringdata[0].toUpperCase()}${stringdata.substring(1)}";
// }


String dateformaterY_M_D(String datestring) {
  if (datestring == '') {
    return '';
  }
  return DateFormat('yyyy-MM-dd').format(DateTime.parse(datestring)).toString();
}



String Carddateformater(String datestring) {
  if (datestring == '') {
    return '';
  }
  return DateFormat(' MM / yy').format(DateTime.parse(datestring)).toString();
}

String cardFormater(String cardnumber) {
  // String card_number = "594533202111111806087119";
  String cardnumber1 = cardnumber.toString();
  List cardlist = cardnumber1.split('');
  if (cardnumber == '') {
    return '';
  }
  String result = "";
  String temporalresult1 = cardlist[0]+cardlist[1]+cardlist[2]+cardlist[3]+ " ";
  // String temporalresult2 = cardlist[4]+cardlist[5]+cardlist[6]+cardlist[7]+ " ";
  // String temporalresult3 = cardlist[8]+cardlist[9]+cardlist[10]+cardlist[11]+" ";
  String temporalresult2 = '**** ';
  String temporalresult4 = cardlist[12]+cardlist[13]+cardlist[14]+cardlist[15];
  result = temporalresult1+temporalresult2+temporalresult2+temporalresult4;
  // print(result);
  return result;
}


// extension CapExtension on String {
//   String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
//   String get allInCaps => this.toUpperCase();
//   // String get capitalizeFirstofEach => this.split(" ").map((str) => str.capitalize).join(" ");
// }