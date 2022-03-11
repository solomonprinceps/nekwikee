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