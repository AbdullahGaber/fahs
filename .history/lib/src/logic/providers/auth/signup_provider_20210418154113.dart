import 'dart:io';

import 'package:fahs/src/screens/auth/login_screen.dart';
import 'package:fahs/src/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:t3myrkm/src/screens/auth/login_screen.dart';
// import 'package:t3myrkm/src/screens/tab_screen.dart';
import '../../models/auth/signup_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class SignupProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomProgressDialog _customProgressDialog;
  int type;
  String phone;
  String name = '';
  File image;
  String password = '';
  String passwordConfirmation = '';
  String email = '';
  String commercialRecord = '';
  File commercialImage;
  String serviceCost = '';

  Future<void> signUp(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    String deviceToken = await FirebaseMessaging().getToken();
    print('aaaa ${image.path}');
    Map<String, dynamic> map = {
      'type': type,
      'phone_number': phone,
      'name': name,
      'image': image == null ? null : await MultipartFile.fromFile(image.path),
      'password': password,
      'password_confirmation': passwordConfirmation,
      'device_token': deviceToken,
      'email': email,
    };
    if (type == 1) {
      map.addAll({
        // TODO : Add request key for signUp and 
        
      });
    }
    FormData formData = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post('user-register', body: formData);
    if (response == null) {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
        context: context,
      );
    }
    var model = SignupModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: type == 1
            ? 'تم تسجيل حسابك بنجاح وسيتم مراجعته من قبل الإدارة'
            : 'تم تسجيل حسابك بنجاح',
      );
      if (type == 0) {
        await _prefs.setString('type', model.data[0].type);
        await _prefs.setInt('active', model.data[0].active);
        await _prefs.setInt('id', model.data[0].id);
        await _prefs.setString('name', model.data[0].name);
        await _prefs.setString('phone', model.data[0].phoneNumber);
        await _prefs.setString('email', model.data[0].email);
        await _prefs.setString('image', model.data[0].image);
        await _prefs.setString('token', model.data[0].apiToken);
        await _prefs.setBool('blocked', model.data[0].blocked);
        await _prefs.setDouble('lat', model.data[0].latitude);
        await _prefs.setDouble('lon', model.data[0].longitude);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (c) => TabScreen(
                    type: 0,
                  )),
          (route) => false,
        );
        return;
      }

      await _customProgressDialog.hidePr();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
            ),
        (route) => false,
      );
    } else {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: model.error[0].value,
      );
      return;
    }
  }

  disposev() {
    name = '';
    image = null;
    password = '';
    passwordConfirmation = '';
    email = '';
    commercialRecord = '';
    commercialImage = null;
   
    notifyListeners();
  }
}
