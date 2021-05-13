import 'package:cars_check_up/src/helper/networkUtlis.dart';
import 'package:cars_check_up/src/widgets/custom_new_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../models/auth/login_model.dart';
import '../../../widgets/custom_progress_dialog.dart';

class LoginProvider with ChangeNotifier {
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  CustomDialog _dialog = CustomDialog();
  Future<void> loginUser(
    BuildContext context,
    String phoneNumber,
    String password,
  ) async {
    FocusScope.of(context).unfocus();
    var deviceToken = await FirebaseMessaging().getToken();
    _pr = ProgressDialog(context);
    _prefs = await SharedPreferences.getInstance();
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );
    Map<String, dynamic> map = {
      'phone_number': phoneNumber,
      'password': password,
      'device_token': deviceToken,
    };
    FormData formData = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-login',
      body: formData,
      context: context,
    );

    if (response == null) {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        context: context,
        msg: 'يرجى التحقق من الاتصال بالإنترنت',
        btnOnPress: () {},
      );
      return;
    }
    var model = LoginModel.fromJson(response.data);
    notifyListeners();
    if (response.statusCode == 200) {
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
      if (_prefs.get('type') == 'مزود خدمة') {
        await _prefs.setString('city_name', model.data[0].cityName);
        await _prefs.setString('region_name', model.data[0].regionName);
        await _prefs.setInt('city_id', model.data[0].cityId);
        await _prefs.setInt('region_id', model.data[0].regionId);
        await _prefs.setString('com_image', model.data[0].commercialImage);
        await _prefs.setString('com_record', model.data[0].commercialRecord);
      }
      await _customProgressDialog.hidePr();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            // TODO : login user replace with your login
            ),
        (route) => false,
      );
    } else {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        context: context,
        msg: model.error[0].value,
        btnOnPress: () {},
      );
      return;
    }
  }
}
