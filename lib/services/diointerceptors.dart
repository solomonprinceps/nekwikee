import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Logging extends dio.Interceptor {
  // LoginController login = LoginController();
  @override
  void onRequest( dio.RequestOptions options, dio.RequestInterceptorHandler handler) {
    print('request data  ${options.data}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(dio.Response response, dio.ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(dio.DioError err, dio.ErrorInterceptorHandler handler) async {
    // print('${err.response?.statusCode} sod');
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if(err.requestOptions.path.contains('/login')){
      return super.onError(err, handler);
    }
    if (err.response?.statusCode == 401) {
      print('I am 401');
      SharedPreferences authstorage = await SharedPreferences.getInstance();
      authstorage.remove('user');
      authstorage.remove('accessToken');
      Get.offAllNamed("/newsplash");
    }
    return super.onError(err, handler);
  }
}