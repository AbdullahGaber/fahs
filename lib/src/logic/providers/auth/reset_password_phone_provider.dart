import 'dart:io'show Platform;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:t3myrkm/src/screens/auth/confirm_phone_screen.dart';
import '../../models/auth/mobile_register_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';
import '../../../helper/networkUtlis.dart';

class ResetPasswordPhoneProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  CustomDialog _dialog = CustomDialog();
  NetworkUtil _util = NetworkUtil();
  String phone;

  Future<void> forgetPassword(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(
      pr: _pr,
      context: context,
    );
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
      'user-forget-password',
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
    var model = MobileRegisterModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (c) => ConfirmPhoneScreen(
          //   stateOfVerificationCode: 2,
          // ),
        ),
      );
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
    }
  }
}
