import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../models/auth/logout_model.dart';
import '../../../helper/networkUtlis.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class LogoutProvider with ChangeNotifier {
  SharedPreferences _prefs;
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();

  Future<void> logOut(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      context: context,
      pr: _pr,
    );
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-logout',
      headers: headers,
      context: context,
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await _dialog.showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        context: context,
        btnOnPress: () {},
      );
      return;
    }
    var model = LogoutModel.fromJson(response.data);
    if (response.statusCode == 200) {
      // TODO : add type variable to 
      Fluttertoast.showToast(msg: 'تم تسجيل الخروج بنجاح');
      await _prefs.clear();
      await _customProgressDialog.hidePr();
      Phoenix.rebirth(context);
    } else {
      await _customProgressDialog.hidePr();
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
    }
  }
}
