import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../helper/networkUtlis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/general/rate_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ComplaintsProvider with ChangeNotifier {
  SharedPreferences _prefs;
  ProgressDialog _pr;
  NetworkUtil _util = NetworkUtil();
  CustomProgressDialog _customProgressDialog;

  Future<void> sendComplaint(BuildContext context,
      {String complaint, int orderId}) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'order_id': orderId,
      'complaint': complaint,
    };
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'post-complaint',
      context: context,
      headers: headers,
      body: FormData.fromMap(map),
    );
    await _customProgressDialog.hidePr();
    if (response == null) {
      await CustomDialog().showWarningDialog(
        msg: 'يرجى التحقق من الاتصال بالانترنت',
        btnOnPress: () {},
        context: context,
      );
      return;
    }
    var model = RateModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
    } else {
      Fluttertoast.showToast(
        msg: model.error[0].value,
        backgroundColor: Colors.red,
      );
    }
  }
}
