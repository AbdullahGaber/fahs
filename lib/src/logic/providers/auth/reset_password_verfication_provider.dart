import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
// import 'package:t3myrkm/src/screens/auth/reset_password_screen.dart';
import '../../../helper/networkUtlis.dart';
import '../../models/auth/phone_verfication_model.dart';
import '../../../widgets/custom_new_dialog.dart';
import '../../../widgets/custom_progress_dialog.dart';

class ResetPasswordVerficationProvider with ChangeNotifier {
  ProgressDialog _pr;
  CustomProgressDialog _customProgressDialog;
  NetworkUtil _util = NetworkUtil();
  CustomDialog _dialog = CustomDialog();
  String phone;
  String code;
  Future<void> verficatePhone(BuildContext context) async {
    _pr = ProgressDialog(context);
    _customProgressDialog = CustomProgressDialog(context: context, pr: _pr);
    Map<String, dynamic> map = {
      'phone_number': phone,
      'code': code,
    };
    FormData formData = FormData.fromMap(map);
    _customProgressDialog.showProgressDialog();
    _customProgressDialog.showPr();
    Response response = await _util.post(
      'user-confirm-reset-code',
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
    var model = PhoneVerficationModel.fromJson(response.data);
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (c) => ResetPasswordScreen(),
        ),
      );
    } else {
      await _dialog.showWarningDialog(
        msg: model.error[0].value,
        context: context,
        btnOnPress: () {},
      );
      return;
    }
  }
}
