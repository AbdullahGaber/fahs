import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../models/auth/mobile_register_model.dart';
import '../../../helper/networkUtlis.dart';
// import '../../../screens/auth/confirm_phone_screen.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class MobileRegisterProvider with ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  CustomProgressDialog _customProgressDialog;
  ProgressDialog _pr;
  String phone;
  Future<void> registerPhone(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(pr: _pr, context: context);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Map<String, dynamic> map = {
      'phone_number': phone,
    };
    if (Platform.isAndroid) {
      var appSignature = await SmsAutoFill().getAppSignature;
      map.addAll({
        'app_signature': appSignature,
      });
    }
    FormData data = FormData.fromMap(map);
    Response response = await _util.post(
      'register-mobile',
      body: data,
    );
    await _customProgressDialog.hidePr();

    if (response == null) {
      await _dialog.showWarningDialog(
        context: context,
        btnOnPress: () {},
        msg: 'يرجى التحقق من الاتصال بالإنترنت',
      );
      return;
    }
    var model = MobileRegisterModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: model.data);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (c) => ConfirmPhoneScreen(
          //   stateOfVerificationCode: 1,
          // ),
        ),
      );
    } else {
      await _dialog.showWarningDialog(
        btnOnPress: () {},
        context: context,
        msg: model.error[0].value,
      );
      return;
    }
  }
}
