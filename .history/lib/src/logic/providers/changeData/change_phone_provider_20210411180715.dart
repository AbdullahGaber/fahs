import 'dart:io';
import 'package:cars_check_up/src/logic/providers/changeData/change_phone_verfication_provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
// import 'package:t3myrkm/src/logic/providers/changeData/change_phone_verfication_provider.dart';
// import 'package:t3myrkm/src/screens/auth/confirm_phone_screen.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/changeData/change_phone_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ChangePhoneProvider with ChangeNotifier {
  ProgressDialog _pr;
  SharedPreferences _prefs;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  String phone;
  Future<void> changePhone(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    _prefs = await SharedPreferences.getInstance();
    String token = _prefs.get('token');
    Map<String, dynamic> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    Map<String, dynamic> map = {
      'phone_number': phone,
    };
    if (Platform.isAndroid) {
      var appSignature = await SmsAutoFill().getAppSignature;
      map.addAll({
        'app_signature': appSignature,
      });
    }
    FormData formData = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-change-phone-number',
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
      return;
    }
    var model = ChangePhoneModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Provider.of<ChangePhoneVerficationProvider>(context, listen: false)
          .phone = phone;
      Fluttertoast.showToast(msg: model.data.value);
      Navigator.of(context).push(
        MaterialPageRoute(
            // builder: (c) => ConfirmPhoneScreen(
            //   stateOfVerificationCode: 3,
            // ),
            ),
      );
    }
  }
}
