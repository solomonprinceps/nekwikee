import 'package:get/get.dart';
import 'package:kwikee1/services/backend.dart';

class SignupController extends GetxController {
  Backend backend = Backend();
  Map<String?, String?> sendotp = {
    'message': 'Use {{code}} to access your account',
    'duration': '10',
    'length': '4',
    'type': '2',
    'place_holder': '{{code}}',
    'phone_number': '',
  }.obs;

  Map<String?, String?> verification = {
    "otp_id": "",
    "otp": ""
  }.obs;

  Map<String?, String?> signup = {
    "email": "",
    "telephone": "",
    "bvn": DateTime.now().millisecondsSinceEpoch.toString(),
    "firstname": "",
    "lastname": "",
    "dob": "2000-11-12",
    "pin": "",
    "phone_id": ""
  }.obs;


  Future<dynamic> otpsend() async {
    dynamic bodydata;
    await backend.sendotp(data: sendotp).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> verifyotp () async {
    dynamic bodydata;
    await backend.verifyotp(data: verification).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> registercustomer(Map data) async {
    dynamic bodydata;
    await backend.signup(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

  Future<dynamic> forgotpass(Map data) async {
    dynamic bodydata;
    await backend.forgotpasswprd(data: data).then((value) {
      bodydata = value;
    });
    return bodydata;
  }

}