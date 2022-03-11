import 'package:get/get.dart';
import 'package:kwikee1/services/backend.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LoginController extends GetxController {
  Backend backend = Backend();
  Map<String?, dynamic> finger = {
    "email": "",
    "pin": "",
  }.obs;

  Map<String?, String?> login = {
    "email": "",
    "pin": "",
  }.obs;
  
  Map<String?, String?> forgotpassword = {
    "emaail": ""
  };

  @override
  void onInit() {
    getfingerdata();
    super.onInit();
  }

  Future<dynamic> logincustomer() async {
    dynamic bodydata;
    await backend.login(data: login).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> forgotpass() async {
    dynamic bodydata;
    await backend.forgotpasswprd(data: forgotpassword).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> fingerlogincustomer() async {
    dynamic bodydata;
    await backend.login(data: finger).then((value) {
      bodydata = value;
    });
    return bodydata;
  }



  savefingerdata(String email, String password) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('firstmail', email);
    authstorage.setString('fingeremail', email);
    authstorage.setString('fingerpassword', password);
  }

  getfingerdata() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance(); 
    finger["email"] = authstorage.getString('fingeremail'); 
    finger["pin"] = authstorage.getString('fingerpassword');
  }

  firstmail() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic strmail = authstorage.getString('firstmail');
    return strmail;
  }

  logging(var user, String token) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
    authstorage.setBool('passgetstarted', true);
    authstorage.setString('accessToken', token);
  }

  updateuserobj(var user) async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    authstorage.setString('user', json.encode(user));
  }

  logout401() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance(); 
    authstorage.remove('user');
    authstorage.remove('accessToken');
    authstorage.remove('fingeremail');
    authstorage.remove('fingerpassword');
    Get.offNamed("login"); 
  }

}  

