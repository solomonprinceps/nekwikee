import 'package:get/get.dart';
import 'package:kwikee1/services/backend.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyController extends GetxController {
  Backend dioclient = Backend();
  XFile? image;
  Map<String?, String?> bvndata = {
    "bvn": ""
  };
  Map<String?, String?> applyform = {
    "firstname": "",
    "lastname": "",
    "middlename": "",
    "email": "",
    "dob": "",
    "gender": "",
    "marital_status": "",
    "no_address": "",
    "kin_firstname": "",
    "kin_lastname": "",
    "kin_relationship": "",
    "kin_phone_number": "",
    "kin_address": "",
    "employment_status": "",
    "employment_startdate": "",
    "employment_details": "",
    "employment_amount": "",
    "bank_bvn": "",
    "bank_account_number": "",
    "bank_name": "",
    "password": ""
  }.obs;

  Map<String?, String?> personalinfo = {
    "title": '1',
    "marital_status": "",
    "dob": "",
    "loan_id": "",
    "gender": "",
    "address": "",
    "no_of_years_in_address": "" 
  }.obs;

  Map<String?, String?> nextofkindata = {
    "next_kin_firstname": "",
    "next_kin_lastname": "",
    "next_kin_telephone": "",
    "next_kin_address": "",
    "loan_id": "",
    "next_kin_relationship": ""
  }.obs;

  Map<String?, dynamic> employerdata = {
    "employer_name": "",
    "employment_start_date": "",
    "net_monthly_income": "",
    "id_card": "",
    "official_email": "",
    "employment_type": "",
    "other_employer_name": "",
    "loan_id": "",
    "education_level": "",
    "pay_date": ""
  }.obs;

  Map<String?, dynamic> password = {
     "loan_id": "",
    "passport": ""
  }.obs;

  Map<String?, String?> bankdata = {
    "income_account_bankcode": "",
    "income_account_number": "",
    "loan_id": ""
  }.obs;

 
  List companies = [];

  Future<dynamic> startapplication() async {
    dynamic bodydata;
    await dioclient.start().then((value) {
      bodydata = value;
      if (value["status"] == "success") {
        resetuserobj(value["user"]);
      }
    });
    return bodydata;
  }

  companieslist() async {
    // dynamic bodydata;
    companies.clear();
    await dioclient.getcompany().then((value) {
      value["companies"].forEach(
        (element) {
          companies.add(element);
        }
      );
    });
    // print(companies[0]);
    companies.add({
      'id': 200000,
      'company_id': 99,
      'company_name': "Others",
      'payday': ''
    });
    // return bodydata;
  }

  resetuserobj(Map user) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
  }

  Future<dynamic> addbvnapplication() async {
    dynamic bodydata;
    await dioclient.addbvn(data: bvndata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> applypersonalinfo() async {
    dynamic bodydata;
    await dioclient.applypersonalinfo(data: personalinfo).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> applynexofkin() async {
    dynamic bodydata;
    await dioclient.applynextofkin(data: nextofkindata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> applyemployment({required Map data}) async {
    dynamic bodydata;
    await dioclient.applyemployer(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> applybank() async {
    dynamic bodydata;
    await dioclient.applyaddbank(data: bankdata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> selfieupload() async {
    dynamic bodydata;
    // print(password);
    await dioclient.uploadSelfie(data: password, image: image).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> submitapplication() async {
    dynamic bodydata;
    await dioclient.applysubmit(data: bankdata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> acceptloanoffer({required Map data}) async {
    dynamic bodydata;
    await dioclient.acceptloanoffer(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> submitloanoffer({required Map data}) async {
    dynamic bodydata;
    await dioclient.submitloanoffer(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> loanoffer({required dynamic data}) async {
    dynamic bodydata;
    await dioclient.getloanoffrer(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  formatamount(String? amountSign) {
    List stringarry = amountSign != null ? amountSign.split('₦') : [];
    String numbpart = stringarry[1];
    List numbparyarr = numbpart.split(',');
    String repdata = numbparyarr.join();
    employerdata["net_monthly_income"] = repdata;
  }

}