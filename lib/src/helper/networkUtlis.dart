import 'package:dio/dio.dart';
import 'package:fahs/src/screens/auth/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
// import '../screens/mainScreens/signup_or_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:t3myrkm/src/screens/auth/login_screen.dart';

class NetworkUtil {
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<Response> get(String url,
      {@required BuildContext context, Map headers}) async {
    var response;

    try {
      dio.options.baseUrl = "backend-domain";
      response = await dio.get(url, options: Options(headers: headers));

      print('bood :${response.data['error'] == null}');
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response: " + e.response.toString());
      } else {}
    }
    return response == null ? null : handleResponse(response, context);
  }

  Future<Response> post(String url,
      {@required BuildContext context,
      Map headers,
      FormData body,
      encoding}) async {
    var response;

    dio.options.baseUrl = "backend-domain";
    try {
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
        print("response: " + e.response.toString());
      } else {}
    }
    return response == null ? null : handleResponse(response, context);
  }

  Response handleResponse(Response response, BuildContext context) {
    final int statusCode = response.statusCode;
    print("response:" + response.toString());
    Future.delayed(Duration(milliseconds: 1), () async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      if (response.data['error'] != null) {
        print('ssdsdsdsd yup');
        if (response.data['error'][0]['key'] == 'token') {
          Fluttertoast.showToast(
              msg:
                  'انتهت جلسة التسجيل الخاصة بكم, يرجى إعادة التسجيل مرة أخرى');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (ctx) => LoginScreen(),
              ),
              (route) => false);
          await _prefs.clear().then((value) => print('done'));
          return;
        }
      }
    });
    if (statusCode >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }
}
