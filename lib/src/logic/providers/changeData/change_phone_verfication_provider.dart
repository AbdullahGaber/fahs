import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/changeData/change_phone_verfication_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ChangePhoneVerficationProvider with ChangeNotifier {
  SharedPreferences _prefs;
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  String phone;
  String code;

  Future<void> phoneVerficate(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'phone_number': phone,
      'code': code,
    };
    FormData formData = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-check-code-change-phone-number',
      context: context,
      headers: headers,
      body: formData,
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
    var model = ChangePhoneVerficationModel.fromJson(response.data);
    if (response.statusCode == 200) {
      await _prefs.setString('phone', phone);
      Fluttertoast.showToast(msg: 'تم تغيير رقم الهاتف بنجاح');
      Navigator.of(context).pop();
    }else{
        await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
      return;
    }
  }
}
