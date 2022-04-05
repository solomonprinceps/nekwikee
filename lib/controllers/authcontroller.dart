import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kwikee1/services/backend.dart';
import 'dart:convert';



class AuthController extends GetxController {
  Backend dioclient = Backend();
  var userdata = {}.obs;
  var inital = true.obs;
  var pagenumber = 15.obs;
  var showbankstatementsetup = false.obs;
  var showapplyforcredit = false.obs;
  var continuecreditapply = false.obs;
  var allowbio = false.obs;
  var showsetpin = false.obs;
  var hasloan = false.obs;
  var linkcard = false.obs;
  RxBool loading = false.obs;
  RxBool alloaded = false.obs;
  

  List transactions = [].obs;
  @override
  void onInit() {
    checkLogin();
    getusers();
    super.onInit();
  }


  changeStatus() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    if(allowbio.isTrue){
      allowbio.toggle();
      authstorage.setBool("allowauth", allowbio.value);
    }
    else {
      allowbio.value = true; //or pressedBool.toggle();
      authstorage.setBool("allowauth", allowbio.value);
    }
   
  }
  checkLogin() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic token = authstorage.getString("accessToken").toString();
    if (token == null) {
      Get.offNamed("/login");
    }
  }

  getallow() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic statess =  authstorage.getBool("allowauth");
    if (statess == null) {
      allowbio.value = false;
    }
    if (statess == true) {
      allowbio.value = true;
    }
    if (statess == true) {
      allowbio.value = false;
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
  
  Future<dynamic> notificateList() async {
    dynamic bodydata;
    await dioclient.notificateList().then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future <dynamic> updateToken(pindata) async {
    dynamic bodydata;
    await dioclient.updateToken(data: pindata).then((value) {
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

  Future <dynamic> listransaction({required Map data}) async {
    dynamic bodydata;
    loading.value = true;
    update();
    await dioclient.listransaction(data: data).then((value) {
      bodydata = value;
      loading.value = false;
      update();
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