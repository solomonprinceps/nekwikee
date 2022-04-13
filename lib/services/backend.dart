import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/diointerceptors.dart';
import 'package:path/path.dart';



class Backend {
  final Dio _dio = Dio()..interceptors.add(Logging());
  final _baseUrl = 'https://api.kwikee.app/api/';
  final _otptoken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBwLmNvbXBvdW5kLm5nXC9hcGlcL2dlbmVyYXRlLWtleSIsImlhdCI6MTYzNDI4NjAwNSwiZXhwIjoxNjY1ODIyMDA1LCJuYmYiOjE2MzQyODYwMDUsImp0aSI6Ind2UnBGT29XQkkzU0xUYmEiLCJzdWIiOjEsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.Tot25gMykOyfK8ZCGotI_6u1pu9BL4eKgfq57BqhVYs'; 
  authtoken() async {
    SharedPreferences authstorage = await SharedPreferences.getInstance();
    dynamic auth = authstorage.getString("accessToken").toString();
    return auth;
  }

  

  Future<dynamic> verifyotp({required Map data}) async {
    dynamic otpresponse;
    try {
      Response responseobj = await _dio.post(
        'https://api.kwikee.app/api/otp/verify',
        data: jsonEncode(data),
        options: Options(
          headers: {
            "authorization": _otptoken,
          },
        ),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) { 
      if (e.response != null) {
        otpresponse = e.response?.data;
      } else {
        otpresponse = {
          "status": "error",
          "message": "Network error."
        };
        return otpresponse;
      }
      return otpresponse;
    } 
    return otpresponse;
  }

  Future<dynamic> forgotpasswprd({required Map data}) async {
    dynamic responsedata;
    try {
      Response responseobj = await _dio.post(
        '${_baseUrl}user/account/forgotPassword',
        data: data,
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> banklist() async {
    dynamic otpresponse;
    try {
      Response responseobj = await _dio.get(
        'https://api.paystack.co/bank',
        options: Options(
          headers: {
            "authorization": 'Bearer pk_test_e180791ffcc5dc634416e80b4f57b012ef1de826',
          },
        ),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) { 
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        otpresponse = e.response?.data;
      } else {
        // print(e.requestOptions);
        // print(e.message);
        otpresponse = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return otpresponse;
      }
      return otpresponse;
    } 
    return otpresponse;
  }

  Future<dynamic> submitloanoffer({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}application/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future transferlitetocredit({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transfer/loan',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> dashboardcredit() async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.get(
        '${_baseUrl}customer/credit/view',
        // data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> listransaction({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transaction/list',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }
  
  Future singlesavings({required String data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.get(
        '${_baseUrl}customer/saving/one?investmentid=$data',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future submitKwikeerollover({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/rollover/request',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future editgoals({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/kwikgoals/edit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> calinkcard(String reference) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.get(
        '${_baseUrl}utilities/paystack/notification?reference='+reference,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      // print(responseobj.statusCode);
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> updateToken({required Map data}) async {
    dynamic otpresponse;
        try {
      Response responseobj = await _dio.post('${_baseUrl}customer/token-update',
        data: jsonEncode(data),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) { 
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        otpresponse = e.response?.data;
      } else {
        // print(e.requestOptions);
        // print(e.message);
        otpresponse = {
          "status": "error",
          "message": "Error occured (Network Connection)."
        };
        return otpresponse;
      }
      return otpresponse;
    } 
    return otpresponse;
  }




  Future<dynamic> signup({required Map data}) async {
    dynamic otpresponse;
    try {
      Response responseobj = await _dio.post('${_baseUrl}user/account/create',
        data: jsonEncode(data),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) { 
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        otpresponse = e.response?.data;
      } else {
        // print(e.requestOptions);
        // print(e.message);
        otpresponse = {
          "status": "error",
          "message": "Error occured (Network Connection)."
        };
        return otpresponse;
      }
      return otpresponse;
    } 
    return otpresponse;
  }

  Future<dynamic> login({required Map data}) async {
    dynamic otpresponse;
    try {
      Response responseobj = await _dio.post('${_baseUrl}user/account/login',
        data: jsonEncode(data),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) { 
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        otpresponse = e.response?.data;
      } else {
        otpresponse = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return otpresponse;
      }
      return otpresponse;
    } 
    return otpresponse;
  }

  Future<dynamic> sendotp({required Map data}) async {
    dynamic otpresponse;
    try {
      Response responseobj = await _dio.post(
        'https://api.kwikee.app/api/otp/generate',
        data: jsonEncode(data),
        options: Options(
          headers: {
            "authorization": _otptoken,
          },
        ),
      );
      otpresponse = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        otpresponse = e.response?.data;
      } else {
        // // Error due to setting up or sending the request
        Fluttertoast.showToast(
          msg:  e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
        );
        
        // return e.message;
      }
    }
    return otpresponse;
  }


  Future allsavings({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/saving/list',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  
  Future withsaving({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/withdraw/savings',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }



  Future withsavingkwik({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/withdraw/kwikmax',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  //   


  Future notificateList() async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/notification/list',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }
  

  Future notificatemarkseen(String id) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/notification/list?id=${id}&seen=true',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future transferlitetomax({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transfer/kwikmax',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future transferlitetogoals({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transfer/kwikgoals',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future createKwikeemax({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      
      Response responseobj = await _dio.post(
        '${_baseUrl}application/kwik/breakdown',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future createKwikgoal({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      
      Response responseobj = await _dio.post(
        '${_baseUrl}application/kwikgoals/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future createKwikeelite({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      
      Response responseobj = await _dio.post(
        '${_baseUrl}application/kwiklite/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future submitKwikeemax({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/kwikmax/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occured (Network Connection)"
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> start() async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.get(
        '${_baseUrl}application/start',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> getcompany() async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.get(
        '${_baseUrl}utilities/company/list',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

    Future<dynamic> addbvn({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/bvn',
        data: jsonEncode(data),
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      // print(responseobj.statusCode);
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> applynextofkin({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/nextofkin',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }  



  Future<dynamic> applypersonalinfo({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/personal',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> uploadLoadDocument({required var data}) async {
    dynamic responsedata;
    String fileName = data["file"].split('/').last;
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(data["file"], filename: fileName),
      "loan_id": data["loan_id"],
      "type": data["type"]
    });  
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/document/upload',
        data: formData,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
            "contentType": 'multipart/form-data'
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> uploadSelfie({required Map data, required var image}) async {
    dynamic responsedata;
    String fileName = data["passport"].split('/').last;
    var formData = FormData.fromMap({
      "passport_file": await MultipartFile.fromFile(data["passport"], filename: fileName),
      "passport": "dfmskld",
      "loan_id": data["loan_id"]
    });  
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/passport/store',
        data: formData,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
            "contentType": 'multipart/form-data'
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> applyemployer({required Map data}) async {
    dynamic responsedata;
    // String fileName = ;
    dynamic formImage = data["id_card"] == "" ? "" : await MultipartFile.fromFile(data["id_card"], filename: basename(data["id_card"]));
    // print(formImage.toString());
    // FormData().files.ad
    var formData = FormData.fromMap({
      "employer_name": data["employer_name"],
      "employment_start_date": data["employment_start_date"],
      "net_monthly_income": data["net_monthly_income"],
      "official_email": data["official_email"],
      "employment_type": data["employment_type"],
      "loan_id": data["loan_id"],
      "education_level": data["education_level"],
      "pay_date": data["pay_date"],
      "file": formImage,
      "type": '2'
    });
    // formData.files.add(formImage);
    // print('${formData.files[0].key}');
    

    // print(' ime ${formData.files} ${formData.fields} $fileName');
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/employment',
        data: formData,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
            "contentType": 'multipart/form-data'
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future<dynamic> applyaddbank({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/account',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future<dynamic> applysubmit({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      Response responseobj = await _dio.post(
        '${_baseUrl}application/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

    Future<dynamic> withdrawalinit({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/withdraw',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Network An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> getloanoffrer({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/loan/offer',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> acceptloanoffer({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}application/details/loan/offer/accept',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future pinchange({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}user/account/pin/create',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occoured."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future updatechange({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}user/account/pin/update',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occoured."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future updatepassword({required dynamic data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}user/account/reset',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "Error occoured."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future<dynamic> addfundGoals({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transfer/kwikmax',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  // Get Cashboack

  Future<dynamic> paycashbacklite({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/transfer/cashback',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future<dynamic> paycashbackcard({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}customer/card/cashback/charge',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future<dynamic> getcashback({required String data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.get(
        '${_baseUrl}application/cashback/offer?investmentid=$data',
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }

  Future recalculateCashback({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}application/cashback/calculate',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future submitCashback({required Map data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.post(
        '${_baseUrl}application/cashback/submit',
        data: data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }


  Future changeAutosave({required String data}) async {
    dynamic responsedata;
    try {
      String token = await authtoken();
      // print(token);
      Response responseobj = await _dio.get(
        '${_baseUrl}customer/auto-save/toggle?investmentid='+data,
        options: Options(
          headers: {
            "authorization": 'Bearer $token',
          },
        ),
      );
      responsedata = responseobj.data;
    } on DioError catch (e) {
      if (e.response != null) {
        // print('DATA: ${e.response?.data}'); 
        responsedata = e.response?.data;
      } else {
        responsedata = {
          "status": "error",
          "message": "An unknown error occured try again later."
        };
        return responsedata;
      }
      return responsedata;
    }
    return responsedata;
  }




}

//application/cashback/submit