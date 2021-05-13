import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../models/changeData/change_password_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ChangePasswordProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();
  String currentPassword;
  String newPassword;
  String confirmPassword;
  SharedPreferences _prefs;
  Future<bool> changePassword(BuildContext context) async {
    
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'current_password': currentPassword,
      'new_password': newPassword,
      'password_confirmation': confirmPassword,
    };
    FormData formData = FormData.fromMap(map);

    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-change-password',
      headers: headers,
      body: formData,
      context: context,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        context: context,
        btnOnPress: () {},
      );
      return false;
    }
    var model = ChangePassewordModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: model.data.value,
      );
      return true;

    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
      return false;

    }
  }
}
