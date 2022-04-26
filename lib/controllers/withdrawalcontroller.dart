import 'package:get/get.dart';
import 'package:kwikee1/services/backend.dart';
// import 'package:flutter/material.dart';


class WithdrawController extends GetxController {
  Backend dioclient = Backend();
  Map<String?, String?> withform = {
    "amount": "",
    "mode": "1",
    "narration": "",    
    "bankcode": "",
    "accountnumber": "",
    "loan_id": "",
    "transaction_pin": "",
    "beneficiary": ""
  }.obs;

  Map<String?, String?> sendotpdata = {
    'message': 'Use {{code}} to authorize your kwikee transaction',
    'duration': '10',
    'length': '4',
    'type': '3',
    'place_holder': '{{code}}',
    'phone_number': '',
    'email': ''
  }.obs;

  Future<dynamic> otpsend({required Map sendotpdata}) async {
    dynamic bodydata;
    await dioclient.sendotp(data: sendotpdata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> verifyotp ({required Map verification}) async {
    dynamic bodydata;
    await dioclient.verifyotp(data: verification).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  formatamount(String? amountSign) {
    List stringarry = amountSign != null ? amountSign.split('₦') : [];
    String numbpart = stringarry[1];
    List numbparyarr = numbpart.split(',');
    String repdata = numbparyarr.join();
    withform["amount"] = repdata;
  }

  // withdrawalinit

  Future <dynamic> withdrawalstart() async {
    dynamic bodydata;
    await dioclient.withdrawalinit(data: withform).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

}