import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kwikee1/services/backend.dart';
import 'dart:convert';



class AuthController extends GetxController {
  Backend dioclient = Backend();
  var userdata = {}.obs;
  var inital = true.obs;
  var showbankstatementsetup = false.obs;
  var showapplyforcredit = false.obs;
  var continuecreditapply = false.obs;
  var showsetpin = false.obs;
  var hasloan = false.obs;
  var linkcard = false.obs;
  

  List transactions = [].obs;
  @override
  void onInit() {
    checkLogin();
    getusers();
    super.onInit();
  }

  checkLogin() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic token = authstorage.getString("accessToken").toString();
    if (token == null) {
      Get.offNamed("/login");
    }
  }


  getusers() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    String? user = authstorage.getString('user').toString();
    userdata.value = jsonDecode(user);
  }

  updateuserobj(var user) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
    getusers();
  }

  Future <dynamic> changepins(pindata) async {
    dynamic bodydata;
    await dioclient.pinchange(data: pindata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> updatepins(pindata) async {
    dynamic bodydata;
    await dioclient.updatechange(data: pindata).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> updatepassword(data) async {
    dynamic bodydata;
    await dioclient.updatepassword(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  Future <dynamic> dashbaord() async {
    dynamic bodydata;
    await dioclient.dashboardcredit().then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> calinkcard(String data) async {
    dynamic bodydata;
    await dioclient.calinkcard(data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }
  

  Future <dynamic> litetocredit(Map data) async {
    dynamic bodydata;
    await dioclient.transferlitetocredit(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }


  // calinkcard transferlitetocredit
} 